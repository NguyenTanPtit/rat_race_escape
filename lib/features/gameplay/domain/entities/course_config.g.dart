// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseConfig _$CourseConfigFromJson(Map<String, dynamic> json) =>
    _CourseConfig(
      id: json['id'] as String,
      name: json['name'] as String,
      baseCost: (json['baseCost'] as num).toDouble(),
      durationMonths: (json['durationMonths'] as num).toInt(),
      stressPerMonth: (json['stressPerMonth'] as num).toInt(),
      salaryBoostRate: (json['salaryBoostRate'] as num).toDouble(),
    );

Map<String, dynamic> _$CourseConfigToJson(_CourseConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseCost': instance.baseCost,
      'durationMonths': instance.durationMonths,
      'stressPerMonth': instance.stressPerMonth,
      'salaryBoostRate': instance.salaryBoostRate,
    };
