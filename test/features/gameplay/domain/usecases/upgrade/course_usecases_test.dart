import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/course_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/apply_inflation_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_course_study_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/upgrade/start_course_usecase.dart';

class EmptyEventPool implements EventPoolRepository {
  @override
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId,
          {String locale = 'vi'}) async =>
      [];
}

const english = CourseConfig(
  id: 'course_english',
  name: 'Chứng chỉ tiếng Anh',
  baseCost: 12000000,
  durationMonths: 6,
  stressPerMonth: 3,
  salaryBoostRate: 0.08,
);

const pro = CourseConfig(
  id: 'course_pro',
  name: 'Chứng chỉ nghề nâng cao',
  baseCost: 35000000,
  durationMonths: 12,
  stressPerMonth: 5,
  salaryBoostRate: 0.15,
);

GameState buildState({
  double cash = 50000000,
  double index = 1.0,
  int stress = 0,
  List<CourseConfig> courses = const [english, pro],
  Set<String> completed = const {},
  String? studyingId,
  int monthsLeft = 0,
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: cash,
    monthlyExpenses: 5000000,
    monthlyRent: 3500000,
    baseSalary: 11000000,
    stress: stress,
    inflationIndex: index,
    courses: courses,
    completedCourseIds: completed,
    studyingCourseId: studyingId,
    studyingMonthsLeft: monthsLeft,
  );
}

void main() {
  final start = StartCourseUseCase(CheckGameStatusUseCase());
  final study = ProcessCourseStudyUseCase();

  group('StartCourseUseCase', () {
    test('pays the course up front and starts studying', () {
      final result = start(buildState(), 'course_english');
      final state = result.getRight().toNullable()!.state;
      expect(state.cash, closeTo(50000000 - 12000000, 0.01));
      expect(state.studyingCourseId, 'course_english');
      expect(state.studyingMonthsLeft, 6);
      expect(state.completedCourseIds, isEmpty, reason: 'done only on graduation');
      expect(state.baseSalary, closeTo(11000000, 0.01),
          reason: 'boost only on graduation');
    });

    test('price at purchase = baseCost × inflationIndex (early study is cheaper)', () {
      final index = pow(1.035, 10).toDouble();
      final result = start(buildState(cash: 50000000, index: index), 'course_english');
      final state = result.getRight().toNullable()!.state;
      expect(state.cash, closeTo(50000000 - 12000000 * index, 0.01));
    });

    test('rejects a course id the scenario does not offer', () {
      expect(start(buildState(), 'course_nonexistent').isLeft(), isTrue);
      expect(start(buildState(courses: const []), 'course_english').isLeft(), isTrue);
    });

    test('rejects when already studying another course', () {
      final state = buildState(studyingId: 'course_english', monthsLeft: 3);
      expect(start(state, 'course_pro').isLeft(), isTrue);
    });

    test('rejects a course already completed — each course only once', () {
      final state = buildState(completed: {'course_english'});
      expect(start(state, 'course_english').isLeft(), isTrue);
    });

    test('rejects when cash cannot cover the inflated price', () {
      // 12tr base × index 1.2 = 14.4tr > 13tr cash (base price alone would fit).
      final state = buildState(cash: 13000000, index: 1.2);
      expect(start(state, 'course_english').isLeft(), isTrue);
    });
  });

  group('ProcessCourseStudyUseCase', () {
    test('no-op when nothing is being studied', () {
      final state = buildState();
      expect(study(state), same(state));
    });

    test('each study month costs stress and ticks the counter down', () {
      final state = buildState(studyingId: 'course_english', monthsLeft: 6, stress: 10);
      final after = study(state);
      expect(after.studyingMonthsLeft, 5);
      expect(after.stress, 13);
      expect(after.studyingCourseId, 'course_english');
      expect(after.baseSalary, closeTo(11000000, 0.01));
    });

    test('graduation: permanent salary boost, course locked as completed', () {
      final state = buildState(studyingId: 'course_english', monthsLeft: 1, stress: 10);
      final after = study(state);
      expect(after.studyingCourseId, isNull);
      expect(after.studyingMonthsLeft, 0);
      expect(after.completedCourseIds, contains('course_english'));
      expect(after.baseSalary, closeTo(11000000 * 1.08, 0.01));
      expect(after.stress, 13, reason: 'the last study month still costs stress');
    });

    test('stress from studying clamps at 100', () {
      final state = buildState(studyingId: 'course_english', monthsLeft: 3, stress: 99);
      expect(study(state).stress, 100);
    });

    test('a full 6-month course costs exactly 6 stress hits and one boost', () {
      var state = start(buildState(stress: 0), 'course_english')
          .getRight().toNullable()!.state;
      for (var month = 1; month <= 6; month++) {
        state = study(state);
      }
      expect(state.stress, 18);
      expect(state.completedCourseIds, {'course_english'});
      expect(state.baseSalary, closeTo(11000000 * 1.08, 0.01));
      // The second course is still available afterwards.
      final second = start(state.copyWith(cash: 50000000), 'course_pro');
      expect(second.isRight(), isTrue);
    });
  });

  group('Course study through the real pipeline', () {
    ProcessNextMonthUseCase buildNext() => ProcessNextMonthUseCase(
          CalculateCashflowUseCase(),
          ProcessLoansUseCase(),
          UpdateMarketUseCase(Random(1)),
          UpdateMetricsUseCase(),
          GenerateEventUseCase(EmptyEventPool(), Random(1)),
          CheckGameStatusUseCase(),
          CheckBehavioralInsightsUseCase(),
          ApplyInflationUseCase(),
          ProcessCourseStudyUseCase(),
        );

    test('boosted salary is first PAID the month after graduation', () async {
      final next = buildNext();
      // Studying with 1 month left; this month's paycheck is still the old one.
      var state = buildState(
          cash: 100000000, studyingId: 'course_english', monthsLeft: 1);
      final oldOutflow = state.totalMonthlyOutflow;

      final month1 = (await next(state)).getRight().toNullable()!.state;
      expect(month1.completedCourseIds, contains('course_english'));
      expect(month1.cash - state.cash, closeTo(11000000 - oldOutflow, 0.01),
          reason: 'graduation month is paid at the OLD salary');

      final month2 = (await next(month1)).getRight().toNullable()!.state;
      expect(month2.cash - month1.cash,
          closeTo(11000000 * 1.08 - oldOutflow, 0.01),
          reason: 'the month after graduation is paid at the NEW salary');
    });

    test('N-month course = exactly N months of study stress', () async {
      final next = buildNext();
      var state = buildState(
          cash: 500000000, studyingId: 'course_english', monthsLeft: 6);
      var stressHits = 0;
      for (var i = 0; i < 8; i++) {
        final before = state.studyingCourseId != null;
        state = (await next(state)).getRight().toNullable()!.state;
        if (before) stressHits++;
        if (state.studyingCourseId == null && before) break;
      }
      expect(stressHits, 6);
      expect(state.completedCourseIds, contains('course_english'));
    });
  });
}
