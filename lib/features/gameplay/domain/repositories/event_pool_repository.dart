import '../entities/game_event.dart';
import '../entities/game_state.dart';

abstract class EventPoolRepository {
  Future<List<GameEvent>> loadEventPool(Country country, String scenarioId);
}
