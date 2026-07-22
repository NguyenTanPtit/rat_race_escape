import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/dialogs/leisure_dialog.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';

class MockGameEngineCubit extends Mock implements GameEngineCubit {}

void main() {
  late MockGameEngineCubit mockCubit;

  setUp(() {
    mockCubit = MockGameEngineCubit();
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestWidget({required int usedThisMonth, required double cash}) {
    return MaterialApp(
      home: BlocProvider<GameEngineCubit>.value(
        value: mockCubit,
        child: Scaffold(
          body: LeisureDialog(
            leisureReliefUsedThisMonth: usedThisMonth,
            currentCash: cash,
          ),
        ),
      ),
    );
  }

  testWidgets('displays correct max points left', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget(usedThisMonth: 5, cash: 2000000));
    
    expect(find.textContaining('còn giảm được tối đa 15 điểm'), findsOneWidget);
  });

  testWidgets('blocks input exceeding max allowed amount', (WidgetTester tester) async {
    // used 19 this month, max points left is 1, max amount is 100k
    await tester.pumpWidget(buildTestWidget(usedThisMonth: 19, cash: 2000000));

    await tester.enterText(find.byType(TextField), '200000');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.textContaining('chỉ có thể chi tối đa 100k'), findsOneWidget);
    verifyNever(() => mockCubit.spendOnLeisure(any()));
  });

  testWidgets('blocks input exceeding current cash', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget(usedThisMonth: 0, cash: 50000));

    await tester.enterText(find.byType(TextField), '100000');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('Không đủ tiền mặt'), findsOneWidget);
    verifyNever(() => mockCubit.spendOnLeisure(any()));
  });

  testWidgets('calls spendOnLeisure when valid input is submitted', (WidgetTester tester) async {
    when(() => mockCubit.spendOnLeisure(any())).thenAnswer((_) async {});

    await tester.pumpWidget(buildTestWidget(usedThisMonth: 0, cash: 2000000));

    await tester.enterText(find.byType(TextField), '150000');
    
    // Tap the 'Xác nhận' button
    await tester.tap(find.widgetWithText(GameButton, 'Xác nhận'));
    await tester.pumpAndSettle();

    verify(() => mockCubit.spendOnLeisure(150000.0)).called(1);
    // Dialog should be popped
    expect(find.byType(LeisureDialog), findsNothing);
  });
}
