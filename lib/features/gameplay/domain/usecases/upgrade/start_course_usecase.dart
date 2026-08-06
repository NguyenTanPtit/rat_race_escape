import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

/// Pays for a course up front and starts studying it.
///
/// Price at purchase time is baseCost × inflationIndex (studying early is
/// cheaper). One course at a time, each course only once; the stress cost and
/// the permanent salary boost are applied month by month in the engine
/// pipeline ([ProcessCourseStudyUseCase]).
@lazySingleton
class StartCourseUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  StartCourseUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, String courseId) {
    final course = state.courses.where((c) => c.id == courseId).firstOrNull;
    if (course == null) {
      return Left(Failure('Course is not offered in this scenario'));
    }
    if (state.completedCourseIds.contains(courseId)) {
      return Left(Failure('Course already completed'));
    }
    if (state.studyingCourseId != null) {
      return Left(Failure('Already studying another course'));
    }
    final cost = state.courseCost(course);
    if (cost > state.cash) {
      return Left(Failure('Not enough cash'));
    }
    final updatedState = state.copyWith(
      cash: state.cash - cost,
      studyingCourseId: course.id,
      studyingMonthsLeft: course.durationMonths,
    );
    return Right(_checkGameStatus(updatedState));
  }
}
