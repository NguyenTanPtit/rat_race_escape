import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/dialogs/yearly_recap_dialog.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/core/theme/app_theme.dart';

void main() {
  testWidgets('YearlyRecapDialog renders 3 main blocks', (WidgetTester tester) async {
    final recap = YearlyRecap(
      totalCashIn: 50000000,
      totalCashOut: 45000000,
      topEvents: [
        (
          ageInMonths: 300,
          netWorth: 10000000,
          cashIn: 0,
          cashOut: 0,
          cashDelta: -2000000,
          eventId: 'event_tet_holiday',
        ),
      ],
      fullHistory: [
        (
          ageInMonths: 300,
          netWorth: 10000000,
          cashIn: 0,
          cashOut: 0,
          cashDelta: 0,
          eventId: null,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Material(
          child: Builder(
            builder: (context) => YearlyRecapDialog(
              recap: recap,
            ),
          ),
        ),
      ),
    );

    // Verify Title
    expect(find.text('TỔNG KẾT NĂM'), findsOneWidget);

    // Block 1: Income vs Expense
    expect(find.text('Tổng thu'), findsOneWidget);
    expect(find.text('Tổng chi'), findsOneWidget);
    expect(find.text('50tr ₫'), findsOneWidget); // cashIn
    expect(find.text('45tr ₫'), findsOneWidget); // cashOut

    // Block 2: Top Events
    expect(find.text('Sự kiện nổi bật'), findsOneWidget);
    expect(find.text('event_tet_holiday'), findsOneWidget);

    // Block 3: Net Worth Chart
    expect(find.text('Biến động tài sản (12 tháng)'), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets); // Chart uses CustomPaint

    // Buttons
    expect(find.text('Ăn Tết'), findsOneWidget);
  });
}
