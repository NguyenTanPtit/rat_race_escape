import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/main_game_screen.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';

class MockGameEngineCubit extends MockBloc<GameEngineCubit, GameEngineState> implements GameEngineCubit {}

/// Guard against raw doubles leaking into the UI (the 4a bug: "5000000.0",
/// "1055069480.1234567"). MoneyFormat always abbreviates — "15tr ₫",
/// "1,2 tỷ ₫" — so no formatted amount ever shows 5+ consecutive digits.
/// Stress/credit/month numbers are all far shorter than that.
void expectNoRawMoney(WidgetTester tester) {
  final rawNumber = RegExp(r'\d{5,}');
  for (final text in tester.widgetList<Text>(find.byType(Text))) {
    final data = text.data;
    if (data == null) continue;
    expect(rawNumber.hasMatch(data), isFalse,
        reason: 'Số tiền thô lọt ra UI (thiếu MoneyFormat): "$data"');
  }
}

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

  // Cash 15tr + savings 20tr + tài sản 100tr + đang về 5tr − nợ 10tr = 130tr.
  const investedState = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 15000000,
    savingsBalance: 20000000,
    monthlyExpenses: 5000000,
    monthlyRent: 3000000,
    baseSalary: 20000000,
    familySupportExpense: 2000000.0,
    stress: 50,
    networkScore: 30,
    creditScore: 600,
    assets: [
      Asset(
        id: 'a1',
        name: 'Quỹ Index',
        baseValue: 100000000,
        monthlyPassiveIncome: 900000,
      ),
    ],
    loans: [
      Loan(id: 'loan1', name: 'Personal Loan', type: LoanType.personalLoan, principalAmount: 10000000, minimumMonthlyPayment: 1000000, interestRatePerYear: 10.0)
    ],
  );

  testWidgets('MainGameScreen renders correctly from playing state', (WidgetTester tester) async {
    // The header now carries a sub-line, pushing the cashflow block down the
    // lazy ListView — give the test a tall viewport so it stays reachable.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    whenListen(
      mockCubit,
      Stream.fromIterable([const GameEngineState.playing(gameState)]),
      initialState: const GameEngineState.playing(gameState),
    );

    await tester.pumpWidget(buildTestableWidget(const MainGameScreen()));
    await tester.pumpAndSettle();

    expect(find.textContaining('Trả nợ: 1tr ₫ (lãi 83,33k ₫)'), findsOneWidget); // Loan
    expect(find.textContaining('Gửi về quê'), findsOneWidget); // Family support enabled
  });

  testWidgets('headline shows NET WORTH (not cash), with cash on the sub-line',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    whenListen(
      mockCubit,
      Stream.fromIterable([const GameEngineState.playing(investedState)]),
      initialState: const GameEngineState.playing(investedState),
    );

    await tester.pumpWidget(buildTestableWidget(const MainGameScreen()));
    await tester.pumpAndSettle();

    // 15tr cash + 20tr savings + 100tr assets − 10tr debt = 125tr.
    expect(investedState.netWorth, 125000000);
    expect(find.text('125tr ₫'), findsOneWidget);
    expect(find.textContaining('Tiền mặt: 15tr ₫'), findsOneWidget);
    expect(find.textContaining('Tiết kiệm: 20tr ₫'), findsOneWidget);
  });

  testWidgets('passive income — the number that decides the game — is on screen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    whenListen(
      mockCubit,
      Stream.fromIterable([const GameEngineState.playing(investedState)]),
      initialState: const GameEngineState.playing(investedState),
    );

    await tester.pumpWidget(buildTestableWidget(const MainGameScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Thu nhập thụ động'), findsOneWidget);
    expect(find.text('+900k ₫'), findsOneWidget);
  });

  testWidgets('no raw money anywhere on the main screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    whenListen(
      mockCubit,
      Stream.fromIterable([const GameEngineState.playing(investedState)]),
      initialState: const GameEngineState.playing(investedState),
    );

    await tester.pumpWidget(buildTestableWidget(const MainGameScreen()));
    await tester.pumpAndSettle();

    expectNoRawMoney(tester);
  });

  testWidgets('monthly summary dialog formats its money too', (WidgetTester tester) async {
    const summary = MonthlySummaryDelta(
      cashDelta: 4500000,
      stressDelta: -3,
      netWorthDelta: 12300000,
    );

    whenListen(
      mockCubit,
      Stream.fromIterable([
        const GameEngineState.playing(gameState, {}, summary),
      ]),
      initialState: const GameEngineState.playing(gameState),
    );

    await tester.pumpWidget(buildTestableWidget(const MainGameScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.textContaining('+4,5tr ₫'), findsOneWidget);
    expect(find.textContaining('+12,3tr ₫'), findsOneWidget);
    expectNoRawMoney(tester);
  });
}
