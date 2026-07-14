import 'package:fpdart/fpdart.dart';
import '../entities/game_state.dart';
import 'calculate_cashflow_usecase.dart';
import 'generate_event_usecase.dart';
import 'process_loans_usecase.dart';
import 'update_metrics_usecase.dart';

/// A simple Failure class to wrap error messages
class Failure {
  final String message;

  Failure(this.message);
}

class ProcessNextMonthUseCase {
  final CalculateCashflowUseCase _calculateCashflow;
  final ProcessLoansUseCase _processLoans;
  final UpdateMetricsUseCase _updateMetrics;
  final GenerateEventUseCase _generateEvent;

  ProcessNextMonthUseCase(
    this._calculateCashflow,
    this._processLoans,
    this._updateMetrics,
    this._generateEvent,
  );

  /// Executes the core logic for advancing the game to the next month using a Pipeline pattern.
  Either<Failure, GameState> call(GameState currentState) {
    try {
      // a. Increase currentMonth and ageInMonths by 1.
      // b. Reset currentEventId (activeEventId equivalent) to null.
      GameState state = currentState.copyWith(
        currentMonth: currentState.currentMonth + 1,
        ageInMonths: currentState.ageInMonths + 1,
        currentEventId: null,
      );

      // c. Pass the state sequentially through the 4 injected use cases (Pipeline).
      state = _calculateCashflow(state);
      state = _processLoans(state);
      state = _updateMetrics(state);
      state = _generateEvent(state);

      // d. Return Either<Failure, GameState>
      return Right(state);
    } catch (e) {
      return Left(Failure('Failed to process next month: ${e.toString()}'));
    }
  }
}
