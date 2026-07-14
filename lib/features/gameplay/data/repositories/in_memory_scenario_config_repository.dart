import 'package:injectable/injectable.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/scenario_config.dart';
import '../../domain/repositories/scenario_config_repository.dart';

// TODO(task-2): Delete this file and replace with JSON implementation.
@LazySingleton(as: ScenarioConfigRepository)
class InMemoryScenarioConfigRepository implements ScenarioConfigRepository {
  @override
  Future<ScenarioConfig> loadScenarioConfig(Country country, String scenarioId) async {
    throw ArgumentError('Scenario $scenarioId not found in memory stub.');
  }
}
