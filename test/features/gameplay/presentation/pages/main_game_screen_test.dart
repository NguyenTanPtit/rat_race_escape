import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/main_game_screen.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';

class MockGameEngineCubit extends MockBloc<GameEngineCubit, GameEngineState> implements GameEngineCubit {}

void main() {
  late MockGameEngineCubit mockCubit;

  setUp(() {
    mockCubit = MockGameEngineCubit();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<GameEngineCubit>.value(
        value: mockCubit,
        child: widget,
      ),
    );
  }

  testWidgets('MainGameScreen renders correctly from playing state', (WidgetTester tester) async {
    const gameState = GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      scenarioId: 'test',
      cash: 15000000,
      monthlyExpenses: 5000000,
      monthlyRent: 3000000,
      baseSalary: 20000000,
      familySupportExpense: 2000000.0,
      stress: 50,
      networkScore: 30,
      creditScore: 600,
      loans: [
        Loan(id: 'loan1', name: 'Personal Loan', type: LoanType.personalLoan, principalAmount: 10000000, minimumMonthlyPayment: 1000000, interestRatePerYear: 10.0)
      ],
    );

    whenListen(
      mockCubit,
      Stream.fromIterable([const GameEngineState.playing(gameState)]),
      initialState: const GameEngineState.playing(gameState),
    );

    await tester.pumpWidget(buildTestableWidget(const MainGameScreen()));
    await tester.pumpAndSettle();

    expect(find.textContaining('15tr'), findsWidgets); // Net worth / cash
    expect(find.textContaining('Trả nợ: 1tr ₫ (lãi 83,33k ₫)'), findsOneWidget); // Loan
    expect(find.textContaining('Gửi về quê'), findsOneWidget); // Family support enabled
  });
}
