import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';

/// Advances the course being studied by one month.
///
/// Every studying month costs stress; when the last month ticks down the
/// player graduates: permanent salary boost, course locked as completed.
/// Runs AFTER CalculateCashflow (like the job-loss tick), so a course of N
/// months means exactly N stressful months and the raised salary is first
/// paid the month after graduation.
@lazySingleton
class ProcessCourseStudyUseCase {
  GameState call(GameState currentState) {
    final course = currentState.studyingCourse;
    if (course == null) return currentState;

    final monthsLeft = currentState.studyingMonthsLeft - 1;
    final stress = (currentState.stress + course.stressPerMonth).clamp(0, 100);

    if (monthsLeft > 0) {
      return currentState.copyWith(
        studyingMonthsLeft: monthsLeft,
        stress: stress,
      );
    }

    // Graduation.
    return currentState.copyWith(
      studyingCourseId: null,
      studyingMonthsLeft: 0,
      stress: stress,
      baseSalary: currentState.baseSalary * (1 + course.salaryBoostRate),
      completedCourseIds: {...currentState.completedCourseIds, course.id},
    );
  }
}
