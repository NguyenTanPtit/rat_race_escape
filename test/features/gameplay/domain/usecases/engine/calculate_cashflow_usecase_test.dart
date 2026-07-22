import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';

void main() {
  late CalculateCashflowUseCase usecase;

  setUp(() {
    usecase = CalculateCashflowUseCase();
  });

  group('CalculateCashflowUseCase', () {
    test('should subtract monthlyRent when calculating cash flow', () {
      final state = GameState(
        scenarioId: 'test',
        country: Country.vietnam,
        currency: Currency.vnd,
        cash: 10000,
        baseSalary: 5000,
        monthlyExpenses: 1000,
        monthlyRent: 2000,
      );

      final newState = usecase(state);

      // Cash flow = Salary (5000) - (Expenses (1000) + Rent (2000)) = 2000
      // New Cash = 10000 + 2000 = 12000
      expect(newState.cash, 12000);
      expect(newState.totalMonthlyOutflow, 3000);
    });
  });
}
