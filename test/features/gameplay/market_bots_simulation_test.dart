import 'package:flutter/foundation.dart';

import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_scenario_config_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/factories/game_state_factory.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/sell_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/spend_on_leisure_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/work_side_job_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/pay_debt_usecase.dart';

/// Quantitative design-acceptance bots for the market slice (spec_6_2a_market.md §5,
/// gates revised 22/07/2026 after a 20-seed sweep — see design_core_loop_v2.md §6):
/// 1. Blind DCA must still WIN all seeds (the real-life lesson stays intact).
/// 2. Disciplined (reserve + dip-buying + cost-based land cycling) must never
///    be punished: average ≤ 1.0× DCA months and no seed worse than 1.05×.
///    (A ≥20% speedup proved structurally impossible under a passive-income
///    win target — time-in-market dominates timing. Re-measure at Slice 3
///    when leverage/bank interest exist.)
/// 3. FOMO (buys booms, panic-sells crashes) must average ≥1.4× slower than
///    DCA and must NOT die mid-life (deaths are reserved for stacked
///    mistakes with leverage, per the design decision "thua hiếm").

const stressToCashWeight = 500000.0;
const maxMonths = 520;
const seeds = [42, 7, 2026];

double calculateOptionScore(EventOption option, GameState state) {
  final effect = option.effect;
  final cashScore = effect.cash +
      (effect.cashBySalaryMultiplier * state.baseSalary) +
      (effect.cashByOutflowMultiplier * state.totalMonthlyOutflow);

  double longTermPenalty = 0;
  for (var loan in effect.addedLoans) {
    longTermPenalty += loan.minimumMonthlyPayment * 24;
  }
  longTermPenalty += (effect.monthlyExpensesDelta * 24);
  longTermPenalty -= (effect.salaryDelta * 24);

  return cashScore - longTermPenalty - (effect.stress * stressToCashWeight);
}

enum BotKind { blindDca, disciplined, fomo }

class BotResult {
  final BotKind kind;
  final int seed;
  final bool won;
  final GameOverReason? lostReason;
  final int monthsPlayed;
  final double finalNetWorth;

  BotResult(this.kind, this.seed, this.won, this.lostReason, this.monthsPlayed, this.finalNetWorth);

  /// Months-to-win metric; a run that never wins scores the cap.
  int get score => won ? monthsPlayed : maxMonths;

