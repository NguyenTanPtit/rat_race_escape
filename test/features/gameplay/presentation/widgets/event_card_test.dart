import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_effect.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/events/event_card.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

class MockGameEngineCubit extends Mock implements GameEngineCubit {}

void main() {
  late MockGameEngineCubit mockCubit;
  late GameState baseState;

  setUp(() {
    mockCubit = MockGameEngineCubit();
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
    baseState = const GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      scenarioId: 'test_scenario',
      cash: 10000000,
      baseSalary: 15000000,
      monthlyExpenses: 5000000,
      monthlyRent: 3000000,
      stress: 0,
      ageInMonths: 240,
    );
    when(() => mockCubit.state).thenReturn(GameEngineState.playing(baseState));
  });

  Widget buildTestWidget({required GameEvent event, required GameState state}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<GameEngineCubit>.value(
        value: mockCubit,
        child: Scaffold(
          body: EventCard(
            event: event,
            gameState: state,
          ),
        ),
      ),
    );
  }

  testWidgets('EventCard renders calculated option cash and uses engine values', (WidgetTester tester) async {
    // 15,000,000 base salary. Total outflow = 8,000,000
    // Multipliers:
    // Salary = 0.5 -> +7,500,000
    // Outflow = -0.5 -> -4,000,000
    // Base cash = -1,000,000
    // Total = +2,500,000
    final option = EventOption(
      id: 'opt1',
      label: 'Test Option',
      effect: const EventEffect(
        cash: -1000000,
        cashBySalaryMultiplier: 0.5,
        cashByOutflowMultiplier: -0.5,
      ),
    );

    final event = GameEvent(
      id: 'evt1',
      title: 'Test Event',
      description: 'Desc',
      options: [option],
    );

    await tester.pumpWidget(buildTestWidget(event: event, state: baseState));
    await tester.pumpAndSettle();

    // Verify button label
    expect(find.text('Test Option'), findsOneWidget);

    // Verify rich text has correct strings
    expect(find.textContaining('Thưởng 7,5tr ₫', findRichText: true), findsOneWidget);
    expect(find.textContaining('Chi -5tr ₫', findRichText: true), findsOneWidget);
    expect(find.textContaining('ròng 2,5tr ₫', findRichText: true), findsOneWidget);
    
    // Tap button to verify it calls cubit
    when(() => mockCubit.chooseEventOption(any(), any())).thenAnswer((_) async {});
    await tester.tap(find.text('Test Option'));
    verify(() => mockCubit.chooseEventOption('evt1', 'opt1')).called(1);
  });


  group('Insurance value display (6.2b)', () {
    final medicalEvent = GameEvent(
      id: 'e_appendicitis',
      title: 'Viêm ruột thừa cấp',
      description: 'Cấp cứu!',
      options: const [
        EventOption(
          id: 'app_opt1',
          label: 'Bệnh viện tốt',
          effect: EventEffect(cash: -35000000, cashIfInsured: -6000000, stress: 10),
        ),
      ],
    );

    testWidgets('uninsured player sees what insurance WOULD have saved', (tester) async {
      await tester.pumpWidget(buildTestWidget(event: medicalEvent, state: baseState));

      // Full price charged...
      expect(find.textContaining('-35tr ₫', findRichText: true), findsOneWidget);
      // ...and the lesson rubbed in.
      expect(find.textContaining('Nếu có bảo hiểm: chỉ tốn 6tr ₫'), findsOneWidget);
    });

    testWidgets('insured player sees the discounted bill AND the amount saved', (tester) async {
      final insured = baseState.copyWith(
        hasHealthInsurance: true,
        healthInsurancePremiumMonthly: 100000,
      );
      await tester.pumpWidget(buildTestWidget(event: medicalEvent, state: insured));

      // Discounted amount shown (engine-shared formula)...
      expect(find.textContaining('-6tr ₫', findRichText: true), findsOneWidget);
      expect(find.textContaining('-35tr ₫', findRichText: true), findsNothing);
      // ...and the saving called out: -6tr - (-35tr) = 29tr.
      expect(find.textContaining('Bảo hiểm đã đỡ 29tr ₫'), findsOneWidget);
    });

    testWidgets('options without cashIfInsured show no insurance note', (tester) async {
      final plainEvent = GameEvent(
        id: 'e_plain',
        title: 'Sự kiện thường',
        description: 'Không liên quan y tế',
        options: const [
          EventOption(id: 'p1', label: 'OK', effect: EventEffect(cash: -1000000)),
        ],
      );
      await tester.pumpWidget(buildTestWidget(event: plainEvent, state: baseState));

      expect(find.textContaining('bảo hiểm', findRichText: true), findsNothing);
      expect(find.textContaining('Bảo hiểm'), findsNothing);
    });
  });
}
