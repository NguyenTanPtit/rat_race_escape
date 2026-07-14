import '../entities/game_state.dart';
import '../entities/scenario_config.dart';

abstract class ScenarioConfigRepository {
  Future<ScenarioConfig> loadScenarioConfig(Country country, String scenarioId);
}
