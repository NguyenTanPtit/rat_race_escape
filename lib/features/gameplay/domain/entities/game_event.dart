import 'package:freezed_annotation/freezed_annotation.dart';
import 'event_effect.dart';

part 'game_event.freezed.dart';
part 'game_event.g.dart';

@freezed
abstract class GameEvent with _$GameEvent {
  const factory GameEvent({
    required String id,
    required String title,
    required String description,
    @Default([]) List<EventOption> options,
  }) = _GameEvent;

  factory GameEvent.fromJson(Map<String, dynamic> json) => _$GameEventFromJson(json);
}

@freezed
abstract class EventOption with _$EventOption {
  const factory EventOption({
    required String id,
    required String label,
    @Default(EventEffect()) EventEffect effect,
  }) = _EventOption;

  factory EventOption.fromJson(Map<String, dynamic> json) => _$EventOptionFromJson(json);
}