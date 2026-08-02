import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

/// Moves money into the savings account (instant, no fee).
@lazySingleton
class DepositSavingsUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  DepositSavingsUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, double amount) {
    if (state.savingsAnnualRate <= 0) {
      return Left(Failure('Savings account is not offered in this scenario'));
    }
    if (amount <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    if (amount > state.cash) {
      return Left(Failure('Not enough cash'));
    }
    final updatedState = state.copyWith(
      cash: state.cash - amount,
      savingsBalance: state.savingsBalance + amount,
    );
    return Right(_checkGameStatus(updatedState));
  }
}

/// Withdraws from savings back into cash (instant, no fee, no term).
@lazySingleton
class WithdrawSavingsUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  WithdrawSavingsUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, double amount) {
    if (amount <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    if (amount > state.savingsBalance + 0.01) {
      return Left(Failure('Not enough savings'));
    }
    final actual = amount > state.savingsBalance ? state.savingsBalance : amount;
    final updatedState = state.copyWith(
      cash: state.cash + actual,
      savingsBalance: state.savingsBalance - actual,
    );
    return Right(_checkGameStatus(updatedState));
  }
}
