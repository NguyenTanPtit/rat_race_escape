import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';
import 'loan.dart';
import 'market_class_state.dart';
import 'pending_proceed.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum HousingLevel { shabbyRoom, studio, condo, villa , luxuryCondo}
enum Country { vietnam, usa, japan }
enum Currency { vnd, usd, jpy }

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    // 0. Country & Currency Context
    required Country country,
    required Currency currency,
    required String scenarioId,

    // 1. Time
    @Default(1) int currentMonth,
    @Default(264) int ageInMonths, // Default is 22 years old
    @Default(1) int startCalendarMonth, // Starting month of the year (1-12)

    // 2. Financials (Must be initialized depending on context)
    required double cash,
    required double monthlyExpenses,
    required double monthlyRent,
    required double baseSalary,

    // 3. Metrics
    @Default(0) int stress,
    @Default(0) int networkScore,
    @Default(600) int creditScore,

    // 4. Visual States
    @Default(HousingLevel.shabbyRoom) HousingLevel housingLevel,
    @Default([]) List<String> ownedItems,

    // 5. Active Event & Flags
    String? currentEventId,
    @Default({}) Set<String> flags,
    @Default({}) Set<String> unlockedInsightCardIds,
    @Default(0.0) double familySupportExpense,
    @Default(0.2) double baseEventChance,
    @Default(3) int bankruptcyMonthsThreshold,
    @Default(100000) double leisureCostPerStressPoint,
    @Default(20) int maxLeisureStressReliefPerMonth,
    @Default(0) int leisureReliefUsedThisMonth,
    @Default(0) int consecutiveMinimumCreditCardPayments,
    @Default(0) int sideJobsWorkedThisMonth,
    @Default(2500000.0) double sideJobIncome,
    @Default(8) int sideJobStress,
    @Default(2) int maxSideJobsPerMonth,
    @Default(0.03) double assetSellFeeRate,
    @Default(0) int salarySuspendedMonths, // job loss: months left without salary
    @Default(false) bool hasHealthInsurance,
    @Default(0.0) double healthInsurancePremiumMonthly, // 0 = not offered in scenario

    // Inflation (applied every Tet). Cash is deliberately NOT indexed —
    // money sitting still is money dying.
    @Default(0.0) double inflationAnnualRate,
    @Default(0.0) double salaryGrowthAnnualRate,
    @Default(1.0) double inflationIndex,

    // 6. Inventories
    @Default([]) List<Asset> assets,
    @Default([]) List<Loan> loans,

    // 7. Market (per asset class; empty for pre-market saves)
    @Default({}) Map<String, MarketClassState> market,
    // Sale proceeds still settling (liquidity delay); cash arrives when due.
    @Default([]) List<PendingProceed> pendingProceeds,
  }) = _GameState;

  // Custom getters can be added through private constructor
  const GameState._();

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

  int get age => ageInMonths ~/ 12;

  /// Market value of a single asset: units × current price for market holdings,
  /// baseValue for legacy assets. Single source of truth — UI must use this too.
  double assetMarketValue(Asset asset) {
    final classState = asset.marketClassId == null ? null : market[asset.marketClassId];
    if (classState == null) return asset.baseValue;
    return asset.units * classState.price;
  }

  /// Sale money still settling — yours, but not spendable yet.
  double get totalPendingProceeds =>
      pendingProceeds.fold(0, (sum, p) => sum + p.amount);

  double get netWorth {
    double totalAssets = assets.fold(0, (sum, asset) => sum + assetMarketValue(asset));
    double totalLoans = loans.fold(0, (sum, loan) => sum + loan.principalAmount);
    return cash + totalAssets + totalPendingProceeds - totalLoans;
  }

  double get passiveIncome => assets.fold(0, (sum, a) => sum + a.monthlyPassiveIncome);

  /// Salary actually received this month (0 while suspended by job loss).
  double get effectiveSalary => salarySuspendedMonths > 0 ? 0.0 : baseSalary;

  double get totalMonthlyOutflow => monthlyExpenses + familySupportExpense + monthlyRent +
      (hasHealthInsurance ? healthInsurancePremiumMonthly : 0.0);

  double get totalCashFlow => effectiveSalary + passiveIncome - totalMonthlyOutflow;

  double get totalLoanPayment => loans.fold(0, (sum, loan) => sum + loan.minimumMonthlyPayment);
  double get totalLoanInterest => loans.fold(0, (sum, loan) => sum + (loan.principalAmount * loan.interestRatePerYear / 100 / 12));

  int get calendarMonth => ((startCalendarMonth - 1 + currentMonth - 1) % 12) + 1;
}