import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/scenario_config.dart';
import '../../domain/repositories/scenario_config_repository.dart';

@LazySingleton(as: ScenarioConfigRepository)
class JsonScenarioConfigRepository implements ScenarioConfigRepository {
  @override
  Future<ScenarioConfig> loadScenarioConfig(Country country, String scenarioId) async {
    try {
      final String jsonStr = await rootBundle.loadString('assets/config/scenarios/$scenarioId.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      return ScenarioConfig.fromJson(jsonMap);
    } catch (e) {
      throw ArgumentError('Failed to load scenario config for $scenarioId: $e');
    }
  }
}
