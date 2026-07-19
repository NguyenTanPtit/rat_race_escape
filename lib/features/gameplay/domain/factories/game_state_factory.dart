import '../entities/game_state.dart';
import '../entities/scenario_config.dart';

class GameStateFactory {
  /// Builds a GameState entirely from a ScenarioConfig.
  static GameState fromConfig(ScenarioConfig config) {
    return GameState(
      scenarioId: config.id,
      country: config.country,
      currency: parseCurrency(config.currency),
      cash: config.initialCash,
      baseSalary: config.baseSalary,
      monthlyExpenses: config.monthlyExpenses,
      monthlyRent: config.monthlyRent,
      familySupportExpense: config.familySupportExpense,
      ageInMonths: config.startAgeInMonths,
      startCalendarMonth: config.startCalendarMonth,
      creditScore: config.initialCreditScore,
      housingLevel: config.housingLevel,
      bankruptcyMonthsThreshold: config.bankruptcyMonthsThreshold,
      baseEventChance: config.baseEventChance,
      leisureCostPerStressPoint: config.leisureCostPerStressPoint,
      maxLeisureStressReliefPerMonth: config.maxLeisureStressReliefPerMonth,
      assets: List.from(config.initialAssets),
      loans: List.from(config.initialLoans),
      sideJobIncome: config.sideJobIncome,
      sideJobStress: config.sideJobStress,
      maxSideJobsPerMonth: config.maxSideJobsPerMonth,
      assetSellFeeRate: config.assetSellFeeRate,
    );
  }

  static Currency parseCurrency(String currencyStr) {
    switch (currencyStr.toLowerCase()) {
      case 'usd': return Currency.usd;
      case 'jpy': return Currency.jpy;
      case 'vnd':
      default: return Currency.vnd;
    }
  }
}