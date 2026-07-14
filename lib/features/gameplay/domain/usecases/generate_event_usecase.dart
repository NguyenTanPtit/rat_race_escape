import 'dart:math';
import 'package:injectable/injectable.dart';
import '../entities/game_state.dart';

@injectable
class GenerateEventUseCase {
  final Random _random;

  GenerateEventUseCase() : _random = Random();

  /// A simple RNG function. 20% base chance to trigger a random event. 
  /// If triggered, set currentEventId to a dummy string (e.g., "random_event_01").
  GameState call(GameState currentState) {
    final double chance = _random.nextDouble();
    String? newEventId = currentState.currentEventId;

    // 20% base chance to trigger a random event
    if (chance <= 0.20) {
      newEventId = "random_event_01";
    }

    return currentState.copyWith(currentEventId: newEventId);
  }
}
