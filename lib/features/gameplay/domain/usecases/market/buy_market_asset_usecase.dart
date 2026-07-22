import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

/// Buys [amount] worth of a market asset class at the current price.
///
/// units = amount / price, so buying below the base price of 1.0 earns a
/// higher yield-on-cost (passive income is fixed per unit). Holdings are
/// merged: at most one Asset per market class.
@lazySingleton
class BuyMarketAssetUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  BuyMarketAssetUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, String classId, double amount) {
    final classState = state.market[classId];
    if (classState == null) {
      return Left(Failure('Unknown market class: $classId'));
    }
    if (amount <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    if (amount > state.cash) {
      return Left(Failure('Not enough cash to buy this asset'));
    }

    final unitsBought = amount / classState.price;
    final passiveBought = unitsBought * classState.passivePerUnitMonthly;

    final existingIndex = state.assets.indexWhere((a) => a.marketClassId == classId);
    final List<Asset> updatedAssets;
    if (existingIndex >= 0) {
      final existing = state.assets[existingIndex];
      updatedAssets = List.of(state.assets);
      updatedAssets[existingIndex] = existing.copyWith(
        units: existing.units + unitsBought,
        baseValue: existing.baseValue + amount,
        monthlyPassiveIncome: existing.monthlyPassiveIncome + passiveBought,
      );
    } else {
      updatedAssets = [
        ...state.assets,
        Asset(
          id: 'mkt_$classId',
          name: classState.name,
          type: classState.config.type,
          baseValue: amount,
          monthlyPassiveIncome: passiveBought,
          units: unitsBought,
          marketClassId: classId,
        ),
      ];
    }

    final updatedState = state.copyWith(
      cash: state.cash - amount,
      assets: updatedAssets,
    );

    return Right(_checkGameStatus(updatedState));
  }
}
