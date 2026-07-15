import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Insight Cards Config Tests', () {
    test('insight_cards_vi.json cards have non-empty title/desc and desc >= 200 chars', () {
      final file = File('assets/config/i18n/insight_cards_vi.json');
      final content = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = json.decode(content);

      expect(jsonMap.isNotEmpty, isTrue);

      for (final entry in jsonMap.entries) {
        final card = entry.value;
        final title = card['title'] as String;
        final description = card['description'] as String;

        expect(title.isNotEmpty, isTrue, reason: 'Title should not be empty for card ${entry.key}');
        expect(description.isNotEmpty, isTrue, reason: 'Description should not be empty for card ${entry.key}');
        expect(description.length >= 200, isTrue, reason: 'Description must be >= 200 chars for card ${entry.key}. Current length: ${description.length}');
      }
    });

    test('vn_provincial.json insightCardIds exist in insight_cards_vi.json', () {
      final cardsFile = File('assets/config/i18n/insight_cards_vi.json');
      final cardsJson = json.decode(cardsFile.readAsStringSync()) as Map<String, dynamic>;

      final scenarioFile = File('assets/config/scenarios/vn_provincial.json');
      final scenarioJson = json.decode(scenarioFile.readAsStringSync()) as Map<String, dynamic>;

      final events = scenarioJson['events'] as List<dynamic>;

      for (final event in events) {
        final options = event['options'] as List<dynamic>;
        for (final option in options) {
          final effect = option['effect'] as Map<String, dynamic>?;
          if (effect != null && effect.containsKey('insightCardId')) {
            final id = effect['insightCardId'] as String;
            expect(cardsJson.containsKey(id), isTrue, reason: 'insightCardId "$id" used in event "${event['id']}" option "${option['id']}" is not defined in insight_cards_vi.json');
          }
        }
      }
    });
  });
}
