import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';
import 'loan.dart';

part 'event_effect.freezed.dart';
part 'event_effect.g.dart';

/// Buys a market class with a fraction of the player's current cash.
@freezed
abstract class MarketBuyFraction with _$MarketBuyFraction {
  const factory MarketBuyFraction({
    required String classId,
    required double fraction, // 0..1 of current cash
  }) = _MarketBuyFraction;

  factory MarketBuyFraction.fromJson(Map<String, dynamic> json) =>
      _$MarketBuyFractionFromJson(json);
}

/// Buys [amount] of a market class at price × (1 − discount) — flash sale.
@freezed
abstract class MarketBuyDiscount with _$MarketBuyDiscount {
  const factory MarketBuyDiscount({
    required String classId,
    required double amount,
    required double discount, // 0..1, e.g. 0.2 = 20% off
  }) = _MarketBuyDiscount;

  factory MarketBuyDiscount.fromJson(Map<String, dynamic> json) =>
      _$MarketBuyDiscountFromJson(json);
}

/// Forces the listed market classes into a crash regime (systemic shock).
@freezed
abstract class ForceMarketCrash with _$ForceMarketCrash {
  const factory ForceMarketCrash({
    required List<String> classIds,
    required int minMonths,
    required int maxMonths,
  }) = _ForceMarketCrash;

  factory ForceMarketCrash.fromJson(Map<String, dynamic> json) =>
      _$ForceMarketCrashFromJson(json);
}

@freezed
abstract class EventEffect with _$EventEffect {
  const factory EventEffect({
    @Default(0.0) double cash,
    @Default(0) int stress,
    @Default(0) int network,
    @Default(0) int credit,
    @Default([]) List<Loan> addedLoans,
    @Default([]) List<Asset> addedAssets,
    @Default([]) List<String> addedFlags,
    @Default([]) List<String> removedFlags,
    String? insightCardId,
    @Default(0.0) double salaryDelta,
    @Default(0.0) double monthlyExpensesDelta,
    @Default(0.0) double cashBySalaryMultiplier,
    @Default(0.0) double cashByOutflowMultiplier,
    // 6.2b: shocks, insurance and market-coupled effects
    double? cashIfInsured, // replaces `cash` when the player has health insurance
    @Default(0) int salarySuspendedMonths, // job loss: months without salary
    @Default([]) List<String> marketSellAllClassIds, // panic sell, at market price + fee
    MarketBuyFraction? marketBuyCashFraction,
    MarketBuyDiscount? marketBuyDiscount,
    ForceMarketCrash? forceMarketCrash,
  }) = _EventEffect;

  const EventEffect._();

  /// Cash impact shared by engine AND UI — one formula, one source.
  /// [insured] swaps the base amount for [cashIfInsured] when present.
  EventCashBreakdown calculateCashBreakdown(double baseSalary, double totalMonthlyOutflow,
      {bool insured = false}) {
    final double base = (insured && cashIfInsured != null) ? cashIfInsured! : cash;
    final double salaryCash = cashBySalaryMultiplier * baseSalary;
    final double outflowCash = cashByOutflowMultiplier * totalMonthlyOutflow;
    final double totalCash = base + salaryCash + outflowCash;

    return EventCashBreakdown(
      baseCash: base,
      salaryCash: salaryCash,
      outflowCash: outflowCash,
      totalCash: totalCash,
    );
  }

  factory EventEffect.fromJson(Map<String, dynamic> json) => _$EventEffectFromJson(json);
}

class EventCashBreakdown {
  final double baseCash;
  final double salaryCash;
  final double outflowCash;
  final double totalCash;

  const EventCashBreakdown({
    required this.baseCash,
    required this.salaryCash,
    required this.outflowCash,
    required this.totalCash,
  });

  bool get hasAnyCash => baseCash != 0 || salaryCash != 0 || outflowCash != 0;
}
