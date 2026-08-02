import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/manage_savings_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/take_bank_loan_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/apply_inflation_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

const _classId = 'index_fund';

GameState buildState({
  double cash = 50000000,
  double savings = 0,
  double savingsRate = 0.045,
  double loanRate = 10.0,
  int credit = 750,
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
    savingsAnnualRate: savingsRate,
    bankLoanAnnualRate: loanRate,
    bankLoanMinCredit: 700,
    bankLoanMaxLtv: 0.5,
    market: {
      _classId: const MarketClassState(
        config: MarketClassConfig(
          id: _classId,
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
              id: 'mkt_$_classId',
              name: 'Quỹ Index',
              baseValue: holdingUnits,
              units: holdingUnits,
              marketClassId: _classId,
            ),
          ],
    loans: loans,
  );
}

void main() {
  final check = CheckGameStatusUseCase();
  final deposit = DepositSavingsUseCase(check);
  final withdraw = WithdrawSavingsUseCase(check);
  final takeLoan = TakeBankLoanUseCase(check);

  group('Deposit/Withdraw savings', () {
    test('deposit validates scenario, amount and cash', () {
      expect(deposit(buildState(savingsRate: 0), 1000).isLeft(), isTrue);
      expect(deposit(buildState(), 0).isLeft(), isTrue);
      expect(deposit(buildState(cash: 100), 200).isLeft(), isTrue);
    });

    test('deposit and withdraw move money without changing net worth', () {
      final state = buildState(cash: 50000000);
      final before = state.netWorth;

      final deposited = deposit(state, 30000000).getRight().toNullable()!.state;
      expect(deposited.cash, closeTo(20000000, 0.01));
      expect(deposited.savingsBalance, closeTo(30000000, 0.01));
      expect(deposited.netWorth, closeTo(before, 0.01));

      final withdrawn = withdraw(deposited, 10000000).getRight().toNullable()!.state;
      expect(withdrawn.cash, closeTo(30000000, 0.01));
      expect(withdrawn.savingsBalance, closeTo(20000000, 0.01));
      expect(withdrawn.netWorth, closeTo(before, 0.01));
    });

    test('withdraw rejects more than the balance', () {
      final state = buildState(savings: 5000000);
      expect(withdraw(state, 5000001).isLeft(), isTrue);
    });
  });

  group('Savings interest', () {
    final cashflow = CalculateCashflowUseCase();

    test('compounds monthly inside the balance', () {
      // Zero out flows so only interest moves anything.
      var state = buildState(savings: 120000000).copyWith(
          baseSalary: 0, monthlyExpenses: 0, monthlyRent: 0);
      state = cashflow(state);
      // 4.5%/yr -> 0.375%/month -> +450k on 120tr
      expect(state.savingsBalance, closeTo(120000000 * (1 + 0.045 / 12), 0.01));
      expect(state.cash, closeTo(50000000, 0.01), reason: 'interest stays in savings');
    });

    test('inflation does NOT index the savings balance', () {
      final state = buildState(savings: 100000000).copyWith(
        inflationAnnualRate: 0.035,
        salaryGrowthAnnualRate: 0.03,
        currentMonth: 13,
        startCalendarMonth: 1,
      );
      final after = ApplyInflationUseCase()(state);
      expect(after.savingsBalance, closeTo(100000000, 0.01));
    });
  });

  group('TakeBankLoan', () {
    test('rejects when lending is off, credit too low, or empty hands (no collateral)', () {
      expect(takeLoan(buildState(loanRate: 0, holdingUnits: 100000000), 1000).isLeft(), isTrue);
      expect(takeLoan(buildState(credit: 699, holdingUnits: 100000000), 1000).isLeft(), isTrue);
      // No assets at all -> headroom 0 -> any amount refused.
      expect(takeLoan(buildState(holdingUnits: 0), 1000).isLeft(), isTrue);
    });

    test('lends up to 50% of portfolio market value, at 10%/yr mortgage terms', () {
      final state = buildState(holdingUnits: 100000000); // portfolio 100tr @ price 1.0
      expect(state.bankLoanHeadroom, closeTo(50000000, 0.01));

      // Over the cap -> refused.
      expect(takeLoan(state, 50000001).isLeft(), isTrue);

      final after = takeLoan(state, 40000000).getRight().toNullable()!.state;
      expect(after.cash, closeTo(90000000, 0.01));
      final loan = after.loans.single;
      expect(loan.type, LoanType.mortgage);
      expect(loan.interestRatePerYear, 10.0);
      expect(loan.minimumMonthlyPayment, closeTo(40000000 * 0.02, 0.01));
      // Borrowing creates no wealth: cash up, debt up, net worth unchanged.
      expect(after.netWorth, closeTo(state.netWorth, 0.01));
      // Headroom shrinks by the outstanding debt.
      expect(after.bankLoanHeadroom, closeTo(10000000, 0.01));
    });

    test('headroom ignores non-bank debt but counts every mortgage', () {
      final vayNong = const Loan(
        id: 'loan_hot',
        name: 'Vay nóng',
        principalAmount: 20000000,
        interestRatePerYear: 40.0,
        minimumMonthlyPayment: 1700000,
        type: LoanType.blackMarket,
      );
      final state = buildState(holdingUnits: 100000000, loans: [vayNong]);
      expect(state.bankLoanHeadroom, closeTo(50000000, 0.01),
          reason: 'vay nóng is not collateralized bank debt');

      final after = takeLoan(state, 30000000).getRight().toNullable()!.state;
      expect(after.totalBankDebt, closeTo(30000000, 0.01));
      expect(after.bankLoanHeadroom, closeTo(20000000, 0.01));
    });

    test('credit gate opens exactly at the configured threshold', () {
      final atThreshold = buildState(credit: 700, holdingUnits: 10000000);
      expect(takeLoan(atThreshold, 1000000).isRight(), isTrue);
    });
  });
}
