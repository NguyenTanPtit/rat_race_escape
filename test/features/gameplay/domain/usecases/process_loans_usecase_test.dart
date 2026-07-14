import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_loans_usecase.dart';

void main() {
  late ProcessLoansUseCase usecase;

  setUp(() {
    usecase = ProcessLoansUseCase();
  });

  group('ProcessLoansUseCase', () {
    test('should calculate interest correctly based on percentage (Task 0.1)', () {

      
      var state = GameState(
        scenarioId: 'test_scenario',
        country: Country.usa,
        currency: Currency.usd,
        cash: 5000,
        monthlyExpenses: 0,
        monthlyRent: 0,
        baseSalary: 0,
        loans: [
          const Loan(
            id: 'l1',
            name: 'Student Loan',
            principalAmount: 30000,
            interestRatePerYear: 5.5,
            minimumMonthlyPayment: 300,
            type: LoanType.personalLoan,
          )
        ],
      );


      state = usecase(state);
      expect(state.loans.first.principalAmount, closeTo(29837.5, 0.1));
      

      for (int i = 0; i < 11; i++) {
        state = usecase(state);
      }
      

      expect(state.loans.first.principalAmount, closeTo(28000.08, 1.0));
    });

    test('should handle ghost loan bug and remove fully paid loans (Task 0.2)', () {

      
      var state = GameState(
        scenarioId: 'test_scenario',
        country: Country.vietnam,
        currency: Currency.vnd,
        cash: 10000.0,
        monthlyExpenses: 500.0,
        monthlyRent: 200.0,
        baseSalary: 3000.0,
        loans: [
          const Loan(
            id: 'l2',
            name: 'Credit Card',
            principalAmount: 250,
            interestRatePerYear: 12.0,
            minimumMonthlyPayment: 300,
            type: LoanType.creditCard,
          )
        ],
      );

      state = usecase(state);
      

      expect(state.cash, 10000.0 - 252.5);
      

      expect(state.loans.isEmpty, true);
    });
  });
}
