import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';

class MockEventPoolRepository extends Mock implements EventPoolRepository {}

void main() {
  late GenerateEventUseCase usecase;
  late MockEventPoolRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(Country.vietnam);
  });

  setUp(() {
    mockRepo = MockEventPoolRepository();
    // Use a fixed seed for predictable random behavior in weight distribution tests
    usecase = GenerateEventUseCase(mockRepo, Random(42));
  });

  group('GenerateEventUseCase', () {
    final baseState = GameState(
      scenarioId: 'test_scenario',
      country: Country.vietnam,
      currency: Currency.vnd,
      cash: 5000,
      monthlyExpenses: 1000,
      monthlyRent: 500,
      baseSalary: 3000,
      baseEventChance: 1.0, // Force events to happen if eligible
      startCalendarMonth: 1,
      currentMonth: 1,
      flags: {'has_car'},
    );

    test('(a) Trigger filter - skips event if targetCalendarMonths does not match', () async {
      when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
        const EventDefinition(
          event: GameEvent(id: 'tet_event', title: 'Tet', description: ''),
          trigger: EventTrigger(targetCalendarMonths: [1, 2]),
        ),
      ]);

      // Month 1 should trigger
      final stateMonth1 = await usecase(baseState.copyWith(currentMonth: 1));
      expect(stateMonth1.currentEventId, 'tet_event');

      // Month 6 should NOT trigger
      final stateMonth6 = await usecase(baseState.copyWith(currentMonth: 6));
      expect(stateMonth6.currentEventId, isNull);
    });

    test('(a) Trigger filter - skips event if requiredFlags is missing', () async {
      when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
        const EventDefinition(
          event: GameEvent(id: 'car_broken', title: 'Car Broken', description: ''),
          trigger: EventTrigger(requiredFlags: {'has_car'}),
        ),
      ]);

      // State with flag should trigger
      final stateWithFlag = await usecase(baseState.copyWith(flags: {'has_car'}));
      expect(stateWithFlag.currentEventId, 'car_broken');

      // State without flag should NOT trigger
      final stateWithoutFlag = await usecase(baseState.copyWith(flags: {}));
      expect(stateWithoutFlag.currentEventId, isNull);
    });

    test('(b) Absolute chance is rolled first and wins if successful', () async {
      when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
        const EventDefinition(
          event: GameEvent(id: 'absolute_event', title: 'Absolute', description: ''),
          trigger: EventTrigger(),
          absoluteChance: 1.0, // 100% chance
        ),
        const EventDefinition(
          event: GameEvent(id: 'weighted_event', title: 'Weighted', description: ''),
          trigger: EventTrigger(),
          weight: 1000.0, // Huge weight, but should be ignored because absolute triggers first
        ),
      ]);

      final state = await usecase(baseState);
      expect(state.currentEventId, 'absolute_event');
    });

    test('(c) Weight distribution with fixed Random seed', () async {
      when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
        const EventDefinition(
          event: GameEvent(id: 'event_A', title: 'A', description: ''),
          trigger: EventTrigger(),
          weight: 70.0, // 70% chance relative to B
        ),
        const EventDefinition(
          event: GameEvent(id: 'event_B', title: 'B', description: ''),
          trigger: EventTrigger(),
          weight: 30.0, // 30% chance relative to A
        ),
      ]);

      int countA = 0;
      int countB = 0;
      int iterations = 1000;

      for (int i = 0; i < iterations; i++) {
        final state = await usecase(baseState);
        if (state.currentEventId == 'event_A') countA++;
        if (state.currentEventId == 'event_B') countB++;
      }

      // Expected approx 700 for A and 300 for B.
      // We check if it falls within an acceptable margin of error (e.g., +/- 50)
      expect(countA, greaterThan(650));
      expect(countA, lessThan(750));
      expect(countB, greaterThan(250));
      expect(countB, lessThan(350));
    });

    group('(5a) cooldownMonths', () {
      test('firing an event stamps eventLastFired with the current month', () async {
        when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
          const EventDefinition(
            event: GameEvent(id: 'plain_event', title: 'Plain', description: ''),
            trigger: EventTrigger(),
          ),
        ]);

        final state = await usecase(baseState.copyWith(currentMonth: 7));

        expect(state.currentEventId, 'plain_event');
        expect(state.eventLastFired['plain_event'], 7);
      });

      test('event in cooldown cannot fire; fires again once cooldown has passed', () async {
        when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
          const EventDefinition(
            event: GameEvent(id: 'cooled_event', title: 'Cooled', description: ''),
            trigger: EventTrigger(),
            cooldownMonths: 12,
          ),
        ]);

        // Fired at month 10 → blocked through month 21, eligible again at month 22.
        final fired = await usecase(baseState.copyWith(currentMonth: 10));
        expect(fired.currentEventId, 'cooled_event');
        expect(fired.eventLastFired['cooled_event'], 10);

        final duringCooldown = await usecase(
          baseState.copyWith(currentMonth: 21, eventLastFired: {'cooled_event': 10}),
        );
        expect(duringCooldown.currentEventId, isNull);

        final afterCooldown = await usecase(
          baseState.copyWith(currentMonth: 22, eventLastFired: {'cooled_event': 10}),
        );
        expect(afterCooldown.currentEventId, 'cooled_event');
        expect(afterCooldown.eventLastFired['cooled_event'], 22);
      });

      test('absoluteChance event also respects cooldown', () async {
        when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
          const EventDefinition(
            event: GameEvent(id: 'pandemic', title: 'Pandemic', description: ''),
            trigger: EventTrigger(),
            absoluteChance: 1.0,
            cooldownMonths: 24,
          ),
        ]);

        final duringCooldown = await usecase(
          baseState.copyWith(currentMonth: 30, eventLastFired: {'pandemic': 20}),
        );
        expect(duringCooldown.currentEventId, isNull);

        final afterCooldown = await usecase(
          baseState.copyWith(currentMonth: 44, eventLastFired: {'pandemic': 20}),
        );
        expect(afterCooldown.currentEventId, 'pandemic');
      });

      test('cooldown of one event does not block other events', () async {
        when(() => mockRepo.loadEventPool(any(), any(), locale: any(named: 'locale'))).thenAnswer((_) async => [
          const EventDefinition(
            event: GameEvent(id: 'cooled_event', title: 'Cooled', description: ''),
            trigger: EventTrigger(),
            cooldownMonths: 12,
          ),
          const EventDefinition(
            event: GameEvent(id: 'other_event', title: 'Other', description: ''),
            trigger: EventTrigger(),
          ),
        ]);

        final state = await usecase(
          baseState.copyWith(currentMonth: 5, eventLastFired: {'cooled_event': 1}),
        );

        expect(state.currentEventId, 'other_event');
        expect(state.eventLastFired, {'cooled_event': 1, 'other_event': 5});
      });
    });
  });
}
