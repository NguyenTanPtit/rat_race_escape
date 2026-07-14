import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';
import 'loan.dart';

part 'game_state.freezed.dart';

enum HousingLevel { shabbyRoom, studio, condo, villa , luxuryCondo}
enum Country { vietnam, usa, japan }
enum Currency { vnd, usd, jpy }

@freezed
class GameState with _$GameState {
  const factory GameState({
    // 0. Bối cảnh Quốc gia & Tiền tệ
    required Country country,
    required Currency currency,

    // 1. Time
    @Default(1) int currentMonth,
    @Default(264) int ageInMonths, // Mặc định chung là 22 tuổi

    // 2. Financials (Bắt buộc phải khởi tạo tùy bối cảnh)
    required double cash,
    @Default(0.0) double passiveIncome,
    required double monthlyExpenses,
    required double baseSalary,

    // 3. Metrics
    @Default(0) int stress,
    @Default(0) int networkScore,
    @Default(600) int creditScore,

    // 4. Visual States
    @Default(HousingLevel.shabbyRoom) HousingLevel housingLevel,
    @Default([]) List<String> ownedItems,

    // 5. Active Event
    String? currentEventId,

    // 6. Inventories
    @Default([]) List<Asset> assets,
    @Default([]) List<Loan> loans,
  }) = _GameState;

  // Custom getters có thể được thêm vào thông qua constructor private
  const GameState._();

  double get netWorth {
    double totalAssets = assets.fold(0, (sum, asset) => sum + asset.baseValue);
    double totalLoans = loans.fold(0, (sum, loan) => sum + loan.principalAmount);
    return cash + totalAssets - totalLoans;
  }

  double get totalCashFlow => baseSalary + passiveIncome - monthlyExpenses;
}