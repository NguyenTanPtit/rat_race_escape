import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_event.freezed.dart';

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent({
    required String id,
    required String title,
    required String description,
    @Default([]) List<EventOption> options,
  }) = _GameEvent;
}

@freezed
class EventOption with _$EventOption {
  const factory EventOption({
    required String id,
    required String label, // Nút bấm hiển thị (VD: "Đi nhậu xả láng")

    // Các tác động (Trade-offs) khi chọn option này
    @Default(0.0) double cashEffect,
    @Default(0) int stressEffect,
    @Default(0) int networkEffect,
    @Default(0) int creditEffect,
  }) = _EventOption;
}