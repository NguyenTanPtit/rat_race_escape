// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_effect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketBuyFraction _$MarketBuyFractionFromJson(Map<String, dynamic> json) =>
    _MarketBuyFraction(
      classId: json['classId'] as String,
      fraction: (json['fraction'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketBuyFractionToJson(_MarketBuyFraction instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'fraction': instance.fraction,
    };

_MarketBuyDiscount _$MarketBuyDiscountFromJson(Map<String, dynamic> json) =>
    _MarketBuyDiscount(
      classId: json['classId'] as String,
      amount: (json['amount'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketBuyDiscountToJson(_MarketBuyDiscount instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'amount': instance.amount,
      'discount': instance.discount,
    };

_ForceMarketCrash _$ForceMarketCrashFromJson(Map<String, dynamic> json) =>
    _ForceMarketCrash(
      classIds: (json['classIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      minMonths: (json['minMonths'] as num).toInt(),
      maxMonths: (json['maxMonths'] as num).toInt(),
    );

Map<String, dynamic> _$ForceMarketCrashToJson(_ForceMarketCrash instance) =>
    <String, dynamic>{
      'classIds': instance.classIds,
      'minMonths': instance.minMonths,
      'maxMonths': instance.maxMonths,
    };

_EventEffect _$EventEffectFromJson(Map<String, dynamic> json) => _EventEffect(
  cash: (json['cash'] as num?)?.toDouble() ?? 0.0,
  stress: (json['stress'] as num?)?.toInt() ?? 0,
  network: (json['network'] as num?)?.toInt() ?? 0,
  credit: (json['credit'] as num?)?.toInt() ?? 0,
  addedLoans:
      (json['addedLoans'] as List<dynamic>?)
          ?.map((e) => Loan.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  addedAssets:
      (json['addedAssets'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  addedFlags:
      (json['addedFlags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  removedFlags:
      (json['removedFlags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  insightCardId: json['insightCardId'] as String?,
  salaryDelta: (json['salaryDelta'] as num?)?.toDouble() ?? 0.0,
  monthlyExpensesDelta:
      (json['monthlyExpensesDelta'] as num?)?.toDouble() ?? 0.0,
  cashBySalaryMultiplier:
      (json['cashBySalaryMultiplier'] as num?)?.toDouble() ?? 0.0,
  cashByOutflowMultiplier:
      (json['cashByOutflowMultiplier'] as num?)?.toDouble() ?? 0.0,
  cashIfInsured: (json['cashIfInsured'] as num?)?.toDouble(),
  salarySuspendedMonths: (json['salarySuspendedMonths'] as num?)?.toInt() ?? 0,
  marketSellAllClassIds:
      (json['marketSellAllClassIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  marketBuyCashFraction: json['marketBuyCashFraction'] == null
      ? null
      : MarketBuyFraction.fromJson(
          json['marketBuyCashFraction'] as Map<String, dynamic>,
        ),
  marketBuyDiscount: json['marketBuyDiscount'] == null
      ? null
      : MarketBuyDiscount.fromJson(
          json['marketBuyDiscount'] as Map<String, dynamic>,
        ),
  forceMarketCrash: json['forceMarketCrash'] == null
      ? null
      : ForceMarketCrash.fromJson(
          json['forceMarketCrash'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$EventEffectToJson(_EventEffect instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'stress': instance.stress,
      'network': instance.network,
      'credit': instance.credit,
      'addedLoans': instance.addedLoans.map((e) => e.toJson()).toList(),
      'addedAssets': instance.addedAssets.map((e) => e.toJson()).toList(),
      'addedFlags': instance.addedFlags,
      'removedFlags': instance.removedFlags,
      'insightCardId': instance.insightCardId,
      'salaryDelta': instance.salaryDelta,
      'monthlyExpensesDelta': instance.monthlyExpensesDelta,
      'cashBySalaryMultiplier': instance.cashBySalaryMultiplier,
      'cashByOutflowMultiplier': instance.cashByOutflowMultiplier,
      'cashIfInsured': instance.cashIfInsured,
      'salarySuspendedMonths': instance.salarySuspendedMonths,
      'marketSellAllClassIds': instance.marketSellAllClassIds,
      'marketBuyCashFraction': instance.marketBuyCashFraction?.toJson(),
      'marketBuyDiscount': instance.marketBuyDiscount?.toJson(),
      'forceMarketCrash': instance.forceMarketCrash?.toJson(),
    };
