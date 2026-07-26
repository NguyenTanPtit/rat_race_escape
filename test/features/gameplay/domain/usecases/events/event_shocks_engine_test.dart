import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_effect.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/toggle_health_insurance_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/sell_market_asset_usecase.dart';

class FakeEventPoolRepository implements EventPoolRepository {
  List<EventDefinition> pool = [];

  @override
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId,
      {String locale = 'vi'}) async {
    return pool;
  }
}

/// Always-first random: nextDouble 0.0 (events with any chance fire),
/// nextInt returns 0 (durations resolve to minMonths).
class ZeroRandom implements Random {
  @override
  bool nextBool() => false;
  @override
  double nextDouble() => 0.0;
  @override
  int nextInt(int max) => 0;
}

const _classId = 'land';

MarketClassState buildClassState({
  double price = 1.0,
  List<double>? recent,
}) {
  return MarketClassState(
    config: const MarketClassConfig(
      id: _classId,
      name: 'Đất nền',
      type: AssetType.realEstate,
      annualYieldRate: 12.0, // 1%/month per unit at par — easy math
      monthlyDrift: 0.55,
      monthlyVolatility: 4.5,
      crashChance: 0.011,
      crashMonthlyDrift: -7.5,
      crashMinMonths: 6,
      crashMaxMonths: 12,
      boomChance: 0.014,
      boomMonthlyDrift: 5.5,
      boomMinMonths: 6,
      boomMaxMonths: 12,
    ),
    price: price,
    recentPrices: recent ?? [1.0, price],
  );
}

GameState buildState({
  double cash = 50000000,
  double price = 1.0,
  List<double>? recent,
  bool insured = false,
  double premium = 300000,
  List<Asset> assets = const [],
  String? currentEventId,
  int salarySuspendedMonths = 0,
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: cash,
    monthlyExpenses: 5000000,
    monthlyRent: 3500000,
    baseSalary: 11000000,
    hasHealthInsurance: insured,
    healthInsurancePremiumMonthly: premium,
    salarySuspendedMonths: salarySuspendedMonths,
    market: {_classId: buildClassState(price: price, recent: recent)},
    assets: assets,
    currentEventId: currentEventId,
  );
}

EventDefinition buildEvent({
  EventTrigger trigger = const EventTrigger(),
  EventEffect effect = const EventEffect(),
  double? absoluteChance = 1.0,
}) {
  return EventDefinition(
    event: GameEvent(
      id: 'e_test',
      title: 'Test',
      description: 'Test',
      options: [EventOption(id: 'opt1', label: 'OK', effect: effect)],
    ),
    trigger: trigger,
    absoluteChance: absoluteChance,
  );
}

