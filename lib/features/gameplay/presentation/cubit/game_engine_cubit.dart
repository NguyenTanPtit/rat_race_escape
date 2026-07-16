import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/game_event.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/turn_result.dart';
import '../../domain/usecases/apply_event_option_usecase.dart';
import '../../domain/usecases/process_next_month_usecase.dart';
import '../../domain/usecases/spend_on_leisure_usecase.dart';
import '../../domain/repositories/game_state_repository.dart';
import '../../domain/repositories/scenario_config_repository.dart';
import '../../domain/repositories/event_pool_repository.dart';
import '../../domain/factories/game_state_factory.dart';
import 'game_engine_state.dart';

@injectable
class GameEngineCubit extends Cubit<GameEngineState> {
  final ProcessNextMonthUseCase _processNextMonthUseCase;
  final ApplyEventOptionUseCase _applyEventOptionUseCase;
  final SpendOnLeisureUseCase _spendOnLeisureUseCase;
  final GameStateRepository _gameStateRepository;
  final ScenarioConfigRepository _scenarioConfigRepository;
  final EventPoolRepository _eventPoolRepository;
  bool _isProcessing = false;

  GameEngineCubit(
    this._processNextMonthUseCase,
    this._applyEventOptionUseCase,
    this._spendOnLeisureUseCase,
    this._gameStateRepository,
    this._scenarioConfigRepository,
    this._eventPoolRepository,
  ) : super(const GameEngineState.initial());

  /// Starts a new game by loading scenario config and building initial state.
  Future<void> startNewGame(Country country, String scenarioId) async {
    if (_isProcessing) return;
    _isProcessing = true;
    try {
      final config = await _scenarioConfigRepository.loadScenarioConfig(country, scenarioId);
      final initialState = GameStateFactory.fromConfig(config);
      emit(GameEngineState.playing(initialState));
      _gameStateRepository.saveGame(initialState);
    } catch (e) {
      emit(GameEngineState.error('Failed to start new game: $e'));
    } finally {
      _isProcessing = false;
    }
  }

  /// For testing purposes only. Use [startNewGame] in production.
  @visibleForTesting
  void startGame(GameState initialState) {
    emit(GameEngineState.playing(initialState));
    _gameStateRepository.saveGame(initialState);
  }
  
  /// Loads a saved game if it exists
  Future<void> loadGame() async {
    if (_isProcessing) return;
    _isProcessing = true;
    try {
      final state = await _gameStateRepository.loadGame();
      if (state != null) {
        final activeEvent = await _resolveActiveEvent(state);
        emit(GameEngineState.playing(state, const {}, null, activeEvent));
      }
    } catch (e) {
      emit(GameEngineState.error('Lỗi hệ thống: $e'));
    } finally {
      _isProcessing = false;
    }
  }

  Future<GameEvent?> _resolveActiveEvent(GameState gameState) async {
    if (gameState.currentEventId == null) return null;
    final pool = await _eventPoolRepository.loadEventPool(gameState.country, gameState.scenarioId);
    final def = pool.where((e) => e.event.id == gameState.currentEventId).firstOrNull;
    return def?.event;
  }

  /// Advances the game engine to the next month using the usecase pipeline.
  Future<void> nextMonth() async {
    if (state is! GameEnginePlaying) return;
    if (_isProcessing) {
      debugPrint('[GameEngineCubit] nextMonth early return: already processing');
      return;
    }
    
    final playingState = state as GameEnginePlaying;
    
    // Guard: Do not allow nextMonth if an event is currently active
    if (playingState.gameState.currentEventId != null) {
      debugPrint('[GameEngineCubit] nextMonth early return: currentEventId is not null (${playingState.gameState.currentEventId})');
      return;
    }

    _isProcessing = true;
    try {
      // Process the next month
      final result = await _processNextMonthUseCase.call(playingState.gameState);

      await _handleTurnResult(result, isFromNextMonth: true);
    } catch (e) {
      emit(GameEngineState.error('Lỗi hệ thống: $e'));
    } finally {
      _isProcessing = false;
    }
  }

