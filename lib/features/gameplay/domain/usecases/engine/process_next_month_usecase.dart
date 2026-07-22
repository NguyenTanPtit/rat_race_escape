import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';

@lazySingleton
class ProcessNextMonthUseCase {
  final CalculateCashflowUseCase _calculateCashflow;
  final ProcessLoansUseCase _processLoans;
  final UpdateMarketUseCase _updateMarket;
  final UpdateMetricsUseCase _updateMetrics;
  final GenerateEventUseCase _generateEvent;
  final CheckGameStatusUseCase _checkGameStatus;
  final CheckBehavioralInsightsUseCase _checkBehavioralInsights;

  ProcessNextMonthUseCase(
    this._calculateCashflow,
    this._processLoans,
    this._updateMarket,
    this._updateMetrics,
    this._generateEvent,
    this._checkGameStatus,
    this._checkBehavioralInsights,
  );

  /// Executes the core logic for advancing the game to the next month using a Pipeline pattern.
  Future<Either<Failure, TurnResult>> call(GameState currentState) async {
    // a. Increase currentMonth and ageInMonths by 1.
    // b. Reset currentEventId (activeEventId equivalent) to null.
    // c. Reset leisureReliefUsedThisMonth to 0.
    GameState state = currentState.copyWith(
      currentMonth: currentState.currentMonth + 1,
      ageInMonths: currentState.ageInMonths + 1,
      currentEventId: null,
      leisureReliefUsedThisMonth: 0,
      sideJobsWorkedThisMonth: 0,
    );

    // d. Pass the state sequentially through the injected use cases (Pipeline).
    state = _updateMarket(state);
    state = _calculateCashflow(state);
    state = _processLoans(state);
    state = _checkBehavioralInsights(state);
    state = _updateMetrics(state);
    state = await _generateEvent(state);

    // e. Check game status
    final turnResult = _checkGameStatus(state);

    // f. Return Either<Failure, TurnResult>
    return Right(turnResult);
  }
}
