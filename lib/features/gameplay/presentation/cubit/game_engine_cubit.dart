import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/game_event.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/turn_result.dart';
import '../../domain/usecases/events/apply_event_option_usecase.dart';
import '../../domain/usecases/market/buy_market_asset_usecase.dart';
import '../../domain/usecases/engine/process_next_month_usecase.dart';
import '../../domain/usecases/market/sell_market_asset_usecase.dart';
import '../../domain/usecases/actions/spend_on_leisure_usecase.dart';
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
  final BuyMarketAssetUseCase _buyMarketAssetUseCase;
  final SellMarketAssetUseCase _sellMarketAssetUseCase;
  bool _isProcessing = false;
  
  final List<MonthlyHistoryRecord> _historyBuffer = [];
  bool _stopAdvanceRequested = false;
  double _prevMonthCashDelta = 0.0;

  GameEngineCubit(
    this._processNextMonthUseCase,
    this._applyEventOptionUseCase,
    this._spendOnLeisureUseCase,
    this._gameStateRepository,
    this._scenarioConfigRepository,
    this._eventPoolRepository,
    this._buyMarketAssetUseCase,
    this._sellMarketAssetUseCase,
  ) : super(const GameEngineState.initial());

  Future<void> startNewGame(Country country, String scenarioId) async {
    if (_isProcessing) return;
    _isProcessing = true;
    try {
      _prevMonthCashDelta = 0.0;
      final config = await _scenarioConfigRepository.loadScenarioConfig(country, scenarioId);
      final initialState = GameStateFactory.fromConfig(config);
      _historyBuffer.clear();
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
      _prevMonthCashDelta = 0.0;
      final state = await _gameStateRepository.loadGame();
      if (state != null) {
        _historyBuffer.clear();
        final activeEvent = await _resolveActiveEvent(state);
        emit(GameEngineState.playing(state, const {}, null, activeEvent));
      }
    } catch (e) {
      emit(GameEngineState.error('Lỗi hệ thống: $e'));
    } finally {
      _isProcessing = false;
    }
  }

  // Crossing thresholds for market stop conditions (same pattern as stress 75/90).
  static const double _crashStop1 = 0.20;
  static const double _crashStop2 = 0.40;
  static const double _boomStopRatio = 1.25;

  /// Detects a market move worth stopping for: drawdown crossing 20%/40%
  /// from peak, or price crossing 25% above the trailing 12-month average.
  MarketStopInfo? _detectMarketStop(GameState oldState, GameState newState) {
    for (final entry in newState.market.entries) {
      final oldCls = oldState.market[entry.key];
      if (oldCls == null) continue;
      final newCls = entry.value;

      final crossedCrash = (oldCls.drawdown < _crashStop1 && newCls.drawdown >= _crashStop1) ||
          (oldCls.drawdown < _crashStop2 && newCls.drawdown >= _crashStop2);
      if (crossedCrash) {
        return MarketStopInfo(
          classId: newCls.classId,
          className: newCls.name,
          kind: MarketStopKind.crash,
          changePercent: newCls.drawdown * 100,
        );
      }

      if (oldCls.trailingRatio < _boomStopRatio && newCls.trailingRatio >= _boomStopRatio) {
        return MarketStopInfo(
          classId: newCls.classId,
          className: newCls.name,
          kind: MarketStopKind.boom,
          changePercent: (newCls.trailingRatio - 1) * 100,
        );
      }
    }
    return null;
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

  void clearNewlyUnlockedCards() {
    if (state is GameEnginePlaying) {
      emit((state as GameEnginePlaying).copyWith(newlyUnlockedInsightCardIds: {}));
    }
  }

  void stopAutoAdvance() {
    _stopAdvanceRequested = true;
    if (_isProcessing) return;
    
    if (state is GameEnginePlaying) {
      final playingState = state as GameEnginePlaying;
      if (playingState.isAutoAdvancing) {
        emit(playingState.copyWith(isAutoAdvancing: false));
      }
    }
  }

  Future<void> autoAdvance({
    Duration tick = const Duration(milliseconds: 250),
    double? targetCash,
    double? targetNetWorth,
    int? targetAge,
  }) async {
    if (state is! GameEnginePlaying) return;
    if ((state as GameEnginePlaying).isAutoAdvancing) return;

    _stopAdvanceRequested = false;
    
    // Set advancing flag and clear any left-over stop condition UI data (like Tet recap)
    emit((state as GameEnginePlaying).copyWith(
      isAutoAdvancing: true,
      yearlyRecap: null,
      newlyUnlockedInsightCardIds: {},
      marketStopInfo: null,
    ));

    while (!_stopAdvanceRequested && state is GameEnginePlaying) {
      final playingState = state as GameEnginePlaying;
      
      // Stop conditions evaluated BEFORE next tick
      if (playingState.gameState.currentEventId != null) {
        stopAutoAdvance();
        break;
      }
      if (playingState.newlyUnlockedInsightCardIds.isNotEmpty) {
        stopAutoAdvance();
        break;
      }
      if (playingState.yearlyRecap != null) {
        stopAutoAdvance();
        break;
      }
      if (playingState.marketStopInfo != null) {
        stopAutoAdvance();
        break;
      }
      if (targetCash != null && playingState.gameState.cash >= targetCash) {
        stopAutoAdvance();
        break;
      }
      if (targetNetWorth != null && playingState.gameState.netWorth >= targetNetWorth) {
        stopAutoAdvance();
        break;
      }
      if (targetAge != null && playingState.gameState.ageInMonths >= targetAge) {
        stopAutoAdvance();
        break;
      }

      await Future.delayed(tick);
      if (_stopAdvanceRequested) break; // Check again after delay
      
      await nextMonth();
    }

    if (state is GameEnginePlaying) {
      final finalState = (state as GameEnginePlaying).gameState;
      // Note: isAutoAdvancing is already set to false by stopAutoAdvance if it was called.
      // But if loop naturally ended, we ensure it's false.
      if ((state as GameEnginePlaying).isAutoAdvancing) {
        emit((state as GameEnginePlaying).copyWith(isAutoAdvancing: false));
      }
      _gameStateRepository.saveGame(finalState);
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

  /// Buys [amount] worth of the market asset class at the current price.
  Future<void> buyMarketAsset(String classId, double amount) async {
    if (state is! GameEnginePlaying) return;
    if (_isProcessing) {
      debugPrint('[GameEngineCubit] buyMarketAsset early return: already processing');
      return;
    }
    final currentState = (state as GameEnginePlaying).gameState;

    _isProcessing = true;
    try {
      final result = _buyMarketAssetUseCase(currentState, classId, amount);
      await result.fold(
        (failure) async {
          debugPrint('[GameEngineCubit] buyMarketAsset swallowed: ${failure.message}');
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

  /// Sells up to [amount] (market value) of the market holding.
  Future<void> sellMarketAsset(String classId, double amount) async {
    if (state is! GameEnginePlaying) return;
    if (_isProcessing) {
      debugPrint('[GameEngineCubit] sellMarketAsset early return: already processing');
      return;
    }
    final currentState = (state as GameEnginePlaying).gameState;

    _isProcessing = true;
    try {
      final result = _sellMarketAssetUseCase(currentState, classId, amount);
      await result.fold(
        (failure) async {
          debugPrint('[GameEngineCubit] sellMarketAsset swallowed: ${failure.message}');
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

  /// Clears the market stop dialog data after the UI has shown it.
  void clearMarketStop() {
    if (state is GameEnginePlaying) {
      emit((state as GameEnginePlaying).copyWith(marketStopInfo: null));
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
    bool isAutoAdvancing = false;
    YearlyRecap? currentYearlyRecap;
    MarketStopInfo? currentMarketStop;
    if (state is GameEnginePlaying) {
      final playingState = state as GameEnginePlaying;
      final oldState = playingState.gameState;
      oldUnlockedCards = oldState.unlockedInsightCardIds;
      isAutoAdvancing = playingState.isAutoAdvancing;
      currentYearlyRecap = playingState.yearlyRecap;
      currentMarketStop = playingState.marketStopInfo;
      
      if (isFromNextMonth) {
        // Calculate cashIn and cashOut based on oldState as requested
        // Tiền event/Phase-3 KHÔNG tách vào in/out.
        final cashIn = oldState.baseSalary + oldState.passiveIncome;
        final minPayments = oldState.loans.fold(0.0, (sum, loan) => sum + loan.minimumMonthlyPayment);
        final cashOut = oldState.totalMonthlyOutflow + minPayments;
        
        final currentCashDelta = turnResult.state.cash - oldState.cash;
        
        // Accumulate if advancing, else overwrite
        if (isAutoAdvancing && playingState.monthlySummary != null) {
           monthlySummary = MonthlySummaryDelta(
             cashDelta: playingState.monthlySummary!.cashDelta + currentCashDelta,
             stressDelta: playingState.monthlySummary!.stressDelta + (turnResult.state.stress - oldState.stress),
             netWorthDelta: playingState.monthlySummary!.netWorthDelta + (turnResult.state.netWorth - oldState.netWorth),
             cashIn: playingState.monthlySummary!.cashIn + cashIn,
             cashOut: playingState.monthlySummary!.cashOut + cashOut,
           );
        } else {
           monthlySummary = MonthlySummaryDelta(
             cashDelta: currentCashDelta,
             stressDelta: turnResult.state.stress - oldState.stress,
             netWorthDelta: turnResult.state.netWorth - oldState.netWorth,
             cashIn: cashIn,
             cashOut: cashOut,
           );
        }

        // Add to history buffer
        _historyBuffer.add((
          ageInMonths: oldState.ageInMonths,
          netWorth: oldState.netWorth,
          cashIn: cashIn,
          cashOut: cashOut,
          cashDelta: currentCashDelta,
          eventId: turnResult.state.currentEventId,
        ));
        
        // Check dynamic stop conditions
        if (isAutoAdvancing) {
          if (oldState.stress < 75 && turnResult.state.stress >= 75) {
            stopAutoAdvance(); // Stress crossed 75
          } else if (oldState.stress < 90 && turnResult.state.stress >= 90) {
            stopAutoAdvance(); // Stress crossed 90
          } else if ((currentCashDelta - _prevMonthCashDelta).abs() > 0.3 * oldState.totalMonthlyOutflow) {
            stopAutoAdvance(); // Cashflow jump
          }
        }

        // Market stop conditions (crossing-based, like stress).
        // Evaluated regardless of monthlySummary so the dialog also shows on
        // a manual end-turn that lands exactly on the crossing month.
        final marketStop = _detectMarketStop(oldState, turnResult.state);
        if (marketStop != null) {
          currentMarketStop = marketStop;
          if (isAutoAdvancing) stopAutoAdvance();
        }
        
        _prevMonthCashDelta = currentCashDelta;
        
        // Tet Yearly Recap
        if (turnResult.state.calendarMonth == 1) {
          if (isAutoAdvancing) stopAutoAdvance();
          
          final last12 = _historyBuffer.length > 12 ? _historyBuffer.sublist(_historyBuffer.length - 12) : _historyBuffer.toList();
          final topEvents = last12.where((e) => e.eventId != null).toList()
            ..sort((a, b) {
              final impactA = (a.cashDelta - (a.cashIn - a.cashOut)).abs();
              final impactB = (b.cashDelta - (b.cashIn - b.cashOut)).abs();
              return impactB.compareTo(impactA);
            });
          
          currentYearlyRecap = YearlyRecap(
            totalCashIn: last12.fold(0.0, (sum, e) => sum + e.cashIn),
            totalCashOut: last12.fold(0.0, (sum, e) => sum + e.cashOut),
            topEvents: topEvents.take(3).toList(),
            fullHistory: last12,
          );
        }
      }
    } else if (state is GameEngineWon) {
      oldUnlockedCards = (state as GameEngineWon).finalState.unlockedInsightCardIds;
    } else if (state is GameEngineGameOver) {
      oldUnlockedCards = (state as GameEngineGameOver).finalState.unlockedInsightCardIds;
    }

    final newState = turnResult.state;
    var newlyUnlockedInsightCardIds = newState.unlockedInsightCardIds.difference(oldUnlockedCards);
    if (state is GameEnginePlaying && isAutoAdvancing) {
      newlyUnlockedInsightCardIds = newlyUnlockedInsightCardIds.union((state as GameEnginePlaying).newlyUnlockedInsightCardIds);
    }

    final activeEvent = await _resolveActiveEvent(newState);

    switch (turnResult) {
      case TurnContinued():
        emit(GameEngineState.playing(newState, newlyUnlockedInsightCardIds, monthlySummary, activeEvent, isAutoAdvancing, currentYearlyRecap, currentMarketStop));
        if (!isAutoAdvancing) _gameStateRepository.saveGame(newState);
      case TurnWon():
        stopAutoAdvance();
        emit(GameEngineState.won(newState, newlyUnlockedInsightCardIds));
        _gameStateRepository.deleteSave();
      case TurnLost():
        stopAutoAdvance();
        emit(GameEngineState.gameOver(turnResult.reason, newState, newlyUnlockedInsightCardIds));
        _gameStateRepository.deleteSave();
    }
  }
}
