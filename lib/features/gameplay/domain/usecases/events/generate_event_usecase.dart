import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';

@lazySingleton
class GenerateEventUseCase {
  final EventPoolRepository _eventPoolRepository;
  final Random _random;

  GenerateEventUseCase(this._eventPoolRepository, this._random);

  Future<GameState> call(GameState currentState) async {
    final events = await _eventPoolRepository.loadEventPool(
      currentState.country, 
      currentState.scenarioId,
    );

    // 1. Filter events whose triggers are satisfied by the current state.
    final eligibleEvents = events.where((e) => _isTriggerSatisfied(e.trigger, currentState)).toList();

    // 2. Evaluate absoluteChance events FIRST in order.
    for (final event in eligibleEvents) {
      if (event.absoluteChance != null) {
        final chance = event.absoluteChance!;
        if (_random.nextDouble() <= chance) {
          return currentState.copyWith(currentEventId: event.event.id);
        }
      }
    }

    // 3. If no absolute event triggered, roll the baseEventChance to see if ANY random event triggers.
    final double chance = _random.nextDouble();
    if (chance <= currentState.baseEventChance) {
      // Collect events that use relative weight (those without absoluteChance)
      final pool = eligibleEvents.where((e) => e.absoluteChance == null).toList();
      if (pool.isEmpty) return currentState;

      // Select an event based on weights
      final double totalWeight = pool.fold(0.0, (sum, e) => sum + e.weight);
      if (totalWeight <= 0) return currentState;

      double roll = _random.nextDouble() * totalWeight;
      for (final event in pool) {
        roll -= event.weight;
        if (roll <= 0) {
          return currentState.copyWith(currentEventId: event.event.id);
        }
      }
      
      // Fallback in case of floating point precision issues
      return currentState.copyWith(currentEventId: pool.last.event.id);
    }

    // No event triggered
    return currentState.copyWith(currentEventId: null);
  }

  bool _isTriggerSatisfied(EventTrigger trigger, GameState state) {
    if (trigger.minAgeInMonths != null && state.ageInMonths < trigger.minAgeInMonths!) return false;
    if (trigger.maxAgeInMonths != null && state.ageInMonths > trigger.maxAgeInMonths!) return false;
    if (trigger.minStress != null && state.stress < trigger.minStress!) return false;
    if (trigger.maxStress != null && state.stress > trigger.maxStress!) return false;
    if (trigger.targetCalendarMonths.isNotEmpty && !trigger.targetCalendarMonths.contains(state.calendarMonth)) return false;
    
    for (final reqFlag in trigger.requiredFlags) {
      if (!state.flags.contains(reqFlag)) return false;
    }
    for (final excFlag in trigger.excludedFlags) {
      if (state.flags.contains(excFlag)) return false;
    }
    
    return true;
  }
}
