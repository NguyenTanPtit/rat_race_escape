import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/work_side_job_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

void main() {
  late CheckGameStatusUseCase checkGameStatusUseCase;
  late WorkSideJobUseCase usecase;

  setUp(() {
    checkGameStatusUseCase = CheckGameStatusUseCase();
    usecase = WorkSideJobUseCase(checkGameStatusUseCase);
  });

  final initialState = const GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'default',
    monthlyExpenses: 1000,
    monthlyRent: 200,
    baseSalary: 3000,
    cash: 10000,
    stress: 50,
    sideJobsWorkedThisMonth: 0,
    maxSideJobsPerMonth: 2,
    sideJobIncome: 2500000,
    sideJobStress: 8,
  );

  test('successfully works a side job, adds cash and stress', () {
    final result = usecase(initialState);

    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    expect(turnResult, isA<TurnContinued>());
    final finalState = (turnResult as TurnContinued).state;

    expect(finalState.cash, 10000 + 2500000);
    expect(finalState.stress, 58);
    expect(finalState.sideJobsWorkedThisMonth, 1);
  });

  test('fails if already reached max side jobs this month', () {
    final maxedState = initialState.copyWith(sideJobsWorkedThisMonth: 2);
    final result = usecase(maxedState);

    expect(result.isLeft(), true);
    final failure = result.fold((l) => l, (r) => null);
    expect(failure?.message, 'You have reached the maximum number of side jobs for this month');
  });

  test('stress is clamped to 100 and returns TurnLost (burnout)', () {
    final highStressState = initialState.copyWith(stress: 95);
    final result = usecase(highStressState);

    expect(result.isRight(), true);
    final turnResult = result.fold((l) => null, (r) => r);
    
    // Should be TurnLost due to burnout
    expect(turnResult, isA<TurnLost>());
    final turnLost = turnResult as TurnLost;
    expect(turnLost.reason, GameOverReason.burnout);
    
    final finalState = turnLost.state;
    expect(finalState.stress, 100); // Clamped
  });
}
