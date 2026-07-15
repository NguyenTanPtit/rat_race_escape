import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/update_metrics_usecase.dart';

class MockCalculateCashflowUseCase extends Mock implements CalculateCashflowUseCase {}
class MockProcessLoansUseCase extends Mock implements ProcessLoansUseCase {}
class MockUpdateMetricsUseCase extends Mock implements UpdateMetricsUseCase {}
class MockGenerateEventUseCase extends Mock implements GenerateEventUseCase {}
class MockCheckGameStatusUseCase extends Mock implements CheckGameStatusUseCase {}

class FakeGameState extends Fake implements GameState {}

void main() {
  late ProcessNextMonthUseCase usecase;
  late MockCalculateCashflowUseCase mockCalculateCashflowUseCase;
  late MockProcessLoansUseCase mockProcessLoansUseCase;
  late MockUpdateMetricsUseCase mockUpdateMetricsUseCase;
  late MockGenerateEventUseCase mockGenerateEventUseCase;
  late MockCheckGameStatusUseCase mockCheckGameStatusUseCase;

  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  setUp(() {
    mockCalculateCashflowUseCase = MockCalculateCashflowUseCase();
    mockProcessLoansUseCase = MockProcessLoansUseCase();
    mockUpdateMetricsUseCase = MockUpdateMetricsUseCase();
    mockGenerateEventUseCase = MockGenerateEventUseCase();
    mockCheckGameStatusUseCase = MockCheckGameStatusUseCase();

    usecase = ProcessNextMonthUseCase(
      mockCalculateCashflowUseCase,
      mockProcessLoansUseCase,
      mockUpdateMetricsUseCase,
      mockGenerateEventUseCase,
      mockCheckGameStatusUseCase,
    );
  });

  test('resets leisureReliefUsedThisMonth to 0', () async {
    // Arrange
    final initialState = const GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      scenarioId: 'test_scenario',
      monthlyExpenses: 0,
      monthlyRent: 0,
      baseSalary: 0,
      currentMonth: 1,
      ageInMonths: 240,
      cash: 1000,
      leisureReliefUsedThisMonth: 20, // Maxed out
    );
    final stateWithMonthAdvanced = initialState.copyWith(
      currentMonth: 2,
      ageInMonths: 241,
      currentEventId: null,
      leisureReliefUsedThisMonth: 0, // Reset!
    );
    final stateAfterPipeline = stateWithMonthAdvanced.copyWith(cash: 2000);

    when(() => mockCalculateCashflowUseCase(stateWithMonthAdvanced)).thenReturn(stateWithMonthAdvanced);
    when(() => mockProcessLoansUseCase(stateWithMonthAdvanced)).thenReturn(stateWithMonthAdvanced);
    when(() => mockUpdateMetricsUseCase(stateWithMonthAdvanced)).thenReturn(stateWithMonthAdvanced);
    when(() => mockGenerateEventUseCase(stateWithMonthAdvanced)).thenAnswer((_) async => stateAfterPipeline);
    when(() => mockCheckGameStatusUseCase(stateAfterPipeline)).thenReturn(TurnResult.continued(stateAfterPipeline));

    // Act
    final result = await usecase(initialState);

    // Assert
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('Should be right'),
      (r) {
        expect(r, isA<TurnContinued>());
        expect((r as TurnContinued).state.leisureReliefUsedThisMonth, 0);
      },
    );
  });
}
