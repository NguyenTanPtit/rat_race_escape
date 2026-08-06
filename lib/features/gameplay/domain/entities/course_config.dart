import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_config.freezed.dart';
part 'course_config.g.dart';

/// Static configuration of a self-upgrade course (loaded from scenario JSON).
///
/// The listed cost is a BASE price: the actual price at purchase time is
/// baseCost × [GameState.inflationIndex], so studying early is cheaper.
@freezed
abstract class CourseConfig with _$CourseConfig {
  const factory CourseConfig({
    required String id,
    required String name,
    required double baseCost, // real price; multiply by inflationIndex to buy
    required int durationMonths,
    required int stressPerMonth, // added every month while studying
    required double salaryBoostRate, // permanent, e.g. 0.08 = +8% on graduation
  }) = _CourseConfig;

  factory CourseConfig.fromJson(Map<String, dynamic> json) =>
      _$CourseConfigFromJson(json);
}