  /// Applies the selected event option to the current game state.
  Future<void> chooseEventOption(String eventId, String optionId) async {
    if (state is! GameEnginePlaying) return;
    if (_isProcessing) {
      debugPrint('[GameEngineCubit] chooseEventOption early return: already processing');
      return;
    }
    
    final playingState = state as GameEnginePlaying;

    _isProcessing = true;
    try {
      final result = await _applyEventOptionUseCase.call(
        playingState.gameState,
        eventId,
        optionId,
      );

      await result.fold(
        (failure) async {
          debugPrint('[GameEngineCubit] chooseEventOption swallowed: ${failure.message}');
        },
        (turnResult) async {
          await _emitTurnResult(turnResult, isFromNextMonth: false);
        },
      );
    } catch (e) {
      emit(GameEngineState.error('Lỗi hệ thống: $e'));
    } finally {
      _isProcessing = false;
    }
  }

  /// Spend cash on leisure to reduce stress
  Future<void> spendOnLeisure(double amount) async {
    if (state is! GameEnginePlaying) return;
    if (_isProcessing) {
      debugPrint('[GameEngineCubit] spendOnLeisure early return: already processing');
      return;
    }
    final currentState = (state as GameEnginePlaying).gameState;

    _isProcessing = true;
    try {
      final result = _spendOnLeisureUseCase(currentState, amount);
      
      await result.fold(
        (failure) async {
          debugPrint('[GameEngineCubit] spendOnLeisure swallowed: ${failure.message}');
        },
        (turnResult) async {
          await _emitTurnResult(turnResult, isFromNextMonth: false);
        },
      );
    } catch (e) {
      emit(GameEngineState.error('Lỗi hệ thống: $e'));
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _handleTurnResult(Either<Failure, TurnResult> result, {bool isFromNextMonth = false}) async {
    await result.fold(
      (failure) async {
        emit(GameEngineState.error(failure.message));
      },
      (turnResult) async {
        await _emitTurnResult(turnResult, isFromNextMonth: isFromNextMonth);
      },
    );
  }

  Future<void> _emitTurnResult(TurnResult turnResult, {bool isFromNextMonth = false}) async {
    Set<String> oldUnlockedCards = {};
    MonthlySummaryDelta? monthlySummary;
    
    if (state is GameEnginePlaying) {
      final oldState = (state as GameEnginePlaying).gameState;
      oldUnlockedCards = oldState.unlockedInsightCardIds;
      
      if (isFromNextMonth) {
        monthlySummary = MonthlySummaryDelta(
          cashDelta: turnResult.state.cash - oldState.cash,
          stressDelta: turnResult.state.stress - oldState.stress,
          netWorthDelta: turnResult.state.netWorth - oldState.netWorth,
        );
      }
    } else if (state is GameEngineWon) {
      oldUnlockedCards = (state as GameEngineWon).finalState.unlockedInsightCardIds;
    } else if (state is GameEngineGameOver) {
      oldUnlockedCards = (state as GameEngineGameOver).finalState.unlockedInsightCardIds;
    }

    final newState = turnResult.state;
    final newlyUnlockedInsightCardIds = newState.unlockedInsightCardIds.difference(oldUnlockedCards);

    final activeEvent = await _resolveActiveEvent(newState);

    switch (turnResult) {
      case TurnContinued():
        emit(GameEngineState.playing(newState, newlyUnlockedInsightCardIds, monthlySummary, activeEvent));
        _gameStateRepository.saveGame(newState);
      case TurnWon():
        emit(GameEngineState.won(newState, newlyUnlockedInsightCardIds));
        _gameStateRepository.deleteSave();
      case TurnLost():
        emit(GameEngineState.gameOver(turnResult.reason, newState, newlyUnlockedInsightCardIds));
        _gameStateRepository.deleteSave();
    }
  }
}
