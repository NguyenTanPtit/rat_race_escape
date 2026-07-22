import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';

MarketClassConfig buildConfig({
  String id = 'index_fund',
  double monthlyDrift = 0.3,
  double monthlyVolatility = 2.0,
  double crashChance = 0.0,
  double boomChance = 0.0,
  double crashMonthlyDrift = -5.0,
  double boomMonthlyDrift = 3.0,
}) {
  return MarketClassConfig(
    id: id,
    name: 'Test Class $id',
    annualYieldRate: 8.0,
    monthlyDrift: monthlyDrift,
    monthlyVolatility: monthlyVolatility,
    crashChance: crashChance,
    crashMonthlyDrift: crashMonthlyDrift,
    crashMinMonths: 5,
    crashMaxMonths: 10,
    boomChance: boomChance,
    boomMonthlyDrift: boomMonthlyDrift,
    boomMinMonths: 6,
    boomMaxMonths: 12,
  );
}

GameState buildState(Map<String, MarketClassState> market) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 0,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
    market: market,
  );
}

void main() {
  group('UpdateMarketUseCase', () {
    test('state without market classes passes through unchanged', () {
      final usecase = UpdateMarketUseCase(Random(1));
      final state = buildState(const {});
      expect(usecase(state), same(state));
    });

    test('same seed produces identical price paths (deterministic)', () {
      final config = buildConfig(crashChance: 0.05, boomChance: 0.05);
      GameState run(int seed) {
        final usecase = UpdateMarketUseCase(Random(seed));
        var state = buildState({'index_fund': MarketClassState(config: config)});
        for (var i = 0; i < 120; i++) {
          state = usecase(state);
        }
        return state;
      }

      final a = run(42);
      final b = run(42);
      expect(a.market['index_fund']!.price, b.market['index_fund']!.price);
      expect(a.market['index_fund']!.regime, b.market['index_fund']!.regime);
    });

    test('price never falls below the floor of 0.15', () {
      // Force a permanent crash regime with brutal drift.
      final config = buildConfig(
        crashChance: 1.0,
        crashMonthlyDrift: -60.0,
        monthlyVolatility: 0.0,
      );
      final usecase = UpdateMarketUseCase(Random(7));
      var state = buildState({'index_fund': MarketClassState(config: config)});
      for (var i = 0; i < 60; i++) {
        state = usecase(state);
        expect(state.market['index_fund']!.price, greaterThanOrEqualTo(0.15));
      }
    });

    test('peakPrice is monotonic and never below current price', () {
      final config = buildConfig(crashChance: 0.05, boomChance: 0.05);
      final usecase = UpdateMarketUseCase(Random(2026));
      var state = buildState({'index_fund': MarketClassState(config: config)});
      var prevPeak = 1.0;
      for (var i = 0; i < 120; i++) {
        state = usecase(state);
        final cls = state.market['index_fund']!;
        expect(cls.peakPrice, greaterThanOrEqualTo(cls.price));
        expect(cls.peakPrice, greaterThanOrEqualTo(prevPeak));
        prevPeak = cls.peakPrice;
      }
    });

    test('recentPrices window is capped at 12 entries', () {
      final config = buildConfig();
      final usecase = UpdateMarketUseCase(Random(3));
      var state = buildState({'index_fund': MarketClassState(config: config)});
      for (var i = 0; i < 30; i++) {
        state = usecase(state);
      }
      expect(state.market['index_fund']!.recentPrices.length, 12);
    });

    test('crashChance of 1.0 enters crash regime with falling prices', () {
      final config = buildConfig(crashChance: 1.0, monthlyVolatility: 0.0);
      final usecase = UpdateMarketUseCase(Random(4));
      var state = buildState({'index_fund': MarketClassState(config: config)});
      state = usecase(state);
      final cls = state.market['index_fund']!;
      expect(cls.regime, MarketRegime.crash);
      expect(cls.price, lessThan(1.0));
    });

    test('regime returns to normal after its duration expires', () {
      final config = buildConfig(crashChance: 1.0, monthlyVolatility: 0.0);
      final usecase = UpdateMarketUseCase(Random(5));
      var state = buildState({'index_fund': MarketClassState(config: config)});
      state = usecase(state); // enters crash
      var monthsInCrash = 1;
      while (state.market['index_fund']!.regime == MarketRegime.crash && monthsInCrash < 20) {
        state = usecase(state);
        monthsInCrash++;
      }
      // crashMaxMonths is 10, so the regime must expire within the bound.
      // (crashChance 1.0 re-enters crash next month, but the expiry itself must occur.)
      expect(monthsInCrash, lessThanOrEqualTo(11));
    });

    test('drawdown and trailingRatio getters compute correctly', () {
      // Rolling window holds a 1.0 peak; price fell to 0.8 -> drawdown 20%.
      final cls = MarketClassState(
        config: buildConfig(),
        price: 0.8,
        peakPrice: 1.0,
        recentPrices: [1.0, ...List.filled(11, 0.8)],
      );
      expect(cls.drawdown, closeTo(0.2, 1e-9));

      final flat = cls.copyWith(price: 0.8, recentPrices: List.filled(12, 0.4));
      // Rolling peak is the current price -> no drawdown, even though the
      // all-time peakPrice field is higher (signal must not go stale).
      expect(flat.drawdown, closeTo(0.0, 1e-9));
      expect(flat.trailingRatio, closeTo(2.0, 1e-9));

      // Window not full yet -> neutral ratio.
      final young = cls.copyWith(recentPrices: List.filled(5, 0.4));
      expect(young.trailingRatio, 1.0);
    });
  });
}
