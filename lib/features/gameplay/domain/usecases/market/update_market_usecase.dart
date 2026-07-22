import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';

/// Advances every market class by one month: regime transitions, price drift
/// plus noise, peak tracking, and the trailing price window.
///
/// RNG draw order is fixed per class (crash roll → boom roll → noise) and
/// classes are processed in the map's insertion order, so a seeded [Random]
/// yields a fully deterministic price path.
@lazySingleton
class UpdateMarketUseCase {
  final Random _random;

  UpdateMarketUseCase(this._random);

  static const double _minPrice = 0.15;
  static const int _trailingWindow = 12;

  GameState call(GameState state) {
    if (state.market.isEmpty) return state;

    final updated = <String, MarketClassState>{};
    for (final entry in state.market.entries) {
      updated[entry.key] = _advanceOneMonth(entry.value);
    }
    return state.copyWith(market: updated);
  }

  MarketClassState _advanceOneMonth(MarketClassState cls) {
    final config = cls.config;
    var regime = cls.regime;
    var monthsLeft = cls.regimeMonthsLeft;

    // Regime transitions only start from normal; both rolls are always
    // consumed to keep the RNG stream aligned regardless of outcome.
    final crashRoll = _random.nextDouble();
    final boomRoll = _random.nextDouble();
    if (regime == MarketRegime.normal) {
      if (crashRoll < config.crashChance) {
        regime = MarketRegime.crash;
        monthsLeft = config.crashMinMonths +
            (_random.nextDouble() * (config.crashMaxMonths - config.crashMinMonths)).round();
      } else if (boomRoll < config.boomChance) {
        regime = MarketRegime.boom;
        monthsLeft = config.boomMinMonths +
            (_random.nextDouble() * (config.boomMaxMonths - config.boomMinMonths)).round();
      }
    }

    final drift = switch (regime) {
      MarketRegime.normal => config.monthlyDrift,
      MarketRegime.boom => config.boomMonthlyDrift,
      MarketRegime.crash => config.crashMonthlyDrift,
    };
    final noise = (_random.nextDouble() * 2 - 1) * config.monthlyVolatility;

    final trendPrice = cls.trendPrice * (1 + config.monthlyDrift / 100);

    var price = cls.price * (1 + (drift + noise) / 100);
    // Pull a fraction of the gap back toward the trend anchor.
    price += config.meanReversion * (trendPrice - price);
    if (price < _minPrice) price = _minPrice;

    if (regime != MarketRegime.normal) {
      monthsLeft -= 1;
      if (monthsLeft <= 0) {
        regime = MarketRegime.normal;
        monthsLeft = 0;
      }
    }

    final window = [...cls.recentPrices, price];
    if (window.length > _trailingWindow) {
      window.removeRange(0, window.length - _trailingWindow);
    }

    return cls.copyWith(
      price: price,
      peakPrice: price > cls.peakPrice ? price : cls.peakPrice,
      trendPrice: trendPrice,
      regime: regime,
      regimeMonthsLeft: monthsLeft,
      recentPrices: window,
    );
  }
}
