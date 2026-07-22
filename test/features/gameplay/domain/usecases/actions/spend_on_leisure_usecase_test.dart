import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/spend_on_leisure_usecase.dart';

class MockCheckGameStatusUseCase extends Mock implements CheckGameStatusUseCase {}

class FakeGameState extends Fake implements GameState {}

void main() {
  late SpendOnLeisureUseCase usecase;
  late MockCheckGameStatusUseCase mockCheckGameStatusUseCase;

  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  setUp(() {
    mockCheckGameStatusUseCase = MockCheckGameStatusUseCase();
    usecase = SpendOnLeisureUseCase(mockCheckGameStatusUseCase);
  });

  final baseState = const GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test_scenario',
    cash: 5000000,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
    stress: 50,
    leisureCostPerStressPoint: 100000,
    maxLeisureStressReliefPerMonth: 20,
    leisureReliefUsedThisMonth: 0,
  );

  test('1. Success: Tính đủ stress, tiêu đúng tiền', () {
    // Arrange
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));
    
    // Act
    // Spend 1,000,000 -> relieves 10 stress
    final result = usecase(baseState, 1000000);

    // Assert
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('Should be right'),
      (r) {
        final state = (r as TurnContinued).state;
        expect(state.stress, 40); // 50 - 10
        expect(state.cash, 4000000); // 5000000 - 1000000
        expect(state.leisureReliefUsedThisMonth, 10);
      },
    );
  });

  test('2. Success: Trần tháng (chỉ giảm tối đa 20 dù đưa lượng tiền lớn, tiền trừ khớp mức giảm)', () {
    // Arrange
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));
    
    // Act
    // Spend 3,000,000 -> potential 30 stress, but capped at 20.
    final result = usecase(baseState, 3000000);

    // Assert
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('Should be right'),
      (r) {
        final state = (r as TurnContinued).state;
        expect(state.stress, 30); // 50 - 20 (cap)
        expect(state.cash, 3000000); // Only deducted 20 * 100k = 2M. So 5M - 2M = 3M
        expect(state.leisureReliefUsedThisMonth, 20);
      },
    );
  });

  test('3. Success: Đưa tiền thừa (VD: 250k với rate 100k -> giảm 2 stress, tiêu 200k, giữ lại 50k)', () {
    // Arrange
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));
    
    // Act
    // Spend 250,000 -> relieves 2 stress. Costs 200,000.
    final result = usecase(baseState, 250000);

    // Assert
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('Should be right'),
      (r) {
        final state = (r as TurnContinued).state;
        expect(state.stress, 48); // 50 - 2
        expect(state.cash, 4800000); // 5000000 - 2000000
        expect(state.leisureReliefUsedThisMonth, 2);
      },
    );
  });

  test('4. Failure: Không đủ tiền', () {
    // Act
    final result = usecase(baseState, 6000000); // More than 5M cash

    // Assert
    expect(result.isLeft(), true);
    result.fold(
      (l) => expect(l.message, contains('Not enough cash')),
      (r) => fail('Should be left'),
    );
  });

  test('5. Failure: Amount <= 0', () {
    // Act
    final result = usecase(baseState, 0);

    // Assert
    expect(result.isLeft(), true);
    result.fold(
      (l) => expect(l.message, contains('must be positive')),
      (r) => fail('Should be left'),
    );
  });

  test('6. Failure: Cannot relieve stress anymore this month', () {
    // Arrange
    final stateWithMaxRelief = baseState.copyWith(leisureReliefUsedThisMonth: 20);

    // Act
    final result = usecase(stateWithMaxRelief, 1000000);

    // Assert
    expect(result.isLeft(), true);
    result.fold(
      (l) => expect(l.message, contains('reached the maximum')),
      (r) => fail('Should be left'),
    );
  });
}
