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
      initialPassiveIncome:
          (json['initialPassiveIncome'] as num?)?.toDouble() ?? 0.0,
      familySupportExpense:
          (json['familySupportExpense'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ScenarioConfigToJson(_ScenarioConfig instance) =>
    <String, dynamic>{
      'initialCash': instance.initialCash,
      'baseSalary': instance.baseSalary,
      'monthlyRent': instance.monthlyRent,
      'initialPassiveIncome': instance.initialPassiveIncome,
      'familySupportExpense': instance.familySupportExpense,
    };
