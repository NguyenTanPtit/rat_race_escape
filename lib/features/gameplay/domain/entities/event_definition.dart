import 'package:freezed_annotation/freezed_annotation.dart';
import 'game_event.dart';

part 'event_definition.freezed.dart';
part 'event_definition.g.dart';

@freezed
abstract class EventDefinition with _$EventDefinition {
  const factory EventDefinition({
    required GameEvent event,
    required EventTrigger trigger,
    double? absoluteChance,
    @Default(1.0) double weight,
  }) = _EventDefinition;

  factory EventDefinition.fromJson(Map<String, dynamic> json) => _$EventDefinitionFromJson(json);
}

@freezed
abstract class EventTrigger with _$EventTrigger {
  const factory EventTrigger({
    int? minAgeInMonths,
    int? maxAgeInMonths,
    int? minStress,
    int? maxStress,
    @Default([]) List<int> targetCalendarMonths,
    @Default({}) Set<String> requiredFlags,
    @Default({}) Set<String> excludedFlags,
  }) = _EventTrigger;

  factory EventTrigger.fromJson(Map<String, dynamic> json) => _$EventTriggerFromJson(json);
}
