import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

void main() {
  late CheckGameStatusUseCase usecase;

  setUp(() {
    usecase = CheckGameStatusUseCase();
  });

  group('CheckGameStatusUseCase', () {
    final baseState = GameState(
      scenarioId: 'test_scenario',
      country: Country.vietnam,
      currency: Currency.vnd,
      cash: 1000,
      monthlyExpenses: 500,
      monthlyRent: 200,
      familySupportExpense: 100,
      baseSalary: 1000,
    );

    test('should return TurnWon if passive income >= monthly expenses (prioritized over lost)', () {
      // Even if stress is 100, Won should be checked first
      final state = baseState.copyWith(
        stress: 100, // Conflict condition
      );
      final stateWithPassiveIncome = state.copyWith(
        assets: [
          const Asset(
            id: 'a1',
            name: 'Stock',
            baseValue: 1000,
            monthlyPassiveIncome: 900, // > 800 (outflow)
          )
        ],
      );

      final result = usecase(stateWithPassiveIncome);

      expect(result, isA<TurnWon>());
    });

    test('should return TurnLost with burnout if stress >= 100', () {
      final state = baseState.copyWith(stress: 100);
      final result = usecase(state);

      expect(result, isA<TurnLost>());
      if (result is TurnLost) {
        expect(result.reason, GameOverReason.burnout);
      }
    });

    test('should return TurnLost with debtSpiral if creditScore <= 300 and cash < 0', () {
      final state = baseState.copyWith(
        creditScore: 300,
        cash: -100,
      );
      final result = usecase(state);

      expect(result, isA<TurnLost>());
      if (result is TurnLost) {
        expect(result.reason, GameOverReason.debtSpiral);
      }
    });

    test('should return TurnLost with bankruptcy if cash < -(3 * outflow)', () {
      final state = baseState.copyWith(
        cash: -2401, // 3 * 800 = 2400
      );
      final result = usecase(state);

      expect(result, isA<TurnLost>());
      if (result is TurnLost) {
        expect(result.reason, GameOverReason.bankruptcy);
      }
    });

    test('should return TurnLost with poorAtRetirement if age >= 65 (780 months)', () {
      final state = baseState.copyWith(
        ageInMonths: 780,
      );
      final result = usecase(state);

      expect(result, isA<TurnLost>());
      if (result is TurnLost) {
        expect(result.reason, GameOverReason.poorAtRetirement);
      }
    });

    test('should return TurnContinued otherwise', () {
      final result = usecase(baseState);
      expect(result, isA<TurnContinued>());
    });
  });
}
