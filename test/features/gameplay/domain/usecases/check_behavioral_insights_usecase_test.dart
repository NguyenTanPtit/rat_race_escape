import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_behavioral_insights_usecase.dart';

void main() {
  late CheckBehavioralInsightsUseCase usecase;

  setUp(() {
    usecase = CheckBehavioralInsightsUseCase();
  });

  GameState _createState({
    double cash = 10000,
    double outflow = 5000,
    int counter = 0,
    bool hasCreditCard = true,
  }) {
    return GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      scenarioId: 'test',
      cash: cash,
      monthlyExpenses: outflow,
      monthlyRent: 0,
      baseSalary: 10000,
      familySupportExpense: 0,
      consecutiveMinimumCreditCardPayments: counter,
      loans: hasCreditCard
          ? [
              const Loan(
                id: 'cc',
                name: 'CC',
                principalAmount: 1000,
                interestRatePerYear: 20,
                minimumMonthlyPayment: 100,
                type: LoanType.creditCard,
              )
            ]
          : [],
    );
  }

  test('increments counter if there is a credit card and cash >= outflow', () {
    final state = _createState(cash: 10000, outflow: 5000, counter: 0, hasCreditCard: true);
    final result = usecase(state);

    expect(result.consecutiveMinimumCreditCardPayments, 1);
    expect(result.unlockedInsightCardIds.contains('mental_accounting'), isFalse);
  });

  test('unlocks mental_accounting when counter reaches 3', () {
    final state = _createState(cash: 10000, outflow: 5000, counter: 2, hasCreditCard: true);
    final result = usecase(state);

    expect(result.consecutiveMinimumCreditCardPayments, 3);
    expect(result.unlockedInsightCardIds.contains('mental_accounting'), isTrue);
  });

  test('does not unlock again if already unlocked', () {
    var state = _createState(cash: 10000, outflow: 5000, counter: 3, hasCreditCard: true);
    state = state.copyWith(unlockedInsightCardIds: {'mental_accounting', 'other_card'});

    final result = usecase(state);

    expect(result.consecutiveMinimumCreditCardPayments, 4);
    expect(result.unlockedInsightCardIds, {'mental_accounting', 'other_card'});
  });

  test('resets counter if no credit card', () {
    final state = _createState(cash: 10000, outflow: 5000, counter: 2, hasCreditCard: false);
    final result = usecase(state);

    expect(result.consecutiveMinimumCreditCardPayments, 0);
  });

  test('resets counter if cash < outflow even with credit card', () {
    // Has credit card, but cash is 4000, outflow is 5000
    final state = _createState(cash: 4000, outflow: 5000, counter: 2, hasCreditCard: true);
    final result = usecase(state);

    expect(result.consecutiveMinimumCreditCardPayments, 0);
  });
}
