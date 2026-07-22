import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/money_display.dart';

void main() {
  group('MoneyDisplay Widget Test', () {
    testWidgets('MoneyDisplay renders amount correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoneyDisplay(
              label: 'Tiền mặt',
              amount: 1500000,
            ),
          ),
        ),
      );

      expect(find.text('Tiền mặt'), findsOneWidget);
      expect(find.text('1,5tr ₫'), findsOneWidget);
      expect(find.text('+500k ₫/tháng'), findsNothing);
    });

    testWidgets('MoneyDisplay renders cashflow chip if provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoneyDisplay(
              label: 'Tiền mặt',
              amount: 1500000,
              cashflow: 500000,
            ),
          ),
        ),
      );

      expect(find.text('+500k ₫/tháng'), findsOneWidget);
    });
    
    testWidgets('MoneyDisplay does not render cashflow chip if cashflow is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoneyDisplay(
              label: 'Tiền mặt',
              amount: 1500000,
              cashflow: 0,
            ),
          ),
        ),
      );

      expect(find.text('+0 ₫/tháng'), findsNothing);
    });
  });
}
