import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/game_button.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';

void main() {
  group('GameButton Widget Test', () {
    testWidgets('GameButton renders child correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('GameButton fires onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameButton(
              onPressed: () {
                pressed = true;
              },
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GameButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('GameButton renders disabled state when onPressed is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GameButton(
              onPressed: null,
              child: Text('Disabled Button'),
            ),
          ),
        ),
      );

      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(GameButton),
          matching: find.byType(AnimatedContainer),
        ).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.disabledFill);
      expect(decoration.boxShadow, isEmpty); // No shadow when disabled
    });
  });
}
