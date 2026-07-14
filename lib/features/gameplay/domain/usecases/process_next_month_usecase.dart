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

@lazySingleton
class ProcessNextMonthUseCase {
  final CalculateCashflowUseCase _calculateCashflow;
  final ProcessLoansUseCase _processLoans;
  final UpdateMetricsUseCase _updateMetrics;
  final GenerateEventUseCase _generateEvent;
  final CheckGameStatusUseCase _checkGameStatus;

  ProcessNextMonthUseCase(
    this._calculateCashflow,
    this._processLoans,
    this._updateMetrics,
    this._generateEvent,
    this._checkGameStatus,
  );

  /// Executes the core logic for advancing the game to the next month using a Pipeline pattern.
  Either<Failure, TurnResult> call(GameState currentState) {
    // a. Increase currentMonth and ageInMonths by 1.
    // b. Reset currentEventId (activeEventId equivalent) to null.
    GameState state = currentState.copyWith(
      currentMonth: currentState.currentMonth + 1,
      ageInMonths: currentState.ageInMonths + 1,
      currentEventId: null,
    );

    // c. Pass the state sequentially through the injected use cases (Pipeline).
    state = _calculateCashflow(state);
    state = _processLoans(state);
    state = _updateMetrics(state);
    state = _generateEvent(state);

    // d. Check game status
    final turnResult = _checkGameStatus(state);

    // e. Return Either<Failure, TurnResult>
    return Right(turnResult);
  }
}
