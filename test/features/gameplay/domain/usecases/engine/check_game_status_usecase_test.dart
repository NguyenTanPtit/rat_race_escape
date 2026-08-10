import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
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

    group('debt crush (3c)', () {
      // baseState economics: salary 1000, outflow 800 -> structural surplus
      // 200/month. This loan's due (300 + interest) exceeds that surplus:
      // the debt can only grow.
      const crushingLoan = Loan(
        id: 'big',
        name: 'Vay thế chấp',
        principalAmount: 15000,
        interestRatePerYear: 10.0,
        minimumMonthlyPayment: 300,
        type: LoanType.mortgage,
      );

      test('a month underwater + due above the structural surplus = bankruptcy', () {
        // cash -801 < -outflow (-800); due 300 > surplus 200.
        final state = baseState.copyWith(cash: -801, loans: [crushingLoan]);
        final result = usecase(state);
        expect(result, isA<TurnLost>());
        expect((result as TurnLost).reason, GameOverReason.bankruptcy);
      });

      test('shallow dips are never crushed, whatever the debt', () {
        final state = baseState.copyWith(cash: -100, loans: [crushingLoan]);
        expect(usecase(state), isA<TurnContinued>());
      });

      test('a SERVICEABLE loan (due within the surplus) is not fatal', () {
        const smallLoan = Loan(
          id: 'small',
          name: 'Vay nhỏ',
          principalAmount: 5000,
          interestRatePerYear: 10.0,
          minimumMonthlyPayment: 100, // < surplus 200
        );
        final state = baseState.copyWith(cash: -801, loans: [smallLoan]);
        expect(usecase(state), isA<TurnContinued>());
      });

      test('deep underwater with NO loans is not a debt crush', () {
        // Poverty without debt stays on the burnout/bankruptcy-threshold
        // paths; the crush must require actual debt.
        final state = baseState.copyWith(cash: -900);
        expect(usecase(state), isA<TurnContinued>());
      });

      test('judged on BASE salary: job-loss suspension alone does not flip a '
          'serviceable loan into a crush', () {
        const smallLoan = Loan(
          id: 'small',
          name: 'Vay nhỏ',
          principalAmount: 5000,
          interestRatePerYear: 10.0,
          minimumMonthlyPayment: 100,
        );
        final state = baseState.copyWith(
            cash: -801, salarySuspendedMonths: 2, loans: [smallLoan]);
        expect(state.effectiveSalary, 0, reason: 'suspension zeroes the paycheck');
        expect(usecase(state), isA<TurnContinued>());
      });

      test('a nearly-paid-off loan charges its balance, not the fixed minimum', () {
        // Principal 50 + interest ≈ 50.4 due < surplus 200 — the fixed
        // minimum 300 must NOT be what the crush check reads.
        final almostDone = crushingLoan.copyWith(principalAmount: 50);
        final state = baseState.copyWith(cash: -801, loans: [almostDone]);
        expect(state.totalDueLoanPayment, lessThan(60));
        expect(usecase(state), isA<TurnContinued>());
      });
    });
  });
}
