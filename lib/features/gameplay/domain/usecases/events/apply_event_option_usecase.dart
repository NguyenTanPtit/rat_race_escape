import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_effect.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/market_class_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/sell_market_asset_usecase.dart';

@lazySingleton
class ApplyEventOptionUseCase {
  final EventPoolRepository _eventPoolRepository;
  final CheckGameStatusUseCase _checkGameStatusUseCase;
  final BuyMarketAssetUseCase _buyMarketAsset;
  final SellMarketAssetUseCase _sellMarketAsset;
  final Random _random;

  ApplyEventOptionUseCase(
    this._eventPoolRepository,
    this._checkGameStatusUseCase,
    this._buyMarketAsset,
    this._sellMarketAsset,
    this._random,
  );

  /// Ignores market ops that cannot apply (no holding, cash below dust) —
  /// events must never hard-fail on them. Every skip leaves a debugPrint.
  static const double _dustCash = 1000000; // 1tr ₫

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

    // 5. Calculate total cash impact using shared formula (insurance-aware)
    final cashBreakdown = effect.calculateCashBreakdown(
      currentState.baseSalary,
      currentState.totalMonthlyOutflow,
      insured: currentState.hasHealthInsurance,
    );

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

    var updatedState = currentState.copyWith(
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
      salarySuspendedMonths:
          max(currentState.salarySuspendedMonths, effect.salarySuspendedMonths),
      currentEventId: null, // Clear the active event
    );

    // 7. Market-coupled effects — ALWAYS through the shared market usecases
    //    (one formula, one source for units/fees). Skips are silent-but-logged.
    updatedState = _applyMarketEffects(updatedState, effect);

    // 8. Check game status immediately
    return Right(_checkGameStatusUseCase(updatedState));
  }

  GameState _applyMarketEffects(GameState state, EventEffect effect) {
    var current = state;

    // Panic sell: everything in the listed classes, at market price + fee.
    for (final classId in effect.marketSellAllClassIds) {
      final holding = current.assets.where((a) => a.marketClassId == classId).firstOrNull;
      if (holding == null) {
        debugPrint('[ApplyEventOption] marketSellAll skipped: no holding for $classId');
        continue;
      }
      final value = current.assetMarketValue(holding);
      _sellMarketAsset(current, classId, value + 1).fold(
        (l) => debugPrint('[ApplyEventOption] marketSellAll swallowed: ${l.message}'),
        (r) => current = r.state,
      );
    }

    // FOMO buy: a fraction of current cash into a class.
    final buyFraction = effect.marketBuyCashFraction;
    if (buyFraction != null) {
      final amount = current.cash * buyFraction.fraction;
      if (amount < _dustCash) {
        debugPrint('[ApplyEventOption] marketBuyCashFraction skipped: amount below dust');
      } else {
        _buyMarketAsset(current, buyFraction.classId, amount).fold(
          (l) => debugPrint('[ApplyEventOption] marketBuyCashFraction swallowed: ${l.message}'),
          (r) => current = r.state,
        );
      }
    }

    // Flash sale: fixed amount at a discounted price, clamped to cash.
    final buyDiscount = effect.marketBuyDiscount;
    if (buyDiscount != null) {
      if (current.cash < _dustCash) {
        debugPrint('[ApplyEventOption] marketBuyDiscount skipped: cash below dust');
      } else {
        final amount = min(buyDiscount.amount, current.cash);
        final cls = current.market[buyDiscount.classId];
        if (cls == null) {
          debugPrint('[ApplyEventOption] marketBuyDiscount skipped: unknown class');
        } else {
          final discountedPrice = cls.price * (1 - buyDiscount.discount);
          _buyMarketAsset(current, buyDiscount.classId, amount, priceOverride: discountedPrice)
              .fold(
            (l) => debugPrint('[ApplyEventOption] marketBuyDiscount swallowed: ${l.message}'),
            (r) => current = r.state,
          );
        }
      }
    }

    // Systemic shock: force the listed classes into a crash regime.
    final forceCrash = effect.forceMarketCrash;
    if (forceCrash != null) {
      final updatedMarket = {...current.market};
      for (final classId in forceCrash.classIds) {
        final cls = updatedMarket[classId];
        if (cls == null) {
          debugPrint('[ApplyEventOption] forceMarketCrash skipped: unknown class $classId');
          continue;
        }
        final months = forceCrash.minMonths +
            _random.nextInt(forceCrash.maxMonths - forceCrash.minMonths + 1);
        updatedMarket[classId] = cls.copyWith(
          regime: MarketRegime.crash,
          regimeMonthsLeft: months,
        );
      }
      current = current.copyWith(market: updatedMarket);
    }

    return current;
  }
}
