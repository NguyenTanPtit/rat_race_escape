import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/pages/invest_screen.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/market/market_decision_dialog.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/market/market_trade_dialog.dart';

class MockGameEngineCubit extends Mock implements GameEngineCubit {}

const _config = MarketClassConfig(
  id: 'land',
  name: 'Đất nền',
  type: AssetType.realEstate,
  annualYieldRate: 2.5,
  monthlyDrift: 0.55,
  monthlyVolatility: 4.5,
  crashChance: 0.011,
  crashMonthlyDrift: -7.5,
  crashMinMonths: 6,
  crashMaxMonths: 12,
  boomChance: 0.014,
  boomMonthlyDrift: 5.5,
  boomMinMonths: 6,
  boomMaxMonths: 12,
);

GameState buildGameState({
  double cash = 20000000,
  double price = 1.0,
  double peak = 1.0,
  Asset? holding,
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: cash,
    monthlyExpenses: 5000000,
    monthlyRent: 3500000,
    baseSalary: 11000000,
    market: {
      'land': MarketClassState(
        config: _config,
        price: price,
        peakPrice: peak,
        recentPrices: [peak, price],
      ),
    },
    assets: holding == null ? const [] : [holding],
  );
}

void main() {
  late MockGameEngineCubit mockCubit;

  setUp(() {
    mockCubit = MockGameEngineCubit();
    when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget wrap(Widget child) {
    return MaterialApp(
      home: BlocProvider<GameEngineCubit>.value(value: mockCubit, child: child),
    );
  }

  group('InvestScreen', () {
    testWidgets('renders class card with price, drawdown badge and disabled sell when no holding',
        (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(price: 0.7, peak: 1.0)));

      await tester.pumpWidget(wrap(const InvestScreen()));

      expect(find.text('Đất nền'), findsOneWidget);
      expect(find.textContaining('Giá: 70% so với đầu kỳ'), findsOneWidget);
      expect(find.textContaining('−30% từ đỉnh'), findsOneWidget);
      expect(find.text('Chưa sở hữu'), findsOneWidget);

      // Sell button disabled (GameButton with null onPressed) — tap does nothing.
      final sellButton = tester.widget<GameButton>(find.widgetWithText(GameButton, 'Bán'));
      expect(sellButton.onPressed, isNull);
    });

    testWidgets('shows holding value at market price and profit percent', (tester) async {
      // Bought 10tr at price 1.0 (units 10tr), price now 1.2 -> value 12tr, +20%
      final holding = const Asset(
        id: 'mkt_land',
        name: 'Đất nền',
        type: AssetType.realEstate,
        baseValue: 10000000,
        monthlyPassiveIncome: 20833,
        units: 10000000,
        marketClassId: 'land',
      );
      when(() => mockCubit.state).thenReturn(
          GameEngineState.playing(buildGameState(price: 1.2, peak: 1.2, holding: holding)));

      await tester.pumpWidget(wrap(const InvestScreen()));

      expect(find.textContaining('Đang giữ: 12tr ₫'), findsOneWidget);
      expect(find.textContaining('+20.0%'), findsOneWidget);
    });

    testWidgets('no overflow on narrow screen with 3-digit price and monthly change', (tester) async {
      // Regression: the price row overflowed by 2.6px on a real device when
      // price hit 286% and the monthly-change chip rendered next to it.
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.reset);

      final cls = MarketClassState(
        config: _config,
        price: 2.86,
        peakPrice: 2.9,
        recentPrices: [2.9, 2.83, 2.86], // enough for a monthly change value
      );
      when(() => mockCubit.state).thenReturn(GameEngineState.playing(
        buildGameState().copyWith(market: {'land': cls}),
      ));

      await tester.pumpWidget(wrap(const InvestScreen()));

      expect(tester.takeException(), isNull);
      expect(find.textContaining('Giá: 286% so với đầu kỳ'), findsOneWidget);
    });

    testWidgets('tapping Mua opens the trade dialog in buy mode', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState()));

      await tester.pumpWidget(wrap(const InvestScreen()));
      await tester.tap(find.widgetWithText(GameButton, 'Mua'));
      await tester.pumpAndSettle();

      expect(find.byType(MarketTradeDialog), findsOneWidget);
      expect(find.text('MUA ĐẤT NỀN'), findsOneWidget);
    });
  });

  group('MarketTradeDialog', () {
    testWidgets('buy: blocks amount above cash and submits valid amount', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(cash: 1000000)));
      when(() => mockCubit.buyMarketAsset(any(), any())).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const Scaffold(
        body: MarketTradeDialog(classId: 'land', className: 'Đất nền', isBuy: true),
      )));

      await tester.enterText(find.byType(TextField), '2000000');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.textContaining('Không đủ tiền mặt'), findsOneWidget);
      verifyNever(() => mockCubit.buyMarketAsset(any(), any()));

      await tester.enterText(find.byType(TextField), '500000');
      await tester.tap(find.widgetWithText(GameButton, 'Mua'));
      await tester.pumpAndSettle();
      verify(() => mockCubit.buyMarketAsset('land', 500000)).called(1);
    });

    testWidgets('sell: blocks amount above holding value and submits valid amount', (tester) async {
      final holding = const Asset(
        id: 'mkt_land',
        name: 'Đất nền',
        type: AssetType.realEstate,
        baseValue: 10000000,
        units: 10000000,
        marketClassId: 'land',
      );
      when(() => mockCubit.state).thenReturn(
          GameEngineState.playing(buildGameState(price: 0.5, peak: 1.0, holding: holding)));
      when(() => mockCubit.sellMarketAsset(any(), any())).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const Scaffold(
        body: MarketTradeDialog(classId: 'land', className: 'Đất nền', isBuy: false),
      )));

      // Holding worth 5tr at current price; 6tr must be rejected.
      await tester.enterText(find.byType(TextField), '6000000');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.textContaining('chỉ đang giữ 5tr ₫'), findsOneWidget);
      verifyNever(() => mockCubit.sellMarketAsset(any(), any()));

      await tester.enterText(find.byType(TextField), '3000000');
      await tester.tap(find.widgetWithText(GameButton, 'Bán'));
      await tester.pumpAndSettle();
      verify(() => mockCubit.sellMarketAsset('land', 3000000)).called(1);
    });
  });

  group('Money input formatting', () {
    testWidgets('typed amount shows thousands separators and still parses correctly',
        (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(cash: 20000000)));
      when(() => mockCubit.buyMarketAsset(any(), any())).thenAnswer((_) async {});

      await tester.pumpWidget(wrap(const Scaffold(
        body: MarketTradeDialog(classId: 'land', className: 'Đất nền', isBuy: true),
      )));

      await tester.enterText(find.byType(TextField), '2000000');
      await tester.pump();

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.controller!.text, '2.000.000');

      await tester.tap(find.widgetWithText(GameButton, 'Mua'));
      await tester.pumpAndSettle();
      verify(() => mockCubit.buyMarketAsset('land', 2000000)).called(1);
    });
  });

  group('MarketDecisionDialog', () {
    testWidgets('crash stop shows drawdown headline and all three choices', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(price: 0.75, peak: 1.0)));

      await tester.pumpWidget(wrap(const Scaffold(
        body: MarketDecisionDialog(
          info: MarketStopInfo(
            classId: 'land',
            className: 'Đất nền',
            kind: MarketStopKind.crash,
            changePercent: 25,
          ),
        ),
      )));

      expect(find.text('📉 Đất nền sụt −25% từ đỉnh!'), findsOneWidget);
      expect(find.textContaining('Múc thêm'), findsOneWidget);
      expect(find.textContaining('Bán bớt'), findsOneWidget);
      expect(find.textContaining('Gồng giữ'), findsOneWidget);
    });

    testWidgets('boom stop shows boom headline', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(price: 1.3, peak: 1.3)));

      await tester.pumpWidget(wrap(const Scaffold(
        body: MarketDecisionDialog(
          info: MarketStopInfo(
            classId: 'land',
            className: 'Đất nền',
            kind: MarketStopKind.boom,
            changePercent: 30,
          ),
        ),
      )));

      expect(find.text('📈 Đất nền tăng nóng +30% so với trung bình năm!'), findsOneWidget);
    });

    testWidgets('Múc thêm opens buy dialog for the stopped class', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GameEngineState.playing(buildGameState(price: 0.75, peak: 1.0)));

      await tester.pumpWidget(wrap(const Scaffold(
        body: MarketDecisionDialog(
          info: MarketStopInfo(
            classId: 'land',
            className: 'Đất nền',
            kind: MarketStopKind.crash,
            changePercent: 25,
          ),
        ),
      )));

      await tester.tap(find.textContaining('Múc thêm'));
      await tester.pumpAndSettle();

      expect(find.byType(MarketTradeDialog), findsOneWidget);
      expect(find.text('MUA ĐẤT NỀN'), findsOneWidget);
    });
  });
}
