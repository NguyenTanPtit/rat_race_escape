import 'package:flutter_test/flutter_test.dart';

import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_effect.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
void main() {
  late ApplyEventOptionUseCase applyEventOptionUseCase;
  late MockEventPoolRepository mockEventPoolRepository;
  late CheckGameStatusUseCase checkGameStatusUseCase;

  setUp(() {
    mockEventPoolRepository = MockEventPoolRepository();
    checkGameStatusUseCase = CheckGameStatusUseCase();
    applyEventOptionUseCase = ApplyEventOptionUseCase(
      mockEventPoolRepository,
      checkGameStatusUseCase,
    );
  });

  const baseState = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test_scenario',
    cash: 10000000,
    monthlyExpenses: 5000000,
    monthlyRent: 3000000,
    baseSalary: 15000000,
    currentEventId: 'e_tet',
    networkScore: 10,
    stress: 20,
    creditScore: 600,
  );

  test('should return failure if currentEventId does not match eventId', () async {
    final result = await applyEventOptionUseCase.call(baseState, 'different_event', 'opt1');
    expect(result.isLeft(), true);
    result.mapLeft((f) => expect(f.message, 'Invalid active event'));
  });

  test('should return failure if event not found in pool', () async {
    mockEventPoolRepository.eventsToReturn = [];
    final result = await applyEventOptionUseCase.call(baseState, 'e_tet', 'opt1');
    expect(result.isLeft(), true);
    result.mapLeft((f) => expect(f.message, 'Event not found'));
  });

  test('should return failure if option not found in event', () async {
    mockEventPoolRepository.eventsToReturn = [
      const EventDefinition(
        event: GameEvent(id: 'e_tet', title: 'Tet', description: '', options: []),
        trigger: EventTrigger(),
      )
    ];
    final result = await applyEventOptionUseCase.call(baseState, 'e_tet', 'opt1');
    expect(result.isLeft(), true);
    result.mapLeft((f) => expect(f.message, 'Option not found'));
  });

  test('should apply proportional and absolute effects correctly in specific order', () async {
    // Proportional calculation test:
    // Salary 15M + multiplier 1.0 + salaryDelta 2M + cash -12M -> cash +3M, salary = 17M.
    mockEventPoolRepository.eventsToReturn = [
      const EventDefinition(
        event: GameEvent(
          id: 'e_tet',
          title: 'Tet',
          description: '',
          options: [
            EventOption(
              id: 'opt1',
              label: '',
              effect: EventEffect(
                cashBySalaryMultiplier: 1.0,
                cash: -12000000,
                salaryDelta: 2000000,
              ),
            ),
          ],
        ),
        trigger: EventTrigger(),
      )
    ];

    final result = await applyEventOptionUseCase.call(baseState, 'e_tet', 'opt1');
    expect(result.isRight(), true);
    result.map((turnResult) {
      final updatedState = turnResult.state;
      // Previous cash: 10M.
      // Proportional cash = 1.0 * 15M = 15M
      // Absolute cash addition = 15M - 12M = +3M
      // New cash = 10M + 3M = 13M
      expect(updatedState.cash, 13000000);
      
      // Salary should be base + 2M = 17M
      expect(updatedState.baseSalary, 17000000);
      
      // Event ID should be cleared
      expect(updatedState.currentEventId, isNull);
    });
  });

  test('should clamp values correctly (stress, creditScore, networkScore)', () async {
    mockEventPoolRepository.eventsToReturn = [
      const EventDefinition(
        event: GameEvent(
          id: 'e_tet',
          title: 'Tet',
          description: '',
          options: [
            EventOption(
              id: 'opt1',
              label: '',
              effect: EventEffect(
                stress: 200, // Should clamp to 100
                credit: -500, // 600 - 500 = 100, should clamp to 300
                network: -50, // 10 - 50 = -40, should clamp to 0
              ),
            ),
          ],
        ),
        trigger: EventTrigger(),
      )
    ];

    final result = await applyEventOptionUseCase.call(baseState, 'e_tet', 'opt1');
    result.map((turnResult) {
      final updatedState = turnResult.state;
      expect(updatedState.stress, 100);
      expect(updatedState.creditScore, 300);
      expect(updatedState.networkScore, 0);
    });
  });

  test('should properly map flags, loans, assets, insight cards', () async {
    const loan = Loan(id: 'l1', name: 'Loan', principalAmount: 1000, interestRatePerYear: 5, minimumMonthlyPayment: 100, type: LoanType.personalLoan);
    const asset = Asset(id: 'a1', name: 'Asset', baseValue: 1000, type: AssetType.business);

    mockEventPoolRepository.eventsToReturn = [
      const EventDefinition(
        event: GameEvent(
          id: 'e_tet',
          title: 'Tet',
          description: '',
          options: [
            EventOption(
              id: 'opt1',
              label: '',
              effect: EventEffect(
                addedLoans: [loan],
                addedAssets: [asset],
                addedFlags: ['new_flag'],
                removedFlags: ['old_flag'],
                insightCardId: 'card_1',
              ),
            ),
          ],
        ),
        trigger: EventTrigger(),
      )
    ];

    final stateWithFlag = baseState.copyWith(flags: {'old_flag', 'other_flag'});
    final result = await applyEventOptionUseCase.call(stateWithFlag, 'e_tet', 'opt1');

    result.map((turnResult) {
      final updatedState = turnResult.state;
      expect(updatedState.loans, contains(loan));
      expect(updatedState.assets, contains(asset));
      expect(updatedState.flags, containsAll(['new_flag', 'other_flag']));
      expect(updatedState.flags, isNot(contains('old_flag')));
      expect(updatedState.unlockedInsightCardIds, contains('card_1'));
    });
  });

  test('should trigger checkGameStatus correctly (e.g. stress reached 100 -> burnout)', () async {
    mockEventPoolRepository.eventsToReturn = [
      const EventDefinition(
        event: GameEvent(
          id: 'e_tet',
          title: 'Tet',
          description: '',
          options: [
            EventOption(
              id: 'opt1',
              label: '',
              effect: EventEffect(stress: 100),
            ),
          ],
        ),
        trigger: EventTrigger(),
      )
    ];

    final result = await applyEventOptionUseCase.call(baseState, 'e_tet', 'opt1');
    result.map((turnResult) {
      expect(turnResult, isA<TurnLost>());
      if (turnResult is TurnLost) {
        expect(turnResult.reason, GameOverReason.burnout);
      }
    });
  });
}

class MockEventPoolRepository implements EventPoolRepository {
  List<EventDefinition> eventsToReturn = [];

  @override
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId, {String locale = 'vi'}) async {
    return eventsToReturn;
  }
}
