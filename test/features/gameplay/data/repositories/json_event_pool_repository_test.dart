import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonEventPoolRepository Validation', () {
    test('Referential Integrity: Scenario textKeys must exist in i18n JSON', () {
      final scenarioFile = File('assets/config/scenarios/vn_provincial.json');
      final i18nFile = File('assets/config/i18n/events_vi.json');

      expect(scenarioFile.existsSync(), isTrue, reason: 'Scenario file missing');
      expect(i18nFile.existsSync(), isTrue, reason: 'i18n file missing');

      final scenarioData = jsonDecode(scenarioFile.readAsStringSync());
      final i18nData = jsonDecode(i18nFile.readAsStringSync());

      final eventsList = scenarioData['events'] as List<dynamic>;
      
      for (final event in eventsList) {
        final textKey = event['textKey'] as String;
        expect(i18nData.containsKey(textKey), isTrue, 
          reason: 'textKey "$textKey" is missing in events_vi.json');

        final optionsData = i18nData[textKey]['options'] as Map<String, dynamic>? ?? {};
        final optionsList = event['options'] as List<dynamic>? ?? [];
        for (final opt in optionsList) {
          final labelKey = opt['labelKey'] as String;
          expect(optionsData.containsKey(labelKey), isTrue,
            reason: 'labelKey "$labelKey" is missing in options for textKey "$textKey"');
        }
      }
    });

    test('Scenario vn_provincial must have at least 15 events', () {
      final scenarioFile = File('assets/config/scenarios/vn_provincial.json');
      final scenarioData = jsonDecode(scenarioFile.readAsStringSync());
      final eventsList = scenarioData['events'] as List<dynamic>;

      expect(eventsList.length, greaterThanOrEqualTo(15));
    });
  });
}
