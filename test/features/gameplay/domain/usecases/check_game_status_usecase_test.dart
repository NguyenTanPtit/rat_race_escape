import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_game_status_usecase.dart';

void main() {
  late CheckGameStatusUseCase usecase;

  setUp(() {
    usecase = CheckGameStatusUseCase();
  });

  group('CheckGameStatusUseCase', () {
    final baseState = GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      cash: 1000,
      monthlyExpenses: 500,
      baseSalary: 1000,
    );

    test('should return TurnWon if passive income >= monthly expenses (prioritized over lost)', () {
      // Even if stress is 100, Won should be checked first
      final state = baseState.copyWith(
        stress: 100, // Conflict condition
      );
      // We need to mock passiveIncome getter. Since we haven't updated GameState to use assets for passiveIncome yet in the test setup, we will just use the baseState and assume GameState update will happen next.
      // Wait, passiveIncome is a getter based on assets. Let's add an asset.
      // Actually, right now GameState still has passiveIncome field because we haven't updated it yet.
      // Let's assume GameState has passiveIncome field for now, or update it later.
      final stateWithPassiveIncome = state.copyWith(
        assets: [
          const Asset(
            id: 'a1',
            name: 'Stock',
            baseValue: 1000,
            monthlyPassiveIncome: 600, // > 500
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

    test('should return TurnLost with bankruptcy if cash < -(3 * expenses)', () {
      final state = baseState.copyWith(
        cash: -1501, // 3 * 500 = 1500
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
