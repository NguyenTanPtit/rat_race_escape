import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';

/// Applies one year of inflation, once per Tet (calendarMonth == 1).
///
/// Costs and nominal incomes (salary, dividends, rent received) all scale up;
/// CASH AND PENDING PROCEEDS DO NOT. That asymmetry is the whole lesson:
/// money sitting still loses purchasing power every single year.
///
/// Asset PRICES are deliberately left in real terms so every market signal
/// (drawdown, trailing ratio, crash/boom thresholds, the "% so với đầu kỳ"
/// readout) keeps its meaning. [BuyMarketAssetUseCase] compensates by scaling
/// new purchases' passive income by [GameState.inflationIndex], which keeps
/// the REAL yield of a purchase constant no matter when it happens.
@lazySingleton
class ApplyInflationUseCase {
  /// Call with the state of a month that has already been advanced; it only
  /// acts when that month is Tet and the scenario defines an inflation rate.
  GameState call(GameState currentState) {
    if (currentState.inflationAnnualRate <= 0) return currentState;
    if (currentState.calendarMonth != 1) return currentState;
    // Month 1 of the very first year is the starting state, not an anniversary.
    if (currentState.currentMonth <= 1) return currentState;

    final priceFactor = 1 + currentState.inflationAnnualRate;
    final salaryFactor = 1 + currentState.salaryGrowthAnnualRate;

    return currentState.copyWith(
      monthlyExpenses: currentState.monthlyExpenses * priceFactor,
      monthlyRent: currentState.monthlyRent * priceFactor,
      familySupportExpense: currentState.familySupportExpense * priceFactor,
      healthInsurancePremiumMonthly:
          currentState.healthInsurancePremiumMonthly * priceFactor,
      // Leisure is a purchase like any other; left un-indexed it would drift
      // toward being free, turning stress relief into a late-game exploit.
      leisureCostPerStressPoint: currentState.leisureCostPerStressPoint * priceFactor,
      baseSalary: currentState.baseSalary * salaryFactor,
      // Side-job pay is wage income: it tracks salary growth, not prices.
      sideJobIncome: currentState.sideJobIncome * salaryFactor,
      assets: currentState.assets
          .map((a) => a.copyWith(
              monthlyPassiveIncome: a.monthlyPassiveIncome * priceFactor))
          .toList(),
      inflationIndex: currentState.inflationIndex * priceFactor,
    );
  }
}
