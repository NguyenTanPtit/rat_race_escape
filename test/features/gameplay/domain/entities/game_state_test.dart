import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';

void main() {
  group('GameState', () {
    test('calendarMonth getter calculates correctly for different start months', () {
      // Bắt đầu từ tháng 1
      final state1 = GameState(
        country: Country.vietnam,
        currency: Currency.vnd,
        cash: 0,
        monthlyExpenses: 0,
        baseSalary: 0,
        startCalendarMonth: 1,
        currentMonth: 1,
      );
      expect(state1.calendarMonth, 1);
      expect(state1.copyWith(currentMonth: 12).calendarMonth, 12);
      expect(state1.copyWith(currentMonth: 13).calendarMonth, 1);

      // Bắt đầu từ tháng 12
      final state12 = GameState(
        country: Country.vietnam,
        currency: Currency.vnd,
        cash: 0,
        monthlyExpenses: 0,
        baseSalary: 0,
        startCalendarMonth: 12,
        currentMonth: 1,
      );
      expect(state12.calendarMonth, 12);
      expect(state12.copyWith(currentMonth: 2).calendarMonth, 1); // Sang tháng 1
      expect(state12.copyWith(currentMonth: 3).calendarMonth, 2);
    });

    test('toJson and fromJson work correctly (round-trip)', () {
      final state = GameState(
        country: Country.usa,
        currency: Currency.usd,
        cash: 5000,
        monthlyExpenses: 1500,
        baseSalary: 3000,
        startCalendarMonth: 6,
        currentMonth: 5,
        stress: 20,
        networkScore: 50,
        creditScore: 650,
        housingLevel: HousingLevel.studio,
        ownedItems: ['Laptop', 'Bike'],
        flags: {'owns_old_car', 'met_stranger'},
        assets: [
          const Asset(
            id: 'a1',
            name: 'Stock A',
            baseValue: 1000,
            monthlyPassiveIncome: 50,
            type: AssetType.stock,
          )
        ],
        loans: [
          const Loan(
            id: 'l1',
            name: 'Credit Card',
            principalAmount: 500,
            interestRatePerYear: 18.0,
            minimumMonthlyPayment: 25,
            type: LoanType.creditCard,
          )
        ],
      );

      final json = state.toJson();
      final newState = GameState.fromJson(json);

      expect(newState, equals(state));
      expect(newState.flags.contains('owns_old_car'), isTrue);
      expect(newState.assets.length, 1);
      expect(newState.assets.first.name, 'Stock A');
      expect(newState.loans.length, 1);
      expect(newState.loans.first.interestRatePerYear, 18.0);
    });
  });
}
