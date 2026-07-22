// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_class_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketClassConfig _$MarketClassConfigFromJson(Map<String, dynamic> json) =>
    _MarketClassConfig(
      id: json['id'] as String,
      name: json['name'] as String,
      type:
          $enumDecodeNullable(_$AssetTypeEnumMap, json['type']) ??
          AssetType.stock,
      annualYieldRate: (json['annualYieldRate'] as num).toDouble(),
      monthlyDrift: (json['monthlyDrift'] as num).toDouble(),
      monthlyVolatility: (json['monthlyVolatility'] as num).toDouble(),
      meanReversion: (json['meanReversion'] as num?)?.toDouble() ?? 0.0,
      crashChance: (json['crashChance'] as num).toDouble(),
      crashMonthlyDrift: (json['crashMonthlyDrift'] as num).toDouble(),
      crashMinMonths: (json['crashMinMonths'] as num).toInt(),
      crashMaxMonths: (json['crashMaxMonths'] as num).toInt(),
      boomChance: (json['boomChance'] as num).toDouble(),
      boomMonthlyDrift: (json['boomMonthlyDrift'] as num).toDouble(),
      boomMinMonths: (json['boomMinMonths'] as num).toInt(),
      boomMaxMonths: (json['boomMaxMonths'] as num).toInt(),
    );

Map<String, dynamic> _$MarketClassConfigToJson(_MarketClassConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$AssetTypeEnumMap[instance.type]!,
      'annualYieldRate': instance.annualYieldRate,
      'monthlyDrift': instance.monthlyDrift,
      'monthlyVolatility': instance.monthlyVolatility,
      'meanReversion': instance.meanReversion,
      'crashChance': instance.crashChance,
      'crashMonthlyDrift': instance.crashMonthlyDrift,
      'crashMinMonths': instance.crashMinMonths,
      'crashMaxMonths': instance.crashMaxMonths,
      'boomChance': instance.boomChance,
      'boomMonthlyDrift': instance.boomMonthlyDrift,
      'boomMinMonths': instance.boomMinMonths,
      'boomMaxMonths': instance.boomMaxMonths,
    };

const _$AssetTypeEnumMap = {
  AssetType.stock: 'stock',
  AssetType.realEstate: 'realEstate',
  AssetType.business: 'business',
  AssetType.crypto: 'crypto',
};
