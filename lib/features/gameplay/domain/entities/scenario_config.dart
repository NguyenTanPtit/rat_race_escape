import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';
import 'loan.dart';
import 'game_state.dart';

part 'scenario_config.freezed.dart';
part 'scenario_config.g.dart';

@freezed
abstract class ScenarioConfig with _$ScenarioConfig {
  const factory ScenarioConfig({
    required String id,
    required double initialCash,
    required double baseSalary,
    required double monthlyRent,
    required double monthlyExpenses,
    @Default([]) List<Asset> initialAssets,
    @Default([]) List<Loan> initialLoans,
    @Default(0.0) double familySupportExpense,
    required int startAgeInMonths,
    required int startCalendarMonth,
    required int initialCreditScore,
    required HousingLevel housingLevel,
    required Country country,
    required String currency,
    @Default(3) int bankruptcyMonthsThreshold,
    @Default(100000) double leisureCostPerStressPoint,
    @Default(20) int maxLeisureStressReliefPerMonth,
    @Default(0.2) double baseEventChance,
  }) = _ScenarioConfig;

  factory ScenarioConfig.fromJson(Map<String, dynamic> json) => _$ScenarioConfigFromJson(json);
}