  @override
  String toString() =>
      '${kind.name} seed=$seed won=$won lost=${lostReason?.name ?? '-'} months=$monthsPlayed nw=${finalNetWorth.toStringAsFixed(0)}';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<BotResult> runBot(BotKind kind, int seed) async {
    final eventPoolRepository = JsonEventPoolRepository();
    final configRepository = JsonScenarioConfigRepository();

    final random = Random(seed);
    final updateMarketUseCase = UpdateMarketUseCase(random);
    final generateEventUseCase = GenerateEventUseCase(eventPoolRepository, random);
    final checkGameStatusUseCase = CheckGameStatusUseCase();

    final processNextMonthUseCase = ProcessNextMonthUseCase(
      CalculateCashflowUseCase(),
      ProcessLoansUseCase(),
      updateMarketUseCase,
      UpdateMetricsUseCase(),
      generateEventUseCase,
      checkGameStatusUseCase,
      CheckBehavioralInsightsUseCase(),
    );
    final applyEventOptionUseCase = ApplyEventOptionUseCase(eventPoolRepository, checkGameStatusUseCase);
    final buyMarket = BuyMarketAssetUseCase(checkGameStatusUseCase);
    final sellMarket = SellMarketAssetUseCase(checkGameStatusUseCase);
    final workSideJob = WorkSideJobUseCase(checkGameStatusUseCase);
    final payDebt = PayDebtUseCase(checkGameStatusUseCase);
    final leisure = SpendOnLeisureUseCase(checkGameStatusUseCase);

    final config = await configRepository.loadScenarioConfig(Country.vietnam, 'vn_provincial');
    GameState state = GameStateFactory.fromConfig(config);

    int monthsPlayed = 0;
    bool won = false;
    GameOverReason? lostReason;

    void applyTurn(TurnResult r) {
      state = r.state;
      if (r is TurnWon) won = true;
      if (r is TurnLost) lostReason = r.reason;
    }

    // Helpers return true if the game ended.
    bool buy(String classId, double amount) {
      if (amount < 1000) return false; // ignore dust
      final result = buyMarket(state, classId, amount);
      result.fold((l) => fail('buy failed: ${l.message}'), applyTurn);
      return won || lostReason != null;
    }

    bool sell(String classId, double amount) {
      if (amount < 1000) return false;
      final result = sellMarket(state, classId, amount);
      result.fold((l) => fail('sell failed: ${l.message}'), applyTurn);
      return won || lostReason != null;
    }

    double holdingValue(String classId) {
      final holding = state.assets.where((a) => a.marketClassId == classId).firstOrNull;
      return holding == null ? 0.0 : state.assetMarketValue(holding);
    }

    while (monthsPlayed < maxMonths && !won && lostReason == null) {
      final outflow = state.totalMonthlyOutflow;

      // --- Survival valves (identical for every bot) ---
      // Forced selling when cash < 0: index first, then land — at CURRENT price.
      for (final classId in ['index_fund', 'land']) {
        while (state.cash < 0 && holdingValue(classId) > 1000) {
          final needed = -state.cash / (1 - state.assetSellFeeRate) + 1;
          if (sell(classId, needed)) break;
        }
        if (won || lostReason != null) break;
      }
      if (won || lostReason != null) break;

      // Side job valve.
      while (state.cash < outflow && state.stress <= 60 &&
          state.sideJobsWorkedThisMonth < state.maxSideJobsPerMonth) {
        final result = workSideJob(state);
        result.fold((l) => fail('side job failed: ${l.message}'), applyTurn);
        if (won || lostReason != null) break;
      }
      if (won || lostReason != null) break;

      // Leisure valve: relieve stress whenever one month of outflow stays
      // covered after paying (a fixed 3-month gate starved the disciplined
      // bot, which deliberately deploys its reserve during crashes).
      if (state.stress > 60) {
        final target = state.stress - 40;
        final maxLeft = state.maxLeisureStressReliefPerMonth - state.leisureReliefUsedThisMonth;
        final points = target > maxLeft ? maxLeft : target;
        if (points > 0) {
          final cost = points * state.leisureCostPerStressPoint;
          if (state.cash - cost >= outflow) {
            final result = leisure(state, cost.toDouble());
            if (result.isRight()) applyTurn(result.getRight().toNullable()!);
          }
        }
      }
      if (won || lostReason != null) break;

      // Debt repayment (same rule as the historical smart bot).
      if (state.cash > state.monthlyExpenses * 2 && state.loans.isNotEmpty) {
        final badLoans = state.loans.where((l) => l.interestRatePerYear > 0).toList()
          ..sort((a, b) => b.interestRatePerYear.compareTo(a.interestRatePerYear));
        if (badLoans.isNotEmpty) {
          final target = badLoans.first;
          final amount = (state.cash * 0.3).clamp(0.0, target.principalAmount).toDouble();
          if (amount > 0) {
            final result = payDebt(state, target.id, amount);
            result.fold((l) => fail('pay debt failed: ${l.message}'), applyTurn);
          }
        }
      }
      if (won || lostReason != null) break;

      // --- Strategy-specific investing ---
      final market = state.market;
      final land = market['land']!;
      final index = market['index_fund']!;

      switch (kind) {
        case BotKind.blindDca:
          // Invests the surplus above a 3-month reserve into the index fund,
          // every month, regardless of price. The baseline lesson.
          final invest = state.cash - outflow * 3;
          if (invest > 0 && buy('index_fund', invest)) break;

        case BotKind.disciplined:
          // The skill being rewarded: REBALANCING with emotional discipline.
          // 1. Take profit when a class runs hot vs its trailing average.
          // 2. Hoard the proceeds instead of chasing the boom.
          // 3. Redeploy when prices come back to/below trend (mean reversion
          //    guarantees the wait is finite) — each round trip compounds
          //    units, i.e. permanent passive income.
          // Lessons encoded here (validated by earlier tuning rounds):
          // - TIME IN MARKET beats timing: hoarding cash to wait for cheap
          //   index prices loses to buying early — so the index side is plain
          //   DCA, never sold, with extra reserves deployed only into DEEP
          //   discounts.
          // - The real skill lever is the land cycle measured against COST
          //   BASIS: buy far below trend (mean reversion guarantees recovery
          //   pressure), bank the gain at +40%, recycle into index units
          //   immediately. Cost-based selling profits even on seeds whose
          //   land price never returns to trend.
          final landHolding =
              state.assets.where((a) => a.marketClassId == 'land').firstOrNull;

          // 1. Bank land profits: +40% over cost -> sell half, buy index NOW.
          if (landHolding != null && landHolding.baseValue > 0) {
            final gain = holdingValue('land') / landHolding.baseValue;
            if (gain >= 1.40) {
              final half = holdingValue('land') * 0.5;
              if (sell('land', half)) break;
              if (buy('index_fund', half * (1 - state.assetSellFeeRate))) break;
            }
          }

          // 2. Deep index discount: deploy down to a 1-month reserve.
          if (index.price <= index.trendPrice * 0.85) {
            final invest = state.cash - outflow * 1;
            if (invest > 0 && buy('index_fund', invest)) break;
          }

          // 3. Land fire sale (<=70% of trend): buy with up to the surplus
          //    above 2 months outflow, capped at 40% of the total portfolio.
          if (land.price <= land.trendPrice * 0.70) {
            final portfolio = holdingValue('index_fund') + holdingValue('land');
            final cap = portfolio * 0.4 - holdingValue('land');
            final invest = min(state.cash - outflow * 2, cap);
            if (invest > 0 && buy('land', invest)) break;
          }

          // 4. Normal times: plain DCA into the index, 3-month reserve.
          final invest = state.cash - outflow * 3;
          if (invest > 0 && buy('index_fund', invest)) break;

        case BotKind.fomo:
          // Panic-sell everything in a class once it is 20% off its peak.
          var ended = false;
          for (final cls in [land, index]) {
            if (cls.drawdown >= 0.20 && holdingValue(cls.classId) > 1000) {
              if (sell(cls.classId, holdingValue(cls.classId) + 1)) { ended = true; break; }
            }
          }
          if (ended) break;
          // Only buys what is already hot (>=25% above trailing average),
          // and then goes nearly all-in (keeps just 1 month of outflow).
          final hot = [land, index].where((c) => c.trailingRatio >= 1.25).toList()
            ..sort((a, b) => b.trailingRatio.compareTo(a.trailingRatio));
          if (hot.isNotEmpty) {
            final invest = state.cash - outflow * 1;
            if (invest > 0 && buy(hot.first.classId, invest)) break;
          }
          // Otherwise hoards cash and waits for the next mania.
      }
      if (won || lostReason != null) break;

      // --- Event handling: greedy option scoring (same as historical bot) ---
      if (state.currentEventId != null) {
        final events = await eventPoolRepository.loadEventPool(state.country, state.scenarioId);
        final eventDef = events.firstWhere((e) => e.event.id == state.currentEventId);
        EventOption bestOption = eventDef.event.options.first;
        double bestScore = -double.infinity;
        for (final option in eventDef.event.options) {
          final score = calculateOptionScore(option, state);
          if (score > bestScore) {
            bestScore = score;
            bestOption = option;
          }
        }
        final result = await applyEventOptionUseCase(state, state.currentEventId!, bestOption.id);
        result.fold((l) => fail('apply option failed: ${l.message}'), applyTurn);
      }
      if (won || lostReason != null) break;

      // --- Next month ---
      final result = await processNextMonthUseCase(state);
      result.fold((l) => fail('next month failed: ${l.message}'), applyTurn);
      monthsPlayed++;
    }

    final r = BotResult(kind, seed, won, lostReason, monthsPlayed, state.netWorth);
    final idx = state.assets.where((a) => a.marketClassId == 'index_fund').firstOrNull;
    final avgBuy = (idx == null || idx.units <= 0) ? 0.0 : idx.baseValue / idx.units;
    debugPrint('[MarketBot] $r | passive=${state.passiveIncome.toStringAsFixed(0)}'
        ' outflow=${state.totalMonthlyOutflow.toStringAsFixed(0)}'
        ' avgBuyIdx=${avgBuy.toStringAsFixed(3)}'
        ' idxPrice=${state.market['index_fund']?.price.toStringAsFixed(3)}'
        ' landPrice=${state.market['land']?.price.toStringAsFixed(3)}');
    return r;
  }

