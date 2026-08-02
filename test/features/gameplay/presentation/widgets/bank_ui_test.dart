import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/bank_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/bank/bank_amount_dialog.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';

class MockGameEngineCubit extends Mock implements GameEngineCubit {}

GameState buildGameState({
  double cash = 20000000,
  double savings = 0,
  int credit = 600,
  double holdingUnits = 0,
  List<Loan> loans = const [],
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: cash,
    monthlyExpenses: 5000000,
    monthlyRent: 3500000,
    baseSalary: 11000000,
    creditScore: credit,
    savingsBalance: savings,
    savingsAnnualRate: 0.045,
    bankLoanAnnualRate: 10.0,
    bankLoanMinCredit: 700,
    bankLoanMaxLtv: 0.5,
    market: {
      'index_fund': const MarketClassState(
        config: MarketClassConfig(
          id: 'index_fund',
          name: 'Quỹ Index',
          annualYieldRate: 11.0,
          monthlyDrift: 0.0,
          monthlyVolatility: 2.0,
          crashChance: 0.0,
          crashMonthlyDrift: -5.0,
          crashMinMonths: 5,
          crashMaxMonths: 10,
          boomChance: 0.0,
          boomMonthlyDrift: 3.0,
          boomMinMonths: 6,
          boomMaxMonths: 12,
        ),
      ),
    },
    assets: holdingUnits <= 0
        ? const []
        : [
            Asset(
              id: 'mkt_index_fund',
              name: 'Quỹ Index',
              baseValue: holdingUnits,
              units: holdingUnits,
              marketClassId: 'index_fund',
            ),
          ],
    loans: loans,
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

  group('BankScreen', () {
    testWidgets('shows savings balance and locked lending below the credit gate',
        (tester) async {
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
        buildGameState(savings: 12000000, credit: 650),
      ));

      await tester.pumpWidget(wrap(const BankScreen()));

      expect(find.textContaining('Số dư: 12tr ₫'), findsOneWidget);
      expect(find.textContaining('Lãi 4.5%/năm'), findsOneWidget);
      expect(find.textContaining('650/700'), findsOneWidget);
      // Locked -> Vay button disabled.
      final vayBtn = tester.widget<GameButton>(find.widgetWithText(GameButton, 'Vay'));
      expect(vayBtn.onPressed, isNull);
    });

    testWidgets('qualified player sees the collateral-based headroom', (tester) async {
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
        buildGameState(credit: 720, holdingUnits: 100000000),
      ));

      await tester.pumpWidget(wrap(const BankScreen()));

      expect(find.textContaining('Có thể vay thêm: 50tr ₫'), findsOneWidget);
      final vayBtn = tester.widget<GameButton>(find.widgetWithText(GameButton, 'Vay'));
      expect(vayBtn.onPressed, isNotNull);
    });

    testWidgets('deposit flow opens dialog and submits through the cubit', (tester) async {
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
        buildGameState(cash: 20000000),
      ));
      when(() => mockCubit.depositSavings(any())).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const BankScreen()));
      await tester.tap(find.widgetWithText(GameButton, 'Gửi'));
      await tester.pumpAndSettle();

      expect(find.byType(BankAmountDialog), findsOneWidget);
      await tester.enterText(find.byType(TextField), '15000000');
      await tester.tap(find.widgetWithText(GameButton, 'Xác nhận'));
      await tester.pumpAndSettle();

      verify(() => mockCubit.depositSavings(15000000)).called(1);
    });

    testWidgets('deposit dialog blocks amounts above the cash on hand', (tester) async {
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
        buildGameState(cash: 1000000),
      ));

      await tester.pumpWidget(wrap(const Scaffold(
        body: BankAmountDialog(action: BankAction.deposit, maxAmount: 1000000),
      )));

      await tester.enterText(find.byType(TextField), '2000000');
      await tester.tap(find.widgetWithText(GameButton, 'Xác nhận'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Vượt mức cho phép — tối đa 1tr ₫'), findsOneWidget);
      verifyNever(() => mockCubit.depositSavings(any()));
    });

    testWidgets('existing debts are listed with repay buttons', (tester) async {
      const loan = Loan(
        id: 'bank_loan_5_0',
        name: 'Vay thế chấp',
        principalAmount: 30000000,
        interestRatePerYear: 10.0,
        minimumMonthlyPayment: 600000,
        type: LoanType.mortgage,
      );
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
        buildGameState(loans: const [loan]),
      ));
      when(() => mockCubit.payDebt(any(), any())).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const BankScreen()));

      // The debts card sits below the fold of the lazy ListView.
      await tester.dragUntilVisible(
        find.textContaining('Dư nợ 30tr ₫'),
        find.byType(ListView),
        const Offset(0, -120),
      );
      expect(find.textContaining('Dư nợ 30tr ₫'), findsOneWidget);

      await tester.ensureVisible(find.widgetWithText(GameButton, 'Trả'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(GameButton, 'Trả'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '10000000');
      await tester.tap(find.widgetWithText(GameButton, 'Xác nhận'));
      await tester.pumpAndSettle();

      verify(() => mockCubit.payDebt('bank_loan_5_0', 10000000)).called(1);
    });
  });
}
