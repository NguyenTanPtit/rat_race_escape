import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/game_event.dart';
import '../../domain/entities/event_effect.dart';
import '../../domain/entities/event_definition.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/repositories/event_pool_repository.dart';

@LazySingleton(as: EventPoolRepository)
class JsonEventPoolRepository implements EventPoolRepository {
  final Map<String, List<EventDefinition>> _cache = {};

  @override
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId, {String locale = 'vi'}) async {
    final cacheKey = '${scenarioId}_$locale';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    // 1. Load the scenario JSON
    final String scenarioJsonStr = await rootBundle.loadString('assets/config/scenarios/$scenarioId.json');
    final Map<String, dynamic> scenarioJson = json.decode(scenarioJsonStr);

    // 2. Load the i18n JSON
    final String i18nJsonStr = await rootBundle.loadString('assets/config/i18n/events_$locale.json');
    final Map<String, dynamic> i18nJson = json.decode(i18nJsonStr);

    // 3. Parse events list
    final List<dynamic> eventsList = scenarioJson['events'] as List<dynamic>? ?? [];
    
    final pool = eventsList.map((eventJson) {
      final String id = eventJson['id'] as String;
      final String textKey = eventJson['textKey'] as String;
      
      // Resolve i18n
      final i18nData = i18nJson[textKey] as Map<String, dynamic>?;
      if (i18nData == null) {
        throw Exception('Missing i18n text for key: $textKey');
      }
      final String title = i18nData['title'] as String;
      final String description = i18nData['description'] as String;
      final optionsI18n = i18nData['options'] as Map<String, dynamic>? ?? {};

      // Parse options
      final List<dynamic> optionsJson = eventJson['options'] as List<dynamic>? ?? [];
      final options = optionsJson.map((optJson) {
        final labelKey = optJson['labelKey'] as String;
        final label = optionsI18n[labelKey] as String?;
        if (label == null) {
          throw Exception('Missing i18n text for labelKey: $labelKey');
        }
        
        return EventOption(
          id: optJson['id'] as String,
          label: label,
          effect: optJson['effect'] != null 
              ? EventEffect.fromJson(optJson['effect'] as Map<String, dynamic>) 
              : const EventEffect(),
        );
      }).toList();

      final gameEvent = GameEvent(
        id: id,
        title: title,
        description: description,
        options: options,
      );

      return EventDefinition(
        event: gameEvent,
        trigger: eventJson['trigger'] != null 
            ? EventTrigger.fromJson(eventJson['trigger'] as Map<String, dynamic>) 
            : const EventTrigger(),
        absoluteChance: eventJson['absoluteChance']?.toDouble(),
        weight: eventJson['weight']?.toDouble() ?? 1.0,
      );
    }).toList();

    _cache[cacheKey] = pool;
    return pool;
  }
}
