import 'package:injectable/injectable.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/scenario_config.dart';
import '../../domain/repositories/scenario_config_repository.dart';

@LazySingleton(as: ScenarioConfigRepository)
class MockScenarioConfigRepository implements ScenarioConfigRepository {
  @override
  Future<ScenarioConfig> loadScenarioConfig(Country country, String scenarioId) async {
    // Return mock data for now
    return const ScenarioConfig(
      initialCash: 10000000,
      baseSalary: 15000000,
      monthlyRent: 3000000,
      familySupportExpense: 2000000,
    );
  }
}
