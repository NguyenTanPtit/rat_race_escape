import '../entities/game_state.dart';
import '../entities/event_definition.dart';

abstract class EventPoolRepository {
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId, {String locale = 'vi'});
}
