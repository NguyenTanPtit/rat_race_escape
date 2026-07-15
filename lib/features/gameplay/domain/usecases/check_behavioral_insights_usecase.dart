import 'package:injectable/injectable.dart';
import '../entities/game_state.dart';
import '../entities/loan.dart';

@lazySingleton
class CheckBehavioralInsightsUseCase {
  GameState call(GameState currentState) {
    GameState state = currentState;
    
    final hasCreditCard = state.loans.any((loan) => loan.type == LoanType.creditCard);
    final hasEnoughCash = state.cash >= state.totalMonthlyOutflow;

    if (hasCreditCard && hasEnoughCash) {
      final newCount = state.consecutiveMinimumCreditCardPayments + 1;
      state = state.copyWith(consecutiveMinimumCreditCardPayments: newCount);

      if (newCount >= 3 && !state.unlockedInsightCardIds.contains('mental_accounting')) {
        final newUnlockedCards = {...state.unlockedInsightCardIds, 'mental_accounting'};
        state = state.copyWith(unlockedInsightCardIds: newUnlockedCards);
      }
    } else {
      state = state.copyWith(consecutiveMinimumCreditCardPayments: 0);
    }

    return state;
  }
}
