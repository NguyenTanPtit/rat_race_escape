import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/bottom_nav.dart';

void main() {
  testWidgets('BottomNav renders according to spec', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNav(),
        ),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container).first);
    expect(container.constraints?.minHeight, 85);

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, AppColors.navFill);

    final border = decoration.border as Border;
    expect(border.top.width, AppTokens.borderWidth);
    expect(border.left.width, AppTokens.borderWidth);
    expect(border.right.width, AppTokens.borderWidth);
    expect(border.bottom.width, 0.0);

    expect(decoration.borderRadius, const BorderRadius.vertical(top: Radius.circular(24)));
    expect(decoration.boxShadow?.first.offset, AppTokens.shadowOffsetUp);
    expect(decoration.boxShadow?.first.color, const Color(0xFF000000));

    expect(find.text('Tài sản'), findsOneWidget);
    expect(find.text('Đầu tư'), findsOneWidget);
    expect(find.text('Ngân hàng'), findsOneWidget);
    expect(find.text('Nâng cấp'), findsOneWidget);
  });
}
