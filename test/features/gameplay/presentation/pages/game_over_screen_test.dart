import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/game_over_screen.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/insight_card_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/insight_card.dart';

class MockInsightCardRepository implements InsightCardRepository {
  List<InsightCard> getAllInsightCards() {
    return [
      const InsightCard(id: 'ic1', title: 'T1', description: 'D1', conceptKey: 'C1'),
      const InsightCard(id: 'ic2', title: 'T2', description: 'D2', conceptKey: 'C2'),
      const InsightCard(id: 'ic3', title: 'T3', description: 'D3', conceptKey: 'C3'),
    ];
  }

  @override
  Future<List<InsightCard>> loadInsightCards([String locale = 'vi']) {
    return SynchronousFuture(getAllInsightCards());
  }

  @override
  Future<InsightCard?> getInsightCard(String id, [String locale = 'vi']) async {
    return null;
  }
}

void main() {
  setUp(() {
    if (!GetIt.I.isRegistered<InsightCardRepository>()) {
      GetIt.I.registerSingleton<InsightCardRepository>(MockInsightCardRepository());
    }
  });

  tearDown(() {
    GetIt.I.unregister<InsightCardRepository>();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
    );
  }

  const gameState = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 0,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
    creditScore: 750,
    currentMonth: 48,
    unlockedInsightCardIds: {'ic1', 'ic2'},
  );

  testWidgets('GameOverScreen renders burnout reason and stats', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const GameOverScreen(
      reason: GameOverReason.burnout,
      finalState: gameState,
      newCards: {},
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('kiệt sức'), findsOneWidget); // burnout
    expect(find.textContaining('48'), findsOneWidget); // Months played
    expect(find.textContaining('750'), findsOneWidget); // Credit score
    expect(find.textContaining('2/3'), findsOneWidget); // Collected cards
  });

  testWidgets('GameOverScreen renders bankruptcy reason', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const GameOverScreen(
      reason: GameOverReason.bankruptcy,
      finalState: gameState,
      newCards: {},
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('vỡ nợ'), findsOneWidget);
  });

  testWidgets('GameOverScreen renders debtSpiral reason', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const GameOverScreen(
      reason: GameOverReason.debtSpiral,
      finalState: gameState,
      newCards: {},
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('vòng xoáy nợ nần'), findsOneWidget);
  });

  testWidgets('GameOverScreen renders poorAtRetirement reason', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const GameOverScreen(
      reason: GameOverReason.poorAtRetirement,
      finalState: gameState,
      newCards: {},
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('nghỉ hưu'), findsOneWidget);
  });
}
