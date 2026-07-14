import 'package:injectable/injectable.dart';
import '../../domain/entities/game_event.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/repositories/event_pool_repository.dart';

// TODO(task-2): Delete this file and replace with JSON implementation.
@LazySingleton(as: EventPoolRepository)
class InMemoryEventPoolRepository implements EventPoolRepository {
  @override
  Future<List<GameEvent>> loadEventPool(Country country, String scenarioId) async {
    return [];
  }
}
