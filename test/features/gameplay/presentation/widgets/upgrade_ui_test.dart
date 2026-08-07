import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/course_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/upgrade_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';

class MockGameEngineCubit extends Mock implements GameEngineCubit {}

const courses = [
  CourseConfig(
    id: 'course_english',
    name: 'Chứng chỉ tiếng Anh',
    baseCost: 12000000,
    durationMonths: 6,
    stressPerMonth: 3,
    salaryBoostRate: 0.08,
  ),
  CourseConfig(
    id: 'course_pro',
    name: 'Chứng chỉ nghề nâng cao',
    baseCost: 35000000,
    durationMonths: 12,
    stressPerMonth: 5,
    salaryBoostRate: 0.15,
  ),
  CourseConfig(
    id: 'course_master',
    name: 'Văn bằng sau đại học',
    baseCost: 90000000,
    durationMonths: 24,
    stressPerMonth: 6,
    salaryBoostRate: 0.25,
  ),
];

GameState buildGameState({
  double cash = 50000000,
  double index = 1.0,
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
    inflationAnnualRate: 0.035,
    salaryGrowthAnnualRate: 0.03,
    inflationIndex: index,
    courses: courses,
    completedCourseIds: completed,
    studyingCourseId: studyingId,
    studyingMonthsLeft: monthsLeft,
  );
}

void main() {
  late MockGameEngineCubit mockCubit;

  setUp(() {
    mockCubit = MockGameEngineCubit();
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget wrap(Widget child) {
    return MaterialApp(
      home: BlocProvider<GameEngineCubit>.value(value: mockCubit, child: child),
    );
  }

  group('UpgradeScreen', () {
    testWidgets('lists every course with price, duration and boost', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState()));

      await tester.pumpWidget(wrap(const UpgradeScreen()));

      expect(find.textContaining('Chứng chỉ tiếng Anh'), findsOneWidget);
      expect(find.textContaining('Chứng chỉ nghề nâng cao'), findsOneWidget);
      expect(find.textContaining('Văn bằng sau đại học'), findsOneWidget);
      expect(find.textContaining('Lương +8% vĩnh viễn'), findsOneWidget);
      expect(find.textContaining('Học phí: 12tr ₫'), findsOneWidget);
      expect(find.textContaining('Học 6 tháng • +3 stress'), findsOneWidget);
      // The salary card names the gap.
      expect(find.textContaining('Lương tăng 3.0%/năm • vật giá tăng 3.5%/năm'),
          findsOneWidget);
    });

    testWidgets('course price on screen follows inflationIndex', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      when(() => mockCubit.state).thenReturn(
          GameEngineState.playing(buildGameState(cash: 100000000, index: 1.5)));

      await tester.pumpWidget(wrap(const UpgradeScreen()));

      // 12tr × 1.5 = 18tr, flagged as inflated.
      expect(find.textContaining('Học phí: 18tr ₫'), findsOneWidget);
      expect(find.textContaining('học sớm rẻ hơn'), findsNWidgets(3));
    });

    testWidgets('register flow: confirm dialog submits through the cubit',
        (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState()));
      when(() => mockCubit.startCourse(any())).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const UpgradeScreen()));
      await tester.tap(find.widgetWithText(GameButton, 'Đăng ký học').first);
      await tester.pumpAndSettle();

      expect(find.textContaining('Đóng 12tr ₫ một lần'), findsOneWidget);
      await tester.tap(find.widgetWithText(GameButton, 'Học ngay'));
      await tester.pumpAndSettle();

      verify(() => mockCubit.startCourse('course_english')).called(1);
    });

    testWidgets('dialog can be dismissed without starting the course', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState()));

      await tester.pumpWidget(wrap(const UpgradeScreen()));
      await tester.tap(find.widgetWithText(GameButton, 'Đăng ký học').first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(GameButton, 'Để sau'));
      await tester.pumpAndSettle();

      verifyNever(() => mockCubit.startCourse(any()));
    });

    testWidgets('while studying: progress shown, other courses blocked',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(studyingId: 'course_english', monthsLeft: 4)));

      await tester.pumpWidget(wrap(const UpgradeScreen()));

      expect(find.textContaining('Đang học — còn 4 tháng'), findsOneWidget);
      expect(find.textContaining('mỗi lúc chỉ học được một khóa'), findsNWidgets(2));
      // No enabled register button anywhere.
      for (final btn in tester
          .widgetList<GameButton>(find.widgetWithText(GameButton, 'Đăng ký học'))) {
        expect(btn.onPressed, isNull);
      }
    });

    testWidgets('completed course shows graduation badge, no register button',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(completed: {'course_english'})));

      await tester.pumpWidget(wrap(const UpgradeScreen()));

      expect(find.textContaining('🎓 Đã tốt nghiệp'), findsOneWidget);
      // Only the two remaining courses still offer registration.
      expect(find.widgetWithText(GameButton, 'Đăng ký học'), findsNWidgets(2));
    });

    testWidgets('too poor for a course: button disabled with reason', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(cash: 20000000)));

      await tester.pumpWidget(wrap(const UpgradeScreen()));

      // 12tr affordable; 35tr and 90tr are not.
      expect(find.textContaining('Chưa đủ tiền mặt'), findsNWidgets(2));
      final buttons = tester
          .widgetList<GameButton>(find.widgetWithText(GameButton, 'Đăng ký học'))
          .toList();
      expect(buttons.where((b) => b.onPressed != null).length, 1);
    });

    testWidgets('no overflow on a narrow 360dp phone', (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(cash: 123456789, index: 1.41, studyingId: 'course_pro', monthsLeft: 11)));

      await tester.pumpWidget(wrap(const UpgradeScreen()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
