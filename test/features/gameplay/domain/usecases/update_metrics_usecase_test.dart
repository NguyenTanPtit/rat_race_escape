import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/update_metrics_usecase.dart';

void main() {
  late UpdateMetricsUseCase useCase;

  setUp(() {
    useCase = UpdateMetricsUseCase();
  });

  const baseState = GameState(
    scenarioId: 'test_scenario',
    country: Country.vietnam,
    currency: Currency.vnd,
    cash: 0,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
    creditScore: 600,
    stress: 20,
  );

  test('UpdateMetricsUseCase decreases credit and increases stress when cash < 0', () {
    final state = baseState.copyWith(cash: -100);
    final result = useCase(state);
    
    expect(result.stress, 30);
    expect(result.creditScore, 580);
  });

  test('UpdateMetricsUseCase increases credit by 2 when cash >= 0 and has loans', () {
    final state = baseState.copyWith(
      cash: 100,
      loans: [
        const Loan(id: '1', name: 'Loan', principalAmount: 100, interestRatePerYear: 5, minimumMonthlyPayment: 10),
      ]
    );
    final result = useCase(state);
    
    expect(result.stress, 20); // No change
    expect(result.creditScore, 602);
  });

  test('UpdateMetricsUseCase increases credit when cash >= 0 but no loans', () {
    final state = baseState.copyWith(cash: 100, loans: []);
    final result = useCase(state);
    
    expect(result.stress, 20); // No change
    expect(result.creditScore, 602); // Increases by 2
  });

  test('UpdateMetricsUseCase caps credit score at 850', () {
    final state = baseState.copyWith(
      cash: 100,
      creditScore: 849,
      loans: [
        const Loan(id: '1', name: 'Loan', principalAmount: 100, interestRatePerYear: 5, minimumMonthlyPayment: 10),
      ]
    );
    final result = useCase(state);
    
    expect(result.creditScore, 850);
  });

  test('UpdateMetricsUseCase caps credit score at 300', () {
    final state = baseState.copyWith(
      cash: -100,
      creditScore: 310,
    );
    final result = useCase(state);
    
    expect(result.creditScore, 300);
  });

  test('UpdateMetricsUseCase caps stress at 100', () {
    final state = baseState.copyWith(
      cash: -100,
      stress: 95,
    );
    final result = useCase(state);
    
    expect(result.stress, 100);
  });
}
