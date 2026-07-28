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


  group('Inflation block (Slice 2.5)', () {
    YearlyRecap recapWith(InflationRecap? inflation) => YearlyRecap(
          totalCashIn: 50000000,
          totalCashOut: 45000000,
          topEvents: const [],
          fullHistory: const [
            (
              ageInMonths: 300,
              netWorth: 10000000,
              cashIn: 0,
              cashOut: 0,
              cashDelta: 0,
              eventId: null,
            ),
          ],
          inflation: inflation,
        );

    Future<void> pump(WidgetTester tester, YearlyRecap recap) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.lightTheme,
        home: Material(child: YearlyRecapDialog(recap: recap)),
      ));
    }

    testWidgets('shows the yearly price/salary bump', (tester) async {
      await pump(tester, recapWith(const InflationRecap(
        annualRate: 0.035,
        salaryGrowthRate: 0.03,
        newMonthlyOutflow: 10867500,
        newSalary: 11330000,
        cashHeld: 2000000,
        cashValueLost: 67632,
      )));

      expect(find.textContaining('Vật giá năm nay +3.5%'), findsOneWidget);
      expect(find.textContaining('Chi phí sống giờ 10,87tr ₫/tháng'), findsOneWidget);
      expect(find.textContaining('Lương +3.0%'), findsOneWidget);
      // Small cash pile -> no nagging.
      expect(find.textContaining('mất'), findsNothing);
    });

    testWidgets('warns about idle cash once the pile is over 3 months of costs',
        (tester) async {
      await pump(tester, recapWith(const InflationRecap(
        annualRate: 0.035,
        salaryGrowthRate: 0.03,
        newMonthlyOutflow: 10000000,
        newSalary: 11330000,
        cashHeld: 100000000,
        cashValueLost: 3381643,
      )));

      expect(find.textContaining('100tr ₫ tiền mặt của bạn'), findsOneWidget);
      expect(find.textContaining('mất 3,38tr ₫ giá trị năm nay'), findsOneWidget);
    });

    testWidgets('scenario without inflation shows no inflation block', (tester) async {
      await pump(tester, recapWith(null));
      expect(find.textContaining('Vật giá'), findsNothing);
    });
  });
}
