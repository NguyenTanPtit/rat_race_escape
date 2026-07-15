import 'package:injectable/injectable.dart';
import '../entities/game_state.dart';

@lazySingleton
class UpdateMetricsUseCase {
  /// Modifies stress and creditScore. 
  /// E.g., if cash < 0, increase stress by 10 and decrease credit score by 20.
  /// If cash >= 0, increase credit score by 2.
  /// Cap stress at 100, credit score between 300 and 850.
  GameState call(GameState currentState) {
    int newStress = currentState.stress;
    int newCreditScore = currentState.creditScore;

    // Apply penalties if cash is negative
    if (currentState.cash < 0) {
      newStress += 10;
      newCreditScore -= 20;
    } else {
      // Reward for paying debts on time (cash >= 0 means they didn't go negative after loans)
      newCreditScore += 2;
    }

    // Cap stress between 0 and 100
    newStress = newStress.clamp(0, 100);
    
    // Cap credit score between 300 and 850
    newCreditScore = newCreditScore.clamp(300, 850);

    return currentState.copyWith(
      stress: newStress,
      creditScore: newCreditScore,
    );
  }
}
