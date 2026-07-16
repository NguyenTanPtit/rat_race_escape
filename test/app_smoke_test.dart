import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:rat_race_escape/core/di/injection.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/game_state_repository.dart';
import 'package:rat_race_escape/main.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/main_game_screen.dart';

import 'package:rat_race_escape/features/gameplay/presentation/widgets/end_turn_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/event_card.dart';
import 'dart:math';

class _MockRandom implements Random {
  @override double nextDouble() => 0.0; // Force events to trigger
  @override int nextInt(int max) => 0;
  @override bool nextBool() => true;
}

void main() {
  group('App Smoke Test', () {
    late Directory tempDir;

    setUp(() async {
      await getIt.reset();
      tempDir = await Directory.systemTemp.createTemp();
      Hive.init(tempDir.path);
      await configureDependencies();
      if (getIt.isRegistered<Random>()) {
        getIt.unregister<Random>();
      }
      getIt.registerLazySingleton<Random>(() => _MockRandom());
      // Pre-open the Hive box in real async so it doesn't hang FakeAsync
      await getIt<GameStateRepository>().hasSavedGame();
    });



    testWidgets('Starting a new game navigates to MainGameScreen without exception', (WidgetTester tester) async {
      await tester.pumpWidget(const RatRaceEscapeApp());
      
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }
      
      final newGameBtn = find.byType(ElevatedButton).last;
      expect(newGameBtn, findsOneWidget);

      await tester.tap(newGameBtn);
      
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }

      expect(find.byType(MainGameScreen), findsOneWidget);
      
      // Tap End Turn button
      final endTurnBtn = find.byType(EndTurnButton);
      expect(endTurnBtn, findsOneWidget);
      await tester.tap(endTurnBtn);
      
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }

      // Monthly Summary Dialog should appear
      expect(find.byType(AlertDialog), findsOneWidget);
      
      // Tap OK on the Monthly Summary Dialog
      await tester.tap(find.text('Đồng ý'));
      
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }

      // Verify that EventCard is shown because Random returns 0.0
      expect(find.byType(EventCard), findsOneWidget);

      // Tap the first option of the event
      final optionBtn = find.descendant(
        of: find.byType(EventCard),
        matching: find.byType(ElevatedButton),
      ).first;
      await tester.ensureVisible(optionBtn);
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();
      await tester.tap(optionBtn);

      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 500));
      }

      // EventCard should be gone (currentEventId cleared)
      expect(find.byType(EventCard), findsNothing);
      
      // Cleanup temp dir
      if (tempDir.existsSync()) {
        try {
          tempDir.deleteSync(recursive: true);
        } catch (_) {}
      }
    });
  });
}
