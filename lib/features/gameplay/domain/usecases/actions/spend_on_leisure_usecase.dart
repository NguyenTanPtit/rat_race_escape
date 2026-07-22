import 'dart:math';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

@lazySingleton
class SpendOnLeisureUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  SpendOnLeisureUseCase(this._checkGameStatus);

  /// Allows the player (or bot) to spend cash to reduce stress.
  Either<Failure, TurnResult> call(GameState state, double amount) {
    if (amount <= 0) {
      return Left(Failure('Amount must be positive.'));
    }

    if (amount > state.cash) {
      return Left(Failure('Not enough cash to spend on leisure.'));
    }

    final int maxStressReliefLeft = state.maxLeisureStressReliefPerMonth - state.leisureReliefUsedThisMonth;
    if (maxStressReliefLeft <= 0) {
      return Left(Failure('You have reached the maximum stress relief from leisure for this month.'));
    }

    // Calculate how much stress we can actually relieve with this amount
    final int possibleStressRelief = (amount / state.leisureCostPerStressPoint).floor();

    // The actual stress relief is the minimum of what we can afford, what is allowed this month, and current stress
    final int actualStressRelief = min(possibleStressRelief, min(maxStressReliefLeft, state.stress));

    if (actualStressRelief <= 0) {
      // Amount was too small to relieve even 1 point of stress, or stress is already 0
      // We still deduct the money because the user spent it. 
      // But wait, the spec says: "Trừ cash đúng bằng số stress thực sự giảm × leisureCostPerStressPoint (không trừ sạch tiền thừa)".
      // So if actualStressRelief == 0, we deduct 0 cash, but we shouldn't really allow spending 0 cash.
      // Let's just deduct actualStressRelief * rate.
      return Left(Failure('Amount too small to relieve stress or stress is already 0.'));
    }

    final double actualCashCost = actualStressRelief * state.leisureCostPerStressPoint;

    final GameState updatedState = state.copyWith(
      cash: state.cash - actualCashCost,
      stress: state.stress - actualStressRelief,
      leisureReliefUsedThisMonth: state.leisureReliefUsedThisMonth + actualStressRelief,
    );

    // Call check game status to see if spending this cash triggered bankruptcy (unlikely but required for consistency)
    final turnResult = _checkGameStatus(updatedState);
    return Right(turnResult);
  }
}
