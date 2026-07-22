import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/sell_market_asset_usecase.dart';

const _classId = 'index_fund';

MarketClassState buildClassState({double price = 1.0}) {
  return MarketClassState(
    config: const MarketClassConfig(
      id: _classId,
      name: 'Quỹ Index',
      type: AssetType.stock,
      annualYieldRate: 12.0, // 1%/month per unit at base price -> easy math
      monthlyDrift: 0.3,
      monthlyVolatility: 2.0,
      crashChance: 0.0,
      crashMonthlyDrift: -5.0,
      crashMinMonths: 5,
      crashMaxMonths: 10,
      boomChance: 0.0,
      boomMonthlyDrift: 3.0,
      boomMinMonths: 6,
      boomMaxMonths: 12,
    ),
    price: price,
    peakPrice: price >= 1.0 ? price : 1.0,
  );
}

GameState buildState({
  double cash = 100000000,
  double price = 1.0,
  List<Asset> assets = const [],
}) {
  return GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: cash,
    monthlyExpenses: 10000000,
    monthlyRent: 0,
    baseSalary: 11000000,
    market: {_classId: buildClassState(price: price)},
    assets: assets,
  );
}

void main() {
  final buy = BuyMarketAssetUseCase(CheckGameStatusUseCase());
  final sell = SellMarketAssetUseCase(CheckGameStatusUseCase());

  group('BuyMarketAssetUseCase', () {
    test('rejects unknown class, non-positive amount, and amount above cash', () {
      final state = buildState(cash: 1000000);
      expect(buy(state, 'nonexistent', 500000).isLeft(), isTrue);
      expect(buy(state, _classId, 0).isLeft(), isTrue);
      expect(buy(state, _classId, -5).isLeft(), isTrue);
      expect(buy(state, _classId, 1000001).isLeft(), isTrue);
    });

    test('buys units at current price and deducts cash', () {
      final state = buildState(cash: 10000000, price: 1.0);
      final result = buy(state, _classId, 4000000);
      final newState = result.getRight().toNullable()!.state;

      expect(newState.cash, closeTo(6000000, 0.01));
      expect(newState.assets.length, 1);
      final holding = newState.assets.single;
      expect(holding.marketClassId, _classId);
      expect(holding.units, closeTo(4000000, 0.01));
      expect(holding.baseValue, closeTo(4000000, 0.01));
      // 12%/year on base price -> 1%/month per unit
      expect(holding.monthlyPassiveIncome, closeTo(40000, 0.01));
      expect(newState.assetMarketValue(holding), closeTo(4000000, 0.01));
    });

    test('merges into one holding per class on repeat buys', () {
      final state = buildState(cash: 10000000);
      final afterFirst = buy(state, _classId, 2000000).getRight().toNullable()!.state;
      final afterSecond = buy(afterFirst, _classId, 3000000).getRight().toNullable()!.state;

      expect(afterSecond.assets.length, 1);
      expect(afterSecond.assets.single.baseValue, closeTo(5000000, 0.01));
      expect(afterSecond.cash, closeTo(5000000, 0.01));
    });

    test('buying below base price earns higher yield-on-cost', () {
      final atPar = buy(buildState(price: 1.0), _classId, 1000000)
          .getRight().toNullable()!.state.assets.single;
      final atDip = buy(buildState(price: 0.5), _classId, 1000000)
          .getRight().toNullable()!.state.assets.single;

      // Same money, half price -> double units -> double passive income.
      expect(atDip.units, closeTo(atPar.units * 2, 0.01));
      expect(atDip.monthlyPassiveIncome, closeTo(atPar.monthlyPassiveIncome * 2, 0.01));
    });

    test('returns TurnWon when passive income reaches total outflow', () {
      // outflow 10tr/month; 12%/yr yield -> need 1 tỷ invested at par
      final state = buildState(cash: 1500000000);
      final result = buy(state, _classId, 1000000000);
      expect(result.getRight().toNullable(), isA<TurnWon>());
    });
  });

  group('SellMarketAssetUseCase', () {
    GameState stateWithHolding({double price = 1.0, double invested = 6000000}) {
      final bought = buy(buildState(cash: invested, price: 1.0), _classId, invested)
          .getRight().toNullable()!.state;
      // Reprice the market after the purchase if requested.
      if (price == 1.0) return bought;
      return bought.copyWith(
        market: {_classId: buildClassState(price: price)},
      );
    }

    test('rejects unknown class, missing holding, and non-positive amount', () {
      final noHolding = buildState();
      expect(sell(noHolding, 'nonexistent', 100).isLeft(), isTrue);
      expect(sell(noHolding, _classId, 100).isLeft(), isTrue);
      expect(sell(stateWithHolding(), _classId, 0).isLeft(), isTrue);
    });

    test('partial sell reduces units, cost basis and passive proportionally', () {
      final state = stateWithHolding(invested: 6000000);
      final result = sell(state, _classId, 2000000);
      final newState = result.getRight().toNullable()!.state;

      final holding = newState.assets.single;
      expect(holding.units, closeTo(4000000, 0.01));
      expect(holding.baseValue, closeTo(4000000, 0.01));
      expect(holding.monthlyPassiveIncome, closeTo(40000, 0.01));
      // 3% fee on the 2tr sold
      expect(newState.cash, closeTo(2000000 * 0.97, 0.01));
    });

    test('selling everything removes the holding', () {
      final state = stateWithHolding(invested: 6000000);
      final newState = sell(state, _classId, 6000000).getRight().toNullable()!.state;
      expect(newState.assets, isEmpty);
      expect(newState.cash, closeTo(6000000 * 0.97, 0.01));
    });

    test('oversell clamps to holding market value', () {
      final state = stateWithHolding(invested: 6000000);
      final newState = sell(state, _classId, 999999999).getRight().toNullable()!.state;
      expect(newState.assets, isEmpty);
      expect(newState.cash, closeTo(6000000 * 0.97, 0.01));
    });

    test('sells at CURRENT market price, not cost basis', () {
      // Bought 6tr at price 1.0, market fell to 0.5 -> holding worth 3tr.
      final state = stateWithHolding(price: 0.5, invested: 6000000);
      final newState = sell(state, _classId, 999999999).getRight().toNullable()!.state;
      expect(newState.assets, isEmpty);
      // Panic-selling the dip realizes the loss: only 3tr × 0.97 comes back.
      expect(newState.cash, closeTo(3000000 * 0.97, 0.01));
    });

    test('net worth changes only by the sell fee', () {
      final state = stateWithHolding(invested: 6000000);
      final before = state.netWorth;
      final newState = sell(state, _classId, 2000000).getRight().toNullable()!.state;
      expect((before - 2000000 * 0.03 - newState.netWorth).abs(), lessThan(0.01));
    });
  });
}
