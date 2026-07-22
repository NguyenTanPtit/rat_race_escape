import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

@lazySingleton
class PayDebtUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  PayDebtUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, String loanId, double amount) {
    if (amount <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    if (amount > state.cash) {
      return Left(Failure('Not enough cash'));
    }

    final loanIndex = state.loans.indexWhere((l) => l.id == loanId);
    if (loanIndex == -1) {
      return Left(Failure('Loan not found'));
    }

    final loan = state.loans[loanIndex];
    
    if (amount > loan.principalAmount) {
      return Left(Failure('Amount cannot exceed loan principal'));
    }
    
    final actualPayment = amount;
    
    final updatedLoan = loan.copyWith(
      principalAmount: loan.principalAmount - actualPayment,
    );

    final updatedLoans = List.of(state.loans);
    if (updatedLoan.principalAmount < 0.01) {
      updatedLoans.removeAt(loanIndex);
    } else {
      updatedLoans[loanIndex] = updatedLoan;
    }

    // Rule: if extra payment on credit card, reset consecutiveMinimumCreditCardPayments
    int updatedConsecutive = state.consecutiveMinimumCreditCardPayments;
    if (loan.type == LoanType.creditCard) {
      updatedConsecutive = 0;
    }

    final updatedState = state.copyWith(
      cash: state.cash - actualPayment,
      loans: updatedLoans,
      consecutiveMinimumCreditCardPayments: updatedConsecutive,
    );

    return Right(_checkGameStatus(updatedState));
  }
}
