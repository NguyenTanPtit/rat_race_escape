import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/turn_result.dart';
import '../../domain/usecases/apply_event_option_usecase.dart';
import '../../domain/usecases/process_next_month_usecase.dart';
import '../../domain/usecases/spend_on_leisure_usecase.dart';
import 'game_engine_state.dart';

@injectable
class GameEngineCubit extends Cubit<GameEngineState> {
  final ProcessNextMonthUseCase _processNextMonthUseCase;
  final ApplyEventOptionUseCase _applyEventOptionUseCase;
  final SpendOnLeisureUseCase _spendOnLeisureUseCase;

  GameEngineCubit(
    this._processNextMonthUseCase,
    this._applyEventOptionUseCase,
    this._spendOnLeisureUseCase,
  ) : super(const GameEngineState.initial());

  /// Starts the game by emitting the playing state with the initial data.
  void startGame(GameState initialState) {
    emit(GameEngineState.playing(initialState));
  }

  /// Advances the game engine to the next month using the usecase pipeline.
  Future<void> nextMonth() async {
    if (state is! GameEnginePlaying) return;
    
    final playingState = state as GameEnginePlaying;

    // Process the next month
    final result = await _processNextMonthUseCase.call(playingState.gameState);

    _handleTurnResult(result);
  }

  /// Applies the selected event option to the current game state.
  Future<void> chooseEventOption(String eventId, String optionId) async {
    if (state is! GameEnginePlaying) return;
    
    final playingState = state as GameEnginePlaying;

    final result = await _applyEventOptionUseCase.call(
      playingState.gameState,
      eventId,
      optionId,
    );

    result.fold(
      (failure) {
        // Ignored: keep playing state without emitting error (e.g. double tap)
      },
      (turnResult) {
        _emitTurnResult(turnResult);
      },
    );
  }

  /// Spend cash on leisure to reduce stress
  void spendOnLeisure(double amount) {
    if (state is! GameEnginePlaying) return;
    final currentState = (state as GameEnginePlaying).gameState;

    final result = _spendOnLeisureUseCase(currentState, amount);
    
    result.fold(
      (failure) {},
      (turnResult) {
        _emitTurnResult(turnResult);
      },
    );
  }

  void _handleTurnResult(Either<Failure, TurnResult> result) {
    result.fold(
      (failure) {
        emit(GameEngineState.error(failure.message));
      },
      (turnResult) {
        _emitTurnResult(turnResult);
      },
    );
  }

  void _emitTurnResult(TurnResult turnResult) {
    switch (turnResult) {
      case TurnContinued():
        emit(GameEngineState.playing(turnResult.state));
      case TurnWon():
        emit(GameEngineState.won(turnResult.state));
      case TurnLost():
        emit(GameEngineState.gameOver(turnResult.reason, turnResult.state));
    }
  }
}
