// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameEvent _$GameEventFromJson(Map<String, dynamic> json) => _GameEvent(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => EventOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GameEventToJson(_GameEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

_EventOption _$EventOptionFromJson(Map<String, dynamic> json) => _EventOption(
  id: json['id'] as String,
  label: json['label'] as String,
  cashEffect: (json['cashEffect'] as num?)?.toDouble() ?? 0.0,
  stressEffect: (json['stressEffect'] as num?)?.toInt() ?? 0,
  networkEffect: (json['networkEffect'] as num?)?.toInt() ?? 0,
  creditEffect: (json['creditEffect'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$EventOptionToJson(_EventOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'cashEffect': instance.cashEffect,
      'stressEffect': instance.stressEffect,
      'networkEffect': instance.networkEffect,
      'creditEffect': instance.creditEffect,
    };
