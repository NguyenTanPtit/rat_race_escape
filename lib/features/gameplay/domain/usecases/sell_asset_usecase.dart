import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../entities/game_state.dart';
import '../entities/turn_result.dart';
import 'check_game_status_usecase.dart';

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
