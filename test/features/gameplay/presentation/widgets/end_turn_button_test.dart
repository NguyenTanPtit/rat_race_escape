import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/end_turn_button.dart';

void main() {
  testWidgets('EndTurnButton renders and handles tap correctly', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: EndTurnButton(
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      ),
    );

    final containerFinder = find.byType(AnimatedContainer);
    expect(containerFinder, findsOneWidget);

    final container = tester.widget<AnimatedContainer>(containerFinder);
    expect(container.constraints?.maxWidth, 80);
    expect(container.constraints?.maxHeight, 80);

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.shape, BoxShape.circle);
    expect(decoration.color, AppColors.primary);
    expect(decoration.boxShadow?.first.color, AppColors.shadowOnPrimary);
    expect(decoration.boxShadow?.first.offset, const Offset(4.0, 6.0));

    // Tap the button
    await tester.tap(find.byType(EndTurnButton));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets('EndTurnButton renders disabled state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: EndTurnButton(
              onPressed: null,
            ),
          ),
        ),
      ),
    );

    final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    final decoration = container.decoration as BoxDecoration;
    
    expect(decoration.color, AppColors.disabledFill);
    expect(decoration.boxShadow, isEmpty);
  });
}
