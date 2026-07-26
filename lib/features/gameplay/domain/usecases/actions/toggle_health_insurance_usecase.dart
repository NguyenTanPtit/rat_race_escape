import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';

/// Buys or cancels health insurance. The premium is charged monthly via
/// totalMonthlyOutflow; coverage swaps event costs to `cashIfInsured`.
@lazySingleton
class ToggleHealthInsuranceUseCase {
  final CheckGameStatusUseCase _checkGameStatus;

  ToggleHealthInsuranceUseCase(this._checkGameStatus);

  Either<Failure, TurnResult> call(GameState state) {
    if (state.healthInsurancePremiumMonthly <= 0) {
      return Left(Failure('Health insurance is not offered in this scenario'));
    }
    final updatedState = state.copyWith(hasHealthInsurance: !state.hasHealthInsurance);
    return Right(_checkGameStatus(updatedState));
  }
}
