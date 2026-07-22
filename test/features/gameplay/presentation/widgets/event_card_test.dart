import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_effect.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/event_card.dart';
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
}
