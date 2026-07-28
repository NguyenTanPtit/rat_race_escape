import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/pending_proceed.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/apply_inflation_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';

class EmptyEventPool implements EventPoolRepository {
  @override
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId,
          {String locale = 'vi'}) async =>
      [];
}

const _classId = 'index_fund';

MarketClassState buildClass() => const MarketClassState(
      config: MarketClassConfig(
        id: _classId,
        name: 'Quỹ Index',
        annualYieldRate: 12.0, // 1%/month per unit at par
        monthlyDrift: 0.0,
        monthlyVolatility: 0.0,
        crashChance: 0.0,
        crashMonthlyDrift: -5.0,
        crashMinMonths: 5,
        crashMaxMonths: 10,
        boomChance: 0.0,
        boomMonthlyDrift: 3.0,
        boomMinMonths: 6,
        boomMaxMonths: 12,
      ),
    );

GameState buildState({
  int currentMonth = 12,
  int startCalendarMonth = 1,
  double inflation = 0.035,
  double salaryGrowth = 0.03,
  double cash = 20000000,
  double index = 1.0,
  List<Asset> assets = const [],
  List<PendingProceed> pending = const [],
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    currentMonth: currentMonth,
    startCalendarMonth: startCalendarMonth,
    cash: cash,
    monthlyExpenses: 5000000,
    monthlyRent: 3500000,
    familySupportExpense: 2000000,
    baseSalary: 11000000,
    hasHealthInsurance: true,
    healthInsurancePremiumMonthly: 100000,
    inflationAnnualRate: inflation,
    salaryGrowthAnnualRate: salaryGrowth,
    inflationIndex: index,
    assets: assets,
    pendingProceeds: pending,
    market: {_classId: buildClass()},
  );
}

void main() {
  final inflate = ApplyInflationUseCase();

  group('ApplyInflationUseCase', () {
    test('only fires at Tet (calendarMonth == 1)', () {
      // startCalendarMonth 1 + currentMonth 13 -> calendarMonth 1 = Tet
      final atTet = buildState(currentMonth: 13);
      expect(atTet.calendarMonth, 1);
      expect(inflate(atTet).monthlyExpenses, closeTo(5000000 * 1.035, 0.01));

      // currentMonth 14 -> calendarMonth 2, nothing happens
      final midYear = buildState(currentMonth: 14);
      expect(midYear.calendarMonth, 2);
      expect(inflate(midYear), same(midYear));
    });

    test('does not fire on the very first month of the game', () {
      final start = buildState(currentMonth: 1);
      expect(start.calendarMonth, 1);
      expect(inflate(start), same(start));
    });

    test('no-op when the scenario has no inflation configured', () {
      final noInflation = buildState(currentMonth: 13, inflation: 0.0);
      expect(inflate(noInflation), same(noInflation));
    });

    test('scales every cost, the salary and dividends — but NEVER cash', () {
      final holding = const Asset(
        id: 'mkt_index',
        name: 'Quỹ Index',
        baseValue: 100000000,
        monthlyPassiveIncome: 1000000,
        units: 100000000,
        marketClassId: _classId,
      );
      final state = buildState(
        currentMonth: 13,
        cash: 20000000,
        assets: [holding],
        pending: const [PendingProceed(amount: 5000000, monthsLeft: 2)],
      );

      final after = inflate(state);

      expect(after.monthlyExpenses, closeTo(5000000 * 1.035, 0.01));
      expect(after.monthlyRent, closeTo(3500000 * 1.035, 0.01));
      expect(after.familySupportExpense, closeTo(2000000 * 1.035, 0.01));
      expect(after.healthInsurancePremiumMonthly, closeTo(100000 * 1.035, 0.01));
      // Salary grows slower than prices — that gap is the pressure to invest.
      expect(after.baseSalary, closeTo(11000000 * 1.03, 0.01));
      expect(after.assets.single.monthlyPassiveIncome, closeTo(1000000 * 1.035, 0.01));
      expect(after.inflationIndex, closeTo(1.035, 1e-9));

      // THE LESSON: cash and settling proceeds are untouched, so they lose
      // purchasing power against the higher costs.
      expect(after.cash, closeTo(20000000, 0.01));
      expect(after.pendingProceeds.single.amount, closeTo(5000000, 0.01));
    });

    test('index compounds across years', () {
      var state = buildState(currentMonth: 13);
      for (var year = 1; year <= 3; year++) {
        state = inflate(state);
        // Jump a full year to the next Tet.
        state = state.copyWith(currentMonth: state.currentMonth + 12);
      }
      expect(state.inflationIndex, closeTo(pow(1.035, 3).toDouble(), 1e-9));
      expect(state.monthlyExpenses, closeTo(5000000 * pow(1.035, 3), 0.01));
    });

    test('real purchasing power of held cash shrinks over a decade', () {
      var state = buildState(currentMonth: 13, cash: 100000000);
      for (var year = 1; year <= 10; year++) {
        state = inflate(state);
        state = state.copyWith(currentMonth: state.currentMonth + 12);
      }
      final realValue = state.cash / state.inflationIndex;
      expect(state.cash, closeTo(100000000, 0.01), reason: 'nominal never moves');
      expect(realValue, lessThan(72000000),
          reason: '100tr cash must lose ~29% of its value in 10 years');
    });
  });

  group('Inflation through the real pipeline', () {
    test('Tet month is already charged at the NEW prices', () async {
      final next = ProcessNextMonthUseCase(
        CalculateCashflowUseCase(),
        ProcessLoansUseCase(),
        UpdateMarketUseCase(Random(1)),
        UpdateMetricsUseCase(),
        GenerateEventUseCase(EmptyEventPool(), Random(1)),
        CheckGameStatusUseCase(),
        CheckBehavioralInsightsUseCase(),
        ApplyInflationUseCase(),
      );

      // currentMonth 12 -> advancing lands on month 13 = Tet.
      final before = buildState(currentMonth: 12, cash: 100000000);
      final after = (await next(before)).getRight().toNullable()!.state;

      expect(after.calendarMonth, 1);
      final expectedOutflow = (5000000 + 3500000 + 2000000 + 100000) * 1.035;
      expect(after.totalMonthlyOutflow, closeTo(expectedOutflow, 0.01));
      // Cash delta = new salary − new outflow, both already inflated.
      expect(after.cash - before.cash,
          closeTo(11000000 * 1.03 - expectedOutflow, 0.01));
    });
  });

  group('BuyMarketAsset under inflation', () {
    test('a late buyer gets the same REAL yield as an early buyer', () {
      final buy = BuyMarketAssetUseCase(CheckGameStatusUseCase());

      // Year 1: buy 10tr at par -> 1%/month per unit -> 100k/month.
      final early = buy(buildState(index: 1.0), _classId, 10000000)
          .getRight().toNullable()!.state.assets.single;
      expect(early.monthlyPassiveIncome, closeTo(100000, 0.01));

      // Year 11 (index ~1.41): the same nominal 10tr buys income scaled by the
      // index, so its purchasing power relative to inflated costs matches.
      final index = pow(1.035, 10).toDouble();
      final late = buy(buildState(index: index), _classId, 10000000)
          .getRight().toNullable()!.state.assets.single;
      expect(late.monthlyPassiveIncome, closeTo(100000 * index, 0.01));

      // Early buyer's income has ALSO been bumped ×index by the yearly Tet
      // pass, so both hold identical real yield — no era is privileged.
      expect(early.monthlyPassiveIncome * index,
          closeTo(late.monthlyPassiveIncome, 0.01));
    });
  });
}
