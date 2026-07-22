import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

/// Sells up to [amountValue] (market value) of a market holding at the
/// current price, minus the sell fee. Cost basis and passive income shrink
/// proportionally to the units sold; selling everything removes the Asset.
@lazySingleton
class SellMarketAssetUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  SellMarketAssetUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, String classId, double amountValue) {
    final classState = state.market[classId];
    if (classState == null) {
      return Left(Failure('Unknown market class: $classId'));
    }
    if (amountValue <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    final holdingIndex = state.assets.indexWhere((a) => a.marketClassId == classId);
    if (holdingIndex == -1) {
      return Left(Failure('No holding for market class: $classId'));
    }

    final holding = state.assets[holdingIndex];
    final holdingValue = holding.units * classState.price;
    final sellValue = amountValue > holdingValue ? holdingValue : amountValue;
    final unitsSold = sellValue / classState.price;
    final fraction = holding.units <= 0 ? 1.0 : unitsSold / holding.units;
    final receivedCash = sellValue * (1 - state.assetSellFeeRate);

    final List<Asset> updatedAssets = List.of(state.assets);
    if (fraction >= 1.0 || (holding.units - unitsSold).abs() < 1e-9 ||
        (holdingValue - sellValue).abs() < 0.01) {
      updatedAssets.removeAt(holdingIndex);
    } else {
      updatedAssets[holdingIndex] = holding.copyWith(
        units: holding.units - unitsSold,
        baseValue: holding.baseValue * (1 - fraction),
        monthlyPassiveIncome: holding.monthlyPassiveIncome * (1 - fraction),
      );
    }

    final updatedState = state.copyWith(
      cash: state.cash + receivedCash,
      assets: updatedAssets,
    );

    return Right(_checkGameStatus(updatedState));
  }
}
