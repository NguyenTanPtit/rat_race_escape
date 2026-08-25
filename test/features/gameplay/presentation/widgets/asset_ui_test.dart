import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/pending_proceed.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/asset_screen.dart';

import '../pages/main_game_screen_test.dart' show expectNoRawMoney;

class MockGameEngineCubit extends Mock implements GameEngineCubit {}

MarketClassState buildClass({
  String id = 'index_fund',
  String name = 'Quỹ Index',
  double price = 1.0,
  int settlementMonths = 1,
}) {
  return MarketClassState(
    price: price,
    config: MarketClassConfig(
      id: id,
      name: name,
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
      settlementMonths: settlementMonths,
    ),
  );
}

GameState buildGameState({
  double cash = 8000000,
  double savings = 0,
  double indexPrice = 1.0,
  double holdingUnits = 0,
  double holdingCostBasis = 0,
  double passivePerMonth = 0,
  List<Loan> loans = const [],
  List<PendingProceed> pending = const [],
  double inflationIndex = 1.0,
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: cash,
    savingsBalance: savings,
    monthlyExpenses: 5000000,
    monthlyRent: 3500000,
    familySupportExpense: 2000000,
    baseSalary: 11000000,
    savingsAnnualRate: 0.045,
    bankLoanAnnualRate: 10.0,
    bankLoanMinCredit: 700,
    bankLoanMaxLtv: 0.5,
    inflationAnnualRate: 0.035,
    inflationIndex: inflationIndex,
    market: {'index_fund': buildClass(price: indexPrice)},
    assets: holdingUnits <= 0
        ? const []
        : [
            Asset(
              id: 'mkt_index_fund',
              name: 'Quỹ Index',
              baseValue: holdingCostBasis,
              units: holdingUnits,
              monthlyPassiveIncome: passivePerMonth,
              marketClassId: 'index_fund',
            ),
          ],
    loans: loans,
    pendingProceeds: pending,
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

  void pumpTall(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  group('AssetScreen', () {
    testWidgets('progress card shows the road to the win', (tester) async {
      pumpTall(tester);
      // Passive 5,25tr / outflow 10,5tr = 50%.
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(
              holdingUnits: 100000000,
              holdingCostBasis: 100000000,
              passivePerMonth: 5250000)));

      await tester.pumpWidget(wrap(const AssetScreen()));

      expect(
          find.textContaining(
              'Thu nhập thụ động 5,25tr ₫ / chi phí 10,5tr ₫ — 50%'),
          findsOneWidget);
      expect(find.textContaining('Còn thiếu 5,25tr ₫/tháng để thắng'), findsOneWidget);
      expect(find.textContaining('Khi cột này đầy'), findsOneWidget);
    });

    testWidgets('net worth breakdown adds up every source', (tester) async {
      pumpTall(tester);
      const loan = Loan(
        id: 'bank_loan',
        name: 'Vay thế chấp',
        principalAmount: 30000000,
        interestRatePerYear: 10.0,
        minimumMonthlyPayment: 600000,
        type: LoanType.mortgage,
      );
      const hotLoan = Loan(
        id: 'loan_hot',
        name: 'Vay nóng',
        principalAmount: 20000000,
        interestRatePerYear: 40.0,
        minimumMonthlyPayment: 1700000,
      );
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(
        cash: 8000000,
        savings: 20000000,
        holdingUnits: 100000000,
        holdingCostBasis: 80000000, // avg 0.8, price 1.0 -> +25%
        passivePerMonth: 900000,
        pending: const [PendingProceed(amount: 5000000, monthsLeft: 2)],
        loans: const [loan, hotLoan],
        inflationIndex: 1.5,
      )));

      await tester.pumpWidget(wrap(const AssetScreen()));

      expect(find.text('Tiền mặt'), findsOneWidget);
      expect(find.text('8tr ₫'), findsOneWidget);
      expect(find.text('Tiết kiệm'), findsOneWidget);
      expect(find.textContaining('lãi ~+75k ₫/tháng'), findsOneWidget);
      // Holding: market value 100tr, bought at 0.8 -> +25% badge, liquidity note.
      expect(find.text('Quỹ Index'), findsOneWidget);
      expect(find.text('▲25%'), findsOneWidget);
      expect(find.textContaining('bán xong T+1 tháng mới có tiền'), findsOneWidget);
      // Pending proceeds are visible but flagged unspendable.
      expect(find.textContaining('còn 2 tháng — KHÔNG tiêu được'), findsOneWidget);
      // Debts split by kind.
      expect(find.text('Nợ ngân hàng'), findsOneWidget);
      expect(find.text('Nợ khác (vay nóng, thẻ...)'), findsOneWidget);
      // 8 + 20 + 100 + 5 - 30 - 20 = 83tr, real = 83/1.5.
      // Appears twice: page header + the "= Tài sản ròng" total row.
      expect(find.text('83tr ₫'), findsNWidgets(2));
      expect(find.textContaining('Sức mua theo giá năm đầu: 55,33tr ₫'), findsOneWidget);
      expectNoRawMoney(tester);
    });

    testWidgets('losing position shows a red badge', (tester) async {
      pumpTall(tester);
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(
        indexPrice: 0.7,
        holdingUnits: 100000000,
        holdingCostBasis: 100000000, // avg 1.0, price 0.7 -> -30%
      )));

      await tester.pumpWidget(wrap(const AssetScreen()));

      expect(find.text('▼30%'), findsOneWidget);
    });

    testWidgets('cashflow card shows the month and its verdict', (tester) async {
      pumpTall(tester);
      const loan = Loan(
        id: 'bank_loan',
        name: 'Vay thế chấp',
        principalAmount: 60000000,
        interestRatePerYear: 10.0,
        minimumMonthlyPayment: 1200000,
        type: LoanType.mortgage,
      );
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(loans: const [loan])));

      await tester.pumpWidget(wrap(const AssetScreen()));

      expect(find.text('Lương'), findsOneWidget);
      expect(find.text('11tr ₫'), findsOneWidget);
      expect(find.text('Chi phí sống (đủ khoản)'), findsOneWidget);
      expect(find.text('Trả nợ tối thiểu'), findsOneWidget);
      expect(find.textContaining('trong đó lãi 500k ₫'), findsOneWidget);
      // 11 - 10.5 - 1.2 = -0.7tr -> deficit.
      expect(find.text('= Thâm hụt'), findsOneWidget);
      expect(find.text('-700k ₫'), findsOneWidget);
    });

    testWidgets('health warnings fire exactly when their engines would', (tester) async {
      pumpTall(tester);
      // Thin fund + crushing debt + idle cash contradiction is impossible, so
      // build the debt-heavy case: 1-month fund, due > surplus, LTV maxed.
      const bigLoan = Loan(
        id: 'bank_loan',
        name: 'Vay thế chấp',
        principalAmount: 50000000,
        interestRatePerYear: 10.0,
        minimumMonthlyPayment: 2000000, // due 2tr > surplus 0.5tr
        type: LoanType.mortgage,
      );
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(
        cash: 10000000, // fund 10/10.5 = 0.95 months
        holdingUnits: 100000000,
        holdingCostBasis: 100000000, // portfolio 100tr -> cap 50tr, debt 50tr = 100%
        loans: const [bigLoan],
      )));

      await tester.pumpWidget(wrap(const AssetScreen()));

      expect(find.textContaining('Quỹ khẩn cấp: 1.0 tháng'), findsOneWidget);
      expect(find.textContaining('Tiền trả nợ VƯỢT thặng dư'), findsOneWidget);
      expect(find.textContaining('100% hạn mức thế chấp'), findsOneWidget);
    });

    testWidgets('idle cash warning names the yearly loss', (tester) async {
      pumpTall(tester);
      when(() => mockCubit.state).thenReturn(
          GameEngineState.playing(buildGameState(cash: 45000000)));

      await tester.pumpWidget(wrap(const AssetScreen()));

      // 45tr × 0.035/1.035 ≈ 1.52tr.
      expect(find.textContaining('45tr ₫ tiền mặt nằm im'), findsOneWidget);
      expect(find.textContaining('mất ~1,52tr ₫ sức mua'), findsOneWidget);
    });

    testWidgets('a healthy player sees NO health card at all', (tester) async {
      pumpTall(tester);
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(
        cash: 15000000,
        savings: 20000000, // fund 3.3 months, no debt, cash under 3×outflow
      )));

      await tester.pumpWidget(wrap(const AssetScreen()));

      expect(find.textContaining('Sức khỏe tài chính'), findsNothing);
    });

    testWidgets('no overflow on a narrow 360dp phone', (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      const loan = Loan(
        id: 'bank_loan',
        name: 'Vay thế chấp',
        principalAmount: 123456789,
        interestRatePerYear: 10.0,
        minimumMonthlyPayment: 2469135,
        type: LoanType.mortgage,
      );
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
          buildGameState(
        cash: 123456789,
        savings: 98765432,
        holdingUnits: 987654321,
        holdingCostBasis: 800000000,
        passivePerMonth: 12345678,
        pending: const [PendingProceed(amount: 87654321, monthsLeft: 2)],
        loans: const [loan],
        inflationIndex: 1.41,
      )));

      await tester.pumpWidget(wrap(const AssetScreen()));
      await tester.pumpAndSettle();

      expectNoRawMoney(tester);
    });
  });
}
