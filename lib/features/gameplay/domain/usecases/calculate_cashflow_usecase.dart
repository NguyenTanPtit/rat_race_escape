import 'package:injectable/injectable.dart';
import '../entities/game_state.dart';

@injectable
class CalculateCashflowUseCase {
  /// Adds baseSalary and passiveIncome to cash, subtracts monthlyExpenses.
  GameState call(GameState currentState) {
    final double newCash = currentState.cash + 
        currentState.baseSalary + 
        currentState.passiveIncome - 
        currentState.monthlyExpenses;

    return currentState.copyWith(cash: newCash);
  }
}
