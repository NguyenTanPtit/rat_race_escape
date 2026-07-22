import 'dart:math';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/game_state.dart';
import '../entities/turn_result.dart';
import '../repositories/event_pool_repository.dart';
import 'check_game_status_usecase.dart';

@lazySingleton
class ApplyEventOptionUseCase {
  final EventPoolRepository _eventPoolRepository;
  final CheckGameStatusUseCase _checkGameStatusUseCase;

  ApplyEventOptionUseCase(
    this._eventPoolRepository,
    this._checkGameStatusUseCase,
  );

  Future<Either<Failure, TurnResult>> call(
    GameState currentState,
    String eventId,
    String optionId,
  ) async {
    // 1. Validate active event
    if (currentState.currentEventId != eventId) {
      return Left(Failure('Invalid active event'));
    }

    // 2. Load event pool
    final eventPool = await _eventPoolRepository.loadEventPool(
      currentState.country,
      currentState.scenarioId,
    );

    // 3. Find event definition
    final eventDef = eventPool.where((e) => e.event.id == eventId).firstOrNull;
    if (eventDef == null) {
      return Left(Failure('Event not found'));
    }

    // 4. Find option
    final option = eventDef.event.options.where((o) => o.id == optionId).firstOrNull;
    if (option == null) {
      return Left(Failure('Option not found'));
    }

    final effect = option.effect;

    // 5. Calculate total cash impact using shared formula
    final cashBreakdown = effect.calculateCashBreakdown(currentState.baseSalary, currentState.totalMonthlyOutflow);

    // 6. Apply all effects
    final newCash = currentState.cash + cashBreakdown.totalCash;
    final newStress = (currentState.stress + effect.stress).clamp(0, 100).toInt();
    final newCreditScore = (currentState.creditScore + effect.credit).clamp(300, 850).toInt();
    final newNetworkScore = max(0, currentState.networkScore + effect.network);

    final newAssets = [...currentState.assets, ...effect.addedAssets];
    final newLoans = [...currentState.loans, ...effect.addedLoans];

    final newFlags = {...currentState.flags}
      ..addAll(effect.addedFlags)
      ..removeAll(effect.removedFlags);

    final newInsightCards = {...currentState.unlockedInsightCardIds};
    if (effect.insightCardId != null) {
      newInsightCards.add(effect.insightCardId!);
    }

    final newBaseSalary = currentState.baseSalary + effect.salaryDelta;
    final newMonthlyExpenses = currentState.monthlyExpenses + effect.monthlyExpensesDelta;

    final updatedState = currentState.copyWith(
      cash: newCash,
      stress: newStress,
      creditScore: newCreditScore,
      networkScore: newNetworkScore,
      assets: newAssets,
      loans: newLoans,
      flags: newFlags,
      unlockedInsightCardIds: newInsightCards,
      baseSalary: newBaseSalary,
      monthlyExpenses: newMonthlyExpenses,
      currentEventId: null, // Clear the active event
    );

    // 7. Check game status immediately
    return Right(_checkGameStatusUseCase(updatedState));
  }
}
