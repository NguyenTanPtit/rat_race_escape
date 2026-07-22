import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';

part 'market_class_config.freezed.dart';
part 'market_class_config.g.dart';

/// Static configuration of a tradable market asset class (loaded from scenario JSON).
@freezed
abstract class MarketClassConfig with _$MarketClassConfig {
  const factory MarketClassConfig({
    required String id,
    required String name,
    @Default(AssetType.stock) AssetType type,
    required double annualYieldRate, // % per year on base price 1.0
    required double monthlyDrift, // trend, % per month
    required double monthlyVolatility, // uniform noise amplitude, ± % per month
    // Fraction of the gap to the trend price closed per month (0 = pure
    // random walk). Keeps long-run prices anchored so yield-on-cost stays
    // meaningful, and makes crashes recover gradually instead of forever.
    @Default(0.0) double meanReversion,
    required double crashChance, // per month, only while regime is normal
    required double crashMonthlyDrift, // % per month while crashing (negative)
    required int crashMinMonths,
    required int crashMaxMonths,
    required double boomChance, // per month, only while regime is normal
    required double boomMonthlyDrift, // % per month while booming
    required int boomMinMonths,
    required int boomMaxMonths,
  }) = _MarketClassConfig;

  factory MarketClassConfig.fromJson(Map<String, dynamic> json) =>
      _$MarketClassConfigFromJson(json);
}
