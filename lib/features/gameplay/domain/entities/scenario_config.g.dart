// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScenarioConfig _$ScenarioConfigFromJson(Map<String, dynamic> json) =>
    _ScenarioConfig(
      initialCash: (json['initialCash'] as num).toDouble(),
      baseSalary: (json['baseSalary'] as num).toDouble(),
      monthlyRent: (json['monthlyRent'] as num).toDouble(),
      initialAssets:
          (json['initialAssets'] as List<dynamic>?)
              ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      familySupportExpense:
          (json['familySupportExpense'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ScenarioConfigToJson(_ScenarioConfig instance) =>
    <String, dynamic>{
      'initialCash': instance.initialCash,
      'baseSalary': instance.baseSalary,
      'monthlyRent': instance.monthlyRent,
      'initialAssets': instance.initialAssets.map((e) => e.toJson()).toList(),
      'familySupportExpense': instance.familySupportExpense,
    };