void main() {
  final checkStatus = CheckGameStatusUseCase();
  late FakeEventPoolRepository pool;
  late GenerateEventUseCase generate;
  late ApplyEventOptionUseCase apply;

  setUp(() {
    pool = FakeEventPoolRepository();
    generate = GenerateEventUseCase(pool, ZeroRandom());
    apply = ApplyEventOptionUseCase(
      pool,
      checkStatus,
      BuyMarketAssetUseCase(checkStatus),
      SellMarketAssetUseCase(checkStatus),
      ZeroRandom(),
    );
  });

  Future<GameState> applyOpt(GameState state) async {
    final result = await apply(state, 'e_test', 'opt1');
    return result.getRight().toNullable()!.state;
  }

  group('EventTrigger 6.2b', () {
    test('maxCash fires only while cash is below the threshold', () async {
      pool.pool = [buildEvent(trigger: const EventTrigger(maxCash: 0))];

      final broke = await generate(buildState(cash: -100));
      expect(broke.currentEventId, 'e_test');

      final solvent = await generate(buildState(cash: 100));
      expect(solvent.currentEventId, isNull);
    });

    test('minMarketDrawdown fires only at or above the drawdown', () async {
      pool.pool = [
        buildEvent(
            trigger: const EventTrigger(
                minMarketDrawdown: MarketCondition(classId: _classId, value: 0.25))),
      ];

      final crashed = await generate(buildState(price: 0.7, recent: [1.0, 0.7]));
      expect(crashed.currentEventId, 'e_test');

      final mild = await generate(buildState(price: 0.9, recent: [1.0, 0.9]));
      expect(mild.currentEventId, isNull);

      // Unknown class never fires.
      pool.pool = [
        buildEvent(
            trigger: const EventTrigger(
                minMarketDrawdown: MarketCondition(classId: 'nonexistent', value: 0.1))),
      ];
      final unknown = await generate(buildState(price: 0.5, recent: [1.0, 0.5]));
      expect(unknown.currentEventId, isNull);
    });

    test('minMarketTrailingRatio fires only when the class runs hot', () async {
      pool.pool = [
        buildEvent(
            trigger: const EventTrigger(
                minMarketTrailingRatio: MarketCondition(classId: _classId, value: 1.25))),
      ];

      final hot = await generate(buildState(price: 1.3, recent: List.filled(12, 1.0)));
      expect(hot.currentEventId, 'e_test');

      final calm = await generate(buildState(price: 1.1, recent: List.filled(12, 1.0)));
      expect(calm.currentEventId, isNull);
    });
  });

  group('EventEffect 6.2b', () {
    test('cashIfInsured replaces cash only when the player has insurance', () async {
      pool.pool = [
        buildEvent(effect: const EventEffect(cash: -25000000, cashIfInsured: -5000000)),
      ];

      final uninsured = await applyOpt(buildState(currentEventId: 'e_test'));
      expect(uninsured.cash, closeTo(25000000, 0.01));

      final insured = await applyOpt(buildState(currentEventId: 'e_test', insured: true));
      expect(insured.cash, closeTo(45000000, 0.01));
    });

    test('salarySuspendedMonths is set and does not shorten an existing suspension', () async {
      pool.pool = [buildEvent(effect: const EventEffect(salarySuspendedMonths: 3))];

      final fresh = await applyOpt(buildState(currentEventId: 'e_test'));
      expect(fresh.salarySuspendedMonths, 3);

      final alreadyLonger =
          await applyOpt(buildState(currentEventId: 'e_test', salarySuspendedMonths: 5));
      expect(alreadyLonger.salarySuspendedMonths, 5);
    });

    test('marketSellAllClassIds liquidates the holding at market price minus fee', () async {
      // Holding: 10tr units bought at par, price now 0.5 -> worth 5tr.
      final holding = const Asset(
        id: 'mkt_land', name: 'Đất nền', type: AssetType.realEstate,
        baseValue: 10000000, monthlyPassiveIncome: 100000,
        units: 10000000, marketClassId: _classId,
      );
      pool.pool = [
        buildEvent(effect: const EventEffect(marketSellAllClassIds: [_classId])),
      ];
      final state = buildState(
          cash: 1000000, price: 0.5, assets: [holding], currentEventId: 'e_test');

      final after = await applyOpt(state);
      expect(after.assets, isEmpty);
      // Panic-selling the dip: 5tr × 0.97 realized.
      expect(after.cash, closeTo(1000000 + 5000000 * 0.97, 1.0));

      // No holding -> silently skipped.
      final noHolding = await applyOpt(buildState(cash: 1000000, currentEventId: 'e_test'));
      expect(noHolding.cash, closeTo(1000000, 0.01));
    });

    test('marketBuyCashFraction buys the fraction, skips below dust', () async {
      pool.pool = [
        buildEvent(
            effect: const EventEffect(
                marketBuyCashFraction: MarketBuyFraction(classId: _classId, fraction: 0.8))),
      ];

      final after = await applyOpt(buildState(cash: 50000000, currentEventId: 'e_test'));
      expect(after.cash, closeTo(10000000, 0.01));
      expect(after.assets.single.units, closeTo(40000000, 0.01));

      // 1tr cash -> 800k buy is below the 1tr dust threshold -> skipped.
      final dust = await applyOpt(buildState(cash: 1000000, currentEventId: 'e_test'));
      expect(dust.assets, isEmpty);
      expect(dust.cash, closeTo(1000000, 0.01));
    });

    test('marketBuyDiscount buys at the discounted price, clamped to cash', () async {
      pool.pool = [
        buildEvent(
            effect: const EventEffect(
                marketBuyDiscount:
                    MarketBuyDiscount(classId: _classId, amount: 30000000, discount: 0.2))),
      ];

      // price 1.0, discount 20% -> buy price 0.8 -> units = 30tr / 0.8 = 37.5tr
      final after = await applyOpt(buildState(cash: 50000000, currentEventId: 'e_test'));
      expect(after.cash, closeTo(20000000, 0.01));
      expect(after.assets.single.units, closeTo(37500000, 0.01));
      // Valued at market price 1.0 -> instant gain visible in net worth.
      expect(after.assetMarketValue(after.assets.single), closeTo(37500000, 0.01));

      // Cash 10tr < amount -> clamped to 10tr.
      final clamped = await applyOpt(buildState(cash: 10000000, currentEventId: 'e_test'));
      expect(clamped.cash, closeTo(0, 0.01));
      expect(clamped.assets.single.units, closeTo(12500000, 0.01));

      // Cash below dust -> skipped entirely.
      final broke = await applyOpt(buildState(cash: 500000, currentEventId: 'e_test'));
      expect(broke.assets, isEmpty);
    });

    test('forceMarketCrash flips the classes into a crash regime', () async {
      pool.pool = [
        buildEvent(
            effect: const EventEffect(
                forceMarketCrash: ForceMarketCrash(
                    classIds: [_classId, 'nonexistent'], minMonths: 6, maxMonths: 9))),
      ];

      final after = await applyOpt(buildState(currentEventId: 'e_test'));
      final cls = after.market[_classId]!;
      expect(cls.regime, MarketRegime.crash);
      // ZeroRandom.nextInt -> 0 -> exactly minMonths.
      expect(cls.regimeMonthsLeft, 6);
    });
  });

  group('Insurance & salary suspension in cashflow', () {
    final cashflow = CalculateCashflowUseCase();

    test('premium is charged only while insured', () {
      final uninsured = cashflow(buildState(cash: 0));
      // 11tr − 8.5tr outflow = +2.5tr
      expect(uninsured.cash, closeTo(2500000, 0.01));

      final insured = cashflow(buildState(cash: 0, insured: true));
      expect(insured.cash, closeTo(2500000 - 300000, 0.01));
    });

    test('salary is zero while suspended', () {
      final suspended = cashflow(buildState(cash: 0, salarySuspendedMonths: 2));
      expect(suspended.cash, closeTo(-8500000, 0.01));
    });

    test('suspension lasts EXACTLY N months through the real pipeline', () async {
      final next = ProcessNextMonthUseCase(
        cashflow,
        ProcessLoansUseCase(),
        UpdateMarketUseCase(ZeroRandom()),
        UpdateMetricsUseCase(),
        GenerateEventUseCase(FakeEventPoolRepository(), Random(1)),
        checkStatus,
        CheckBehavioralInsightsUseCase(),
      );

      var state = buildState(cash: 100000000, salarySuspendedMonths: 2);
      final salaries = <double>[];
      for (var i = 0; i < 4; i++) {
        final before = state.cash;
        state = (await next(state)).getRight().toNullable()!.state;
        // salary received = delta + outflow (no passive income in this state)
        salaries.add(state.cash - before + state.totalMonthlyOutflow);
      }
      // Months 1-2 suspended, months 3-4 paid again.
      expect(salaries[0], closeTo(0, 0.01));
      expect(salaries[1], closeTo(0, 0.01));
      expect(salaries[2], closeTo(11000000, 0.01));
      expect(salaries[3], closeTo(11000000, 0.01));
    });

    test('toggle usecase flips insurance and rejects scenarios without it', () {
      final toggle = ToggleHealthInsuranceUseCase(checkStatus);

      final on = toggle(buildState()).getRight().toNullable()!.state;
      expect(on.hasHealthInsurance, isTrue);
      final off = toggle(on).getRight().toNullable()!.state;
      expect(off.hasHealthInsurance, isFalse);

      expect(toggle(buildState(premium: 0)).isLeft(), isTrue);
    });
  });
}
