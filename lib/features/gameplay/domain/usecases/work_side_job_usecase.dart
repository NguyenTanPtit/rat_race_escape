import 'dart:math' as math;
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../entities/game_state.dart';
import '../entities/turn_result.dart';
import 'check_game_status_usecase.dart';

@lazySingleton
class WorkSideJobUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  WorkSideJobUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state) {
    if (state.sideJobsWorkedThisMonth >= state.maxSideJobsPerMonth) {
      return Left(Failure('You have reached the maximum number of side jobs for this month'));
    }

    final newStress = math.min(100, state.stress + state.sideJobStress);
    final updatedState = state.copyWith(
      cash: state.cash + state.sideJobIncome,
      stress: newStress,
      sideJobsWorkedThisMonth: state.sideJobsWorkedThisMonth + 1,
    );

    return Right(_checkGameStatus(updatedState));
  }
}
