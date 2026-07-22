import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset_listing.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

@lazySingleton
class BuyAssetUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  BuyAssetUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state, AssetListing assetListing, double amount) {
    if (amount <= 0) {
      return Left(Failure('Amount must be greater than 0'));
    }
    if (amount > state.cash) {
      return Left(Failure('Not enough cash to buy this asset'));
    }

    final newAsset = Asset(
      id: '${assetListing.id}_${DateTime.now().millisecondsSinceEpoch}',
      name: assetListing.name,
      type: assetListing.type,
      baseValue: amount,
      monthlyPassiveIncome: amount * (assetListing.annualYieldRate / 100 / 12),
    );

    final updatedState = state.copyWith(
      cash: state.cash - amount,
      assets: [...state.assets, newAsset],
    );

    return Right(_checkGameStatus(updatedState));
  }
}
