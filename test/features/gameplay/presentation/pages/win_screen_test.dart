import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/insight_card.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/insight_card_repository.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/win_screen.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

import 'main_game_screen_test.dart' show expectNoRawMoney;

class MockInsightCardRepository implements InsightCardRepository {
  @override
  Future<List<InsightCard>> loadInsightCards([String locale = 'vi']) {
    return SynchronousFuture(const [
      InsightCard(id: 'ic1', title: 'T1', description: 'D1', conceptKey: 'C1'),
      InsightCard(id: 'ic2', title: 'T2', description: 'D2', conceptKey: 'C2'),
    ]);
  }

  @override
  Future<InsightCard?> getInsightCard(String id, [String locale = 'vi']) async => null;
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

  // A winner: 1,2 tỷ nominal after 15 years of 3.5% inflation.
  const winner = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 200000000,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
    creditScore: 800,
    currentMonth: 180,
    inflationIndex: 1.675,
    unlockedInsightCardIds: {'ic1'},
    assets: [
      Asset(
        id: 'a1',
        name: 'Quỹ Index',
        baseValue: 1000000000,
        monthlyPassiveIncome: 20000000,
      ),
    ],
  );

  testWidgets('WinScreen formats money and shows real purchasing power',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const WinScreen(
      finalState: winner,
      newCards: {},
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('Tài sản ròng: 1,2 tỷ ₫'), findsOneWidget);
    expect(find.textContaining('Sức mua theo giá năm đầu: 716,42tr ₫'), findsOneWidget);
    expect(find.textContaining('Net Worth'), findsNothing, reason: 'game tiếng Việt');
    expectNoRawMoney(tester);
  });

  testWidgets('no inflation in the scenario means no real-value line',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WinScreen(
      finalState: winner.copyWith(inflationIndex: 1.0),
      newCards: const {},
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('Sức mua theo giá năm đầu'), findsNothing);
    expectNoRawMoney(tester);
  });
}
