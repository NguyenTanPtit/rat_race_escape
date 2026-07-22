import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';

class MockCalculateCashflowUseCase extends Mock implements CalculateCashflowUseCase {}
class MockProcessLoansUseCase extends Mock implements ProcessLoansUseCase {}
class MockUpdateMarketUseCase extends Mock implements UpdateMarketUseCase {}
class MockUpdateMetricsUseCase extends Mock implements UpdateMetricsUseCase {}
class MockGenerateEventUseCase extends Mock implements GenerateEventUseCase {}
class MockCheckGameStatusUseCase extends Mock implements CheckGameStatusUseCase {}

class FakeGameState extends Fake implements GameState {}

class MockCheckBehavioralInsightsUseCase extends Mock implements CheckBehavioralInsightsUseCase {}

void main() {
  late ProcessNextMonthUseCase usecase;
  late MockCalculateCashflowUseCase mockCalculateCashflowUseCase;
  late MockProcessLoansUseCase mockProcessLoansUseCase;
  late MockUpdateMarketUseCase mockUpdateMarketUseCase;
  late MockUpdateMetricsUseCase mockUpdateMetricsUseCase;
  late MockGenerateEventUseCase mockGenerateEventUseCase;
  late MockCheckGameStatusUseCase mockCheckGameStatusUseCase;
  late MockCheckBehavioralInsightsUseCase mockCheckBehavioralInsightsUseCase;

  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  setUp(() {
    mockCalculateCashflowUseCase = MockCalculateCashflowUseCase();
    mockProcessLoansUseCase = MockProcessLoansUseCase();
    mockUpdateMarketUseCase = MockUpdateMarketUseCase();
    mockUpdateMetricsUseCase = MockUpdateMetricsUseCase();
    mockGenerateEventUseCase = MockGenerateEventUseCase();
    mockCheckGameStatusUseCase = MockCheckGameStatusUseCase();
    mockCheckBehavioralInsightsUseCase = MockCheckBehavioralInsightsUseCase();

    usecase = ProcessNextMonthUseCase(
      mockCalculateCashflowUseCase,
      mockProcessLoansUseCase,
      mockUpdateMarketUseCase,
      mockUpdateMetricsUseCase,
      mockGenerateEventUseCase,
      mockCheckGameStatusUseCase,
      mockCheckBehavioralInsightsUseCase,
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
      cash: 0,
      leisureReliefUsedThisMonth: 15, // Some used value
      sideJobsWorkedThisMonth: 2, // Some used value
    );

    // Setup mocks to just return the state they receive
    when(() => mockCalculateCashflowUseCase(any())).thenAnswer((inv) => inv.positionalArguments[0] as GameState);
    when(() => mockProcessLoansUseCase(any())).thenAnswer((inv) => inv.positionalArguments[0] as GameState);
    when(() => mockUpdateMarketUseCase(any())).thenAnswer((inv) => inv.positionalArguments[0] as GameState);
    when(() => mockUpdateMetricsUseCase(any())).thenAnswer((inv) => inv.positionalArguments[0] as GameState);
    when(() => mockGenerateEventUseCase(any())).thenAnswer((inv) async => inv.positionalArguments[0] as GameState);
    when(() => mockCheckBehavioralInsightsUseCase(any())).thenAnswer((inv) => inv.positionalArguments[0] as GameState);
    // Finally, mockCheckGameStatusUseCase returns TurnContinued so we can inspect the state
    when(() => mockCheckGameStatusUseCase(any())).thenAnswer((inv) => TurnResult.continued(inv.positionalArguments[0] as GameState));

    // Act
    final result = await usecase(initialState);

    // Assert
    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    expect(turnResult, isA<TurnContinued>());
    final finalState = (turnResult as TurnContinued).state;
    expect(finalState.leisureReliefUsedThisMonth, 0);
    expect(finalState.sideJobsWorkedThisMonth, 0);
  });
}
