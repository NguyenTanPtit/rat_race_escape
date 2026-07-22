// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_class_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketClassState _$MarketClassStateFromJson(Map<String, dynamic> json) =>
    _MarketClassState(
      config: MarketClassConfig.fromJson(
        json['config'] as Map<String, dynamic>,
      ),
      price: (json['price'] as num?)?.toDouble() ?? 1.0,
      peakPrice: (json['peakPrice'] as num?)?.toDouble() ?? 1.0,
      trendPrice: (json['trendPrice'] as num?)?.toDouble() ?? 1.0,
      regime:
          $enumDecodeNullable(_$MarketRegimeEnumMap, json['regime']) ??
          MarketRegime.normal,
      regimeMonthsLeft: (json['regimeMonthsLeft'] as num?)?.toInt() ?? 0,
      recentPrices:
          (json['recentPrices'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MarketClassStateToJson(_MarketClassState instance) =>
    <String, dynamic>{
      'config': instance.config.toJson(),
      'price': instance.price,
      'peakPrice': instance.peakPrice,
      'trendPrice': instance.trendPrice,
      'regime': _$MarketRegimeEnumMap[instance.regime]!,
      'regimeMonthsLeft': instance.regimeMonthsLeft,
      'recentPrices': instance.recentPrices,
    };

const _$MarketRegimeEnumMap = {
  MarketRegime.normal: 'normal',
  MarketRegime.boom: 'boom',
  MarketRegime.crash: 'crash',
};
