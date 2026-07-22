import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';

void main() {
  group('GameCard Widget Test', () {
    testWidgets('GameCard renders child correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GameCard(
              child: Text('Test Card'),
            ),
          ),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
    });

    testWidgets('GameCard applies correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GameCard(
              fill: Colors.red,
              shadowColor: Colors.blue,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(GameCard),
          matching: find.byType(DecoratedBox),
        ).first,
      );

      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);
      expect(decoration.boxShadow?.first.color, Colors.blue);
      expect(decoration.border?.top.color, AppColors.ink);
    });
  });
}
