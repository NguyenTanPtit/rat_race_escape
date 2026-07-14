import 'package:freezed_annotation/freezed_annotation.dart';

part 'scenario_config.freezed.dart';
part 'scenario_config.g.dart';

@freezed
abstract class ScenarioConfig with _$ScenarioConfig {
  const factory ScenarioConfig({
    required double initialCash,
    required double baseSalary,
    required double monthlyRent,
    @Default(0.0) double initialPassiveIncome,
    @Default(0.0) double familySupportExpense,
  }) = _ScenarioConfig;

  factory ScenarioConfig.fromJson(Map<String, dynamic> json) => _$ScenarioConfigFromJson(json);
}
