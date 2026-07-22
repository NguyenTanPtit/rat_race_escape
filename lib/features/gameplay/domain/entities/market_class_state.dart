import 'package:freezed_annotation/freezed_annotation.dart';
import 'market_class_config.dart';

part 'market_class_state.freezed.dart';
part 'market_class_state.g.dart';

enum MarketRegime { normal, boom, crash }

/// Dynamic per-class market state, persisted inside GameState.
/// Carries its own [config] so pure usecases never need a config repository.
/// The regime is hidden information: the UI must only surface prices.
@freezed
abstract class MarketClassState with _$MarketClassState {
  const factory MarketClassState({
    required MarketClassConfig config,
    @Default(1.0) double price,
    @Default(1.0) double peakPrice,
    @Default(1.0) double trendPrice, // deterministic anchor, grows by monthlyDrift
    @Default(MarketRegime.normal) MarketRegime regime,
    @Default(0) int regimeMonthsLeft,
    @Default([]) List<double> recentPrices, // trailing window, max 12 entries
  }) = _MarketClassState;

  const MarketClassState._();

  factory MarketClassState.fromJson(Map<String, dynamic> json) =>
      _$MarketClassStateFromJson(json);

  String get classId => config.id;
  String get name => config.name;
  double get passivePerUnitMonthly => config.annualYieldRate / 100 / 12;

  /// Peak over the trailing window (including the current price). Using a
  /// rolling peak instead of the all-time high keeps the crash signal alive:
  /// an early boom would otherwise make "X% off peak" permanently true.
  double get rollingPeak {
    var peak = price;
    for (final p in recentPrices) {
      if (p > peak) peak = p;
    }
    return peak;
  }

  /// Fractional fall from the rolling 12-month peak (0.0 = at peak, 0.35 = -35%).
  double get drawdown => rollingPeak <= 0 ? 0.0 : 1.0 - (price / rollingPeak);

  /// Current price relative to the trailing average. 1.0 until the window is full.
  double get trailingRatio {
    if (recentPrices.length < 12) return 1.0;
    final avg = recentPrices.reduce((a, b) => a + b) / recentPrices.length;
    return avg <= 0 ? 1.0 : price / avg;
  }
}
