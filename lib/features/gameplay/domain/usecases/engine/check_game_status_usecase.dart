import 'package:injectable/injectable.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';

@lazySingleton
class CheckGameStatusUseCase {
  TurnResult call(GameState currentState) {
    // THẮNG: passive income >= total monthly outflow
    if (currentState.passiveIncome > 0 && currentState.passiveIncome >= currentState.totalMonthlyOutflow) {
      return TurnResult.won(currentState);
    }

    // THUA: Stress >= 100
    if (currentState.stress >= 100) {
      return TurnResult.lost(currentState, GameOverReason.burnout);
    }

    // THUA: Debt Spiral (creditScore <= 300 && cash < 0)
    if (currentState.creditScore <= 300 && currentState.cash < 0) {
      return TurnResult.lost(currentState, GameOverReason.debtSpiral);
    }

    // THUA: Bankruptcy (Cash < -(Threshold * totalMonthlyOutflow))
    if (currentState.cash < -(currentState.bankruptcyMonthsThreshold * currentState.totalMonthlyOutflow)) {
      return TurnResult.lost(currentState, GameOverReason.bankruptcy);
    }

    // THUA: Poor at retirement (Age >= 65, which is 65 * 12 = 780 months)
    if (currentState.ageInMonths >= 780) {
      return TurnResult.lost(currentState, GameOverReason.poorAtRetirement);
    }

    // TIẾP TỤC
    return TurnResult.continued(currentState);
  }
}
