import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

/// Player-initiated mortgage-style borrowing — "nợ tốt", when used well.
///
/// Gatekeeping is the design: the bank demands a credit score (first real use
/// of that stat) AND collateral — total bank debt stays under
/// [GameState.bankLoanMaxLtv] of the portfolio's market value, so nobody
/// borrows with empty hands. At 10%/yr the loan LOSES money against the
/// index's 11% par yield after fees and risk — leverage only pays when
/// deployed into a deep crash. That asymmetry is intentional.
@lazySingleton
class TakeBankLoanUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  TakeBankLoanUseCase(this._checkGameStatus);

  /// Minimum monthly payment as a fraction of principal (2%/month).
  static const double minPaymentRate = 0.02;

  Either<Failure, TurnResult> call(GameState state, double amount) {
    if (state.bankLoanAnnualRate <= 0) {
      return Left(Failure('Bank lending is not offered in this scenario'));
    }
    if (state.creditScore < state.bankLoanMinCredit) {
      return Left(Failure(
          'Credit score too low: ${state.creditScore} < ${state.bankLoanMinCredit}'));
    }
    if (amount <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    if (amount > state.bankLoanHeadroom + 0.01) {
      return Left(Failure('Amount exceeds the collateral-based lending limit'));
    }

    final loan = Loan(
      id: 'bank_loan_${state.currentMonth}_${state.loans.length}',
      name: 'Vay thế chấp',
      principalAmount: amount,
      interestRatePerYear: state.bankLoanAnnualRate,
      minimumMonthlyPayment: amount * minPaymentRate,
      type: LoanType.mortgage,
    );

    final updatedState = state.copyWith(
      cash: state.cash + amount,
      loans: [...state.loans, loan],
    );
    return Right(_checkGameStatus(updatedState));
  }
}
