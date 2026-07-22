import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

@lazySingleton
class SellAssetUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  SellAssetUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, String assetId) {
    final assetIndex = state.assets.indexWhere((a) => a.id == assetId);
    if (assetIndex == -1) {
      return Left(Failure('Asset not found'));
    }

    final asset = state.assets[assetIndex];
    final receivedCash = asset.baseValue * (1 - state.assetSellFeeRate);
    
    final updatedAssets = List.of(state.assets)..removeAt(assetIndex);

    final updatedState = state.copyWith(
      cash: state.cash + receivedCash,
      assets: updatedAssets,
    );

    return Right(_checkGameStatus(updatedState));
  }
}
