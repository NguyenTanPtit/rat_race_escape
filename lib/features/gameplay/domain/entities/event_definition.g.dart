// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventDefinition _$EventDefinitionFromJson(Map<String, dynamic> json) =>
    _EventDefinition(
      event: GameEvent.fromJson(json['event'] as Map<String, dynamic>),
      trigger: EventTrigger.fromJson(json['trigger'] as Map<String, dynamic>),
      absoluteChance: (json['absoluteChance'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$EventDefinitionToJson(_EventDefinition instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'trigger': instance.trigger.toJson(),
      'absoluteChance': instance.absoluteChance,
      'weight': instance.weight,
    };

_MarketCondition _$MarketConditionFromJson(Map<String, dynamic> json) =>
    _MarketCondition(
      classId: json['classId'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$MarketConditionToJson(_MarketCondition instance) =>
    <String, dynamic>{'classId': instance.classId, 'value': instance.value};

_EventTrigger _$EventTriggerFromJson(Map<String, dynamic> json) =>
    _EventTrigger(
      minAgeInMonths: (json['minAgeInMonths'] as num?)?.toInt(),
      maxAgeInMonths: (json['maxAgeInMonths'] as num?)?.toInt(),
      minStress: (json['minStress'] as num?)?.toInt(),
      maxStress: (json['maxStress'] as num?)?.toInt(),
      targetCalendarMonths:
          (json['targetCalendarMonths'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      requiredFlags:
          (json['requiredFlags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      excludedFlags:
          (json['excludedFlags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      maxCash: (json['maxCash'] as num?)?.toDouble(),
      minMarketDrawdown: json['minMarketDrawdown'] == null
          ? null
          : MarketCondition.fromJson(
              json['minMarketDrawdown'] as Map<String, dynamic>,
            ),
      minMarketTrailingRatio: json['minMarketTrailingRatio'] == null
          ? null
          : MarketCondition.fromJson(
              json['minMarketTrailingRatio'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$EventTriggerToJson(_EventTrigger instance) =>
    <String, dynamic>{
      'minAgeInMonths': instance.minAgeInMonths,
      'maxAgeInMonths': instance.maxAgeInMonths,
      'minStress': instance.minStress,
      'maxStress': instance.maxStress,
      'targetCalendarMonths': instance.targetCalendarMonths,
      'requiredFlags': instance.requiredFlags.toList(),
      'excludedFlags': instance.excludedFlags.toList(),
      'maxCash': instance.maxCash,
      'minMarketDrawdown': instance.minMarketDrawdown?.toJson(),
      'minMarketTrailingRatio': instance.minMarketTrailingRatio?.toJson(),
    };