  group('Market bots — quantitative design acceptance', () {
    test('Bot DCA mù vẫn THẮNG cả 3 seed (bài học DCA giữ nguyên)', () async {
      for (final seed in seeds) {
        final r = await runBot(BotKind.blindDca, seed);
        expect(r.won, isTrue, reason: 'Blind DCA must still win (seed $seed): $r');
      }
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('Bot Kỷ Luật không bao giờ bị phạt: avg ≤ 1.0×DCA, mọi seed ≤ 1.05×', () async {
      var dcaTotal = 0, discTotal = 0;
      for (final seed in seeds) {
        final dca = await runBot(BotKind.blindDca, seed);
        final disc = await runBot(BotKind.disciplined, seed);
        expect(disc.won, isTrue, reason: 'Disciplined must win (seed $seed): $disc');
        final perSeed = disc.score / dca.score;
        expect(perSeed, lessThanOrEqualTo(1.05),
            reason: 'Discipline must never be punished on any seed (seed $seed): '
                'ratio=${perSeed.toStringAsFixed(3)}');
        dcaTotal += dca.score;
        discTotal += disc.score;
      }
      final ratio = discTotal / dcaTotal;
      debugPrint('[MarketBot] disciplined/dca month ratio = ${ratio.toStringAsFixed(3)} '
          '(disc=$discTotal, dca=$dcaTotal)');
      expect(ratio, lessThanOrEqualTo(1.0),
          reason: 'Disciplined bot must be at least as fast as blind DCA on average');
    }, timeout: const Timeout(Duration(minutes: 10)));

    test('SEED SWEEP 20 seeds — công cụ tune thủ công', () async {
      final rows = <String>[];
      var dcaWins = 0, discWins = 0, fomoWins = 0;
      var dcaTotal = 0, discTotal = 0, fomoTotal = 0;
      final discRatios = <double>[], fomoRatios = <double>[];
      final sweepSeeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 42, 99, 123, 500, 777, 1000, 2024, 2025, 2026, 31337];
      for (final seed in sweepSeeds) {
        final dca = await runBot(BotKind.blindDca, seed);
        final disc = await runBot(BotKind.disciplined, seed);
        final fomo = await runBot(BotKind.fomo, seed);
        if (dca.won) dcaWins++;
        if (disc.won) discWins++;
        if (fomo.won) fomoWins++;
        dcaTotal += dca.score;
        discTotal += disc.score;
        fomoTotal += fomo.score;
        discRatios.add(disc.score / dca.score);
        fomoRatios.add(fomo.score / dca.score);
        rows.add('seed=$seed dca=${dca.score}${dca.won ? '' : 'X'} '
            'disc=${disc.score}${disc.won ? '' : 'X'} (${(disc.score / dca.score).toStringAsFixed(2)}) '
            'fomo=${fomo.score}${fomo.won ? '' : 'X'} (${(fomo.score / dca.score).toStringAsFixed(2)})');
      }
      discRatios.sort();
      fomoRatios.sort();
      debugPrint('===== SEED SWEEP =====');
      rows.forEach(debugPrint);
      debugPrint('wins: dca=$dcaWins/${sweepSeeds.length} disc=$discWins fomo=$fomoWins');
      debugPrint('avg ratio disc/dca=${(discTotal / dcaTotal).toStringAsFixed(3)} '
          'median=${discRatios[discRatios.length ~/ 2].toStringAsFixed(3)} '
          'min=${discRatios.first.toStringAsFixed(3)} max=${discRatios.last.toStringAsFixed(3)}');
      debugPrint('avg ratio fomo/dca=${(fomoTotal / dcaTotal).toStringAsFixed(3)} '
          'median=${fomoRatios[fomoRatios.length ~/ 2].toStringAsFixed(3)} '
          'min=${fomoRatios.first.toStringAsFixed(3)} max=${fomoRatios.last.toStringAsFixed(3)}');
    }, skip: 'Công cụ tune thủ công — chạy bằng --run-skipped', timeout: const Timeout(Duration(minutes: 20)));

    test('Bot FOMO chậm hơn DCA mù ≥ 15% và không chết giữa đời', () async {
      var dcaTotal = 0, fomoTotal = 0;
      for (final seed in seeds) {
        final dca = await runBot(BotKind.blindDca, seed);
        final fomo = await runBot(BotKind.fomo, seed);
        expect(
          fomo.lostReason,
          isNot(isIn([GameOverReason.burnout, GameOverReason.bankruptcy, GameOverReason.debtSpiral])),
          reason: 'FOMO alone (no leverage) must not die mid-life (seed $seed): $fomo',
        );
        dcaTotal += dca.score;
        fomoTotal += fomo.score;
      }
      final ratio = fomoTotal / dcaTotal;
      debugPrint('[MarketBot] fomo/dca month ratio = ${ratio.toStringAsFixed(3)} '
          '(fomo=$fomoTotal, dca=$dcaTotal)');
      expect(ratio, greaterThanOrEqualTo(1.4),
          reason: 'FOMO bot must be ≥40% slower than blind DCA — emotion is the '
              'expensive mistake this game punishes');
    }, timeout: const Timeout(Duration(minutes: 10)));
  });
}
