import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/pay_debt_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_game_status_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckGameStatusUseCase extends Mock implements CheckGameStatusUseCase {}
class FakeGameState extends Fake implements GameState {}

void main() {
  late MockCheckGameStatusUseCase mockCheckGameStatusUseCase;
  late PayDebtUseCase usecase;

  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  setUp(() {
    mockCheckGameStatusUseCase = MockCheckGameStatusUseCase();
    usecase = PayDebtUseCase(mockCheckGameStatusUseCase);
    
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));
  });

  final testLoan = const Loan(
    id: 'loan_1',
    name: 'Credit Card',
    principalAmount: 5000,
    interestRatePerYear: 15,
    minimumMonthlyPayment: 200,
    type: LoanType.creditCard,
  );

  final initialState = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'default',
    monthlyExpenses: 1000,
    monthlyRent: 200,
    baseSalary: 3000,
    cash: 10000,
    consecutiveMinimumCreditCardPayments: 5,
    loans: [testLoan],
  );

  test('successfully pays partial debt and resets consecutive minimum tracker', () {
    final result = usecase(initialState, 'loan_1', 1000);

    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    expect(turnResult, isA<TurnContinued>());
    final finalState = (turnResult as TurnContinued).state;

    expect(finalState.cash, 9000);
    expect(finalState.loans.length, 1);
    expect(finalState.loans[0].principalAmount, 4000);
    expect(finalState.consecutiveMinimumCreditCardPayments, 0); // Reset
  });

  test('successfully pays full debt and removes loan (exact amount)', () {
    final result = usecase(initialState, 'loan_1', 5000);

    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    final finalState = (turnResult as TurnContinued).state;

    expect(finalState.cash, 5000);
    expect(finalState.loans.length, 0);
  });

  test('fails if amount exceeds loan principal', () {
    final result = usecase(initialState, 'loan_1', 6000); // Exceeds 5000

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'Amount cannot exceed loan principal');
  });

  test('fails if not enough cash', () {
    final result = usecase(initialState, 'loan_1', 20000);

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'Not enough cash');
  });

  test('fails if loan not found', () {
    final result = usecase(initialState, 'loan_2', 1000);

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'Loan not found');
  });
}
