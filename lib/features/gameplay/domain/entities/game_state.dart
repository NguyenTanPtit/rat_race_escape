import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';
import 'loan.dart';

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

    // 6. Inventories
    @Default([]) List<Asset> assets,
    @Default([]) List<Loan> loans,
  }) = _GameState;

  // Custom getters can be added through private constructor
  const GameState._();

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

  double get netWorth {
    double totalAssets = assets.fold(0, (sum, asset) => sum + asset.baseValue);
    double totalLoans = loans.fold(0, (sum, loan) => sum + loan.principalAmount);
    return cash + totalAssets - totalLoans;
  }

  double get passiveIncome => assets.fold(0, (sum, a) => sum + a.monthlyPassiveIncome);

  double get totalMonthlyOutflow => monthlyExpenses + familySupportExpense + monthlyRent;

  double get totalCashFlow => baseSalary + passiveIncome - totalMonthlyOutflow;

  int get calendarMonth => ((startCalendarMonth - 1 + currentMonth - 1) % 12) + 1;
}