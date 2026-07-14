import 'package:injectable/injectable.dart';
import '../entities/game_state.dart';
import '../entities/loan.dart';

@lazySingleton
class ProcessLoansUseCase {

  GameState call(GameState currentState) {
    double totalPayments = 0.0;
    List<Loan> updatedLoans = [];

    for (final loan in currentState.loans) {
      // Calculate monthly interest based on percentage (e.g., 5.5 for 5.5%)
      // Therefore divide by 100 to get decimal, then by 12 for monthly
      final monthlyInterest = loan.principalAmount * (loan.interestRatePerYear / 100 / 12);
      
      final totalDebt = loan.principalAmount + monthlyInterest;
      
      // If total debt is less than the minimum payment, we only pay the total debt
      final payment = totalDebt < loan.minimumMonthlyPayment ? totalDebt : loan.minimumMonthlyPayment;
      
      final newPrincipal = totalDebt - payment;

      totalPayments += payment;

      // Keep the loan if there is still a significant balance
      if (newPrincipal > 0.01) {
        updatedLoans.add(loan.copyWith(principalAmount: newPrincipal));
      }
    }

    final newCash = currentState.cash - totalPayments;

    return currentState.copyWith(
      cash: newCash,
      loans: updatedLoans,
    );
  }
}
