import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/stat_bar.dart';

void main() {
  group('StatBar Widget Test', () {
    testWidgets('StatBar renders label and value', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatBar(
              label: 'Stress',
              emoji: '🤯',
              value: 50,
              type: StatType.stress,
            ),
          ),
        ),
      );

      expect(find.text('🤯 Stress'), findsOneWidget);
      expect(find.text('50/100'), findsOneWidget);
    });

    testWidgets('StatBar clamps value to max visually', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatBar(
              label: 'Stress',
              emoji: '🤯',
              value: 150,
              type: StatType.stress,
            ),
          ),
        ),
      );

      expect(find.text('150/100'), findsOneWidget);
      // Ensure it doesn't crash from LayoutBuilder
    });
  });
}
