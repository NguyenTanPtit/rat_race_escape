import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/pending_proceed.dart';

@lazySingleton
class CalculateCashflowUseCase {
  /// Adds effectiveSalary (0 while job-loss suspension is active) and
  /// passiveIncome to cash, subtracts totalMonthlyOutflow (which already
  /// includes the health-insurance premium when active). Uses the SAME
  /// GameState getters the UI displays — one formula, one source.
  GameState call(GameState currentState) {
    // Settle maturing sale proceeds (liquidity delay).
    double matured = 0;
    final stillPending = <PendingProceed>[];
    for (final p in currentState.pendingProceeds) {
      final left = p.monthsLeft - 1;
      if (left <= 0) {
        matured += p.amount;
      } else {
        stillPending.add(p.copyWith(monthsLeft: left));
      }
    }

    final double newCash = currentState.cash +
        currentState.effectiveSalary +
        currentState.passiveIncome +
        matured -
        currentState.totalMonthlyOutflow;

    // Savings compound monthly, inside the savings balance itself.
    final double newSavings = currentState.savingsAnnualRate > 0
        ? currentState.savingsBalance * (1 + currentState.savingsAnnualRate / 12)
        : currentState.savingsBalance;

    return currentState.copyWith(
      cash: newCash,
      savingsBalance: newSavings,
      pendingProceeds: stillPending,
    );
  }
}
