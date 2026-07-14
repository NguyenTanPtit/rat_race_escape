import '../entities/game_state.dart';
import '../entities/loan.dart';

class ProcessLoansUseCase {
  /// Loops through GameState.loans. 
  /// For each loan, calculates monthly interest (annual rate / 12) and adds to principal. 
  /// Subtracts minimumMonthlyPayment from GameState.cash.
  GameState call(GameState currentState) {
    double totalMinimumPayments = 0.0;
    List<Loan> updatedLoans = [];

    for (final loan in currentState.loans) {
      // Calculate monthly interest (interestRatePerYear is assumed to be a decimal like 0.05 for 5%)
      // If it's a percentage (like 5.0), you might need to divide by 100 first, 
      // but assuming it's correctly formatted as a decimal.
      final monthlyInterest = loan.principalAmount * (loan.interestRatePerYear / 12);
      
      // Add interest to principal, then subtract minimum payment
      final newPrincipal = loan.principalAmount + monthlyInterest - loan.minimumMonthlyPayment;
      
      totalMinimumPayments += loan.minimumMonthlyPayment;

      // Ensure principal doesn't go below 0
      final finalPrincipal = newPrincipal < 0 ? 0.0 : newPrincipal;

      updatedLoans.add(loan.copyWith(principalAmount: finalPrincipal));
    }

    final newCash = currentState.cash - totalMinimumPayments;

    return currentState.copyWith(
      cash: newCash,
      loans: updatedLoans,
    );
  }
}
