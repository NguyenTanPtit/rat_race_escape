import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../entities/game_state.dart';
import '../entities/turn_result.dart';
import 'calculate_cashflow_usecase.dart';
import 'generate_event_usecase.dart';
import 'process_loans_usecase.dart';
import 'update_metrics_usecase.dart';
import 'check_game_status_usecase.dart';
import 'check_behavioral_insights_usecase.dart';

@lazySingleton
class ProcessNextMonthUseCase {
  final CalculateCashflowUseCase _calculateCashflow;
  final ProcessLoansUseCase _processLoans;
  final UpdateMetricsUseCase _updateMetrics;
  final GenerateEventUseCase _generateEvent;
  final CheckGameStatusUseCase _checkGameStatus;
  final CheckBehavioralInsightsUseCase _checkBehavioralInsights;

  ProcessNextMonthUseCase(
    this._calculateCashflow,
    this._processLoans,
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
    );

    // d. Pass the state sequentially through the injected use cases (Pipeline).
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
