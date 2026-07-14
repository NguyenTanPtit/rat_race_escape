import 'package:injectable/injectable.dart';
import '../../domain/entities/game_event.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/repositories/event_pool_repository.dart';

@LazySingleton(as: EventPoolRepository)
class MockEventPoolRepository implements EventPoolRepository {
  @override
  Future<List<GameEvent>> loadEventPool(Country country, String scenarioId) async {
    // Return mock data for now
    return [];
  }
}
