import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/stat_bar.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';

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
    testWidgets('StatBar colors correctly for stress thresholds', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatBar(label: 'Stress', emoji: '🤯', value: 30, type: StatType.stress))),
      );
      final finder = find.byType(Container).last;
      final container = tester.widget<Container>(finder);
      final boxDecoration = container.decoration as BoxDecoration;
      expect(boxDecoration.color, AppColors.stressLow);
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatBar(label: 'Stress', emoji: '🤯', value: 50, type: StatType.stress))),
      );
      final finder2 = find.byType(Container).last;
      final container2 = tester.widget<Container>(finder2);
      final boxDecoration2 = container2.decoration as BoxDecoration;
      expect(boxDecoration2.color, AppColors.stressMedium);
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatBar(label: 'Stress', emoji: '🤯', value: 80, type: StatType.stress))),
      );
      final finder3 = find.byType(Container).last;
      final container3 = tester.widget<Container>(finder3);
      final boxDecoration3 = container3.decoration as BoxDecoration;
      expect(boxDecoration3.color, AppColors.stressHigh);
    });

    testWidgets('StatBar colors correctly for credit thresholds', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatBar(label: 'Credit', emoji: '💳', value: 300, type: StatType.credit, maxValue: 850,))),
      );
      // ratio = 300/850 = 0.35 (< 0.4) -> stressHigh
      final finder = find.byType(Container).last;
      final container = tester.widget<Container>(finder);
      final boxDecoration = container.decoration as BoxDecoration;
      expect(boxDecoration.color, AppColors.stressHigh);
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatBar(label: 'Credit', emoji: '💳', value: 500, type: StatType.credit, maxValue: 850))),
      );
      // ratio = 500/850 = 0.58 (< 0.7) -> stressMedium
      final finder2 = find.byType(Container).last;
      final container2 = tester.widget<Container>(finder2);
      final boxDecoration2 = container2.decoration as BoxDecoration;
      expect(boxDecoration2.color, AppColors.stressMedium);
      
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatBar(label: 'Credit', emoji: '💳', value: 800, type: StatType.credit, maxValue: 850))),
      );
      // ratio = 800/850 = 0.94 (> 0.7) -> stressLow
      final finder3 = find.byType(Container).last;
      final container3 = tester.widget<Container>(finder3);
      final boxDecoration3 = container3.decoration as BoxDecoration;
      expect(boxDecoration3.color, AppColors.stressLow);
    });
  });
}
