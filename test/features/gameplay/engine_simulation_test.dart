import 'package:flutter/foundation.dart';

import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_scenario_config_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/spend_on_leisure_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_behavioral_insights_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:rat_race_escape/features/gameplay/domain/factories/game_state_factory.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';

const stressToCashWeight = 500000.0;

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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late JsonEventPoolRepository eventPoolRepository;
  late JsonScenarioConfigRepository configRepository;
  
  late CalculateCashflowUseCase calculateCashflowUseCase;
  late ProcessLoansUseCase processLoansUseCase;
  late UpdateMetricsUseCase updateMetricsUseCase;
  late GenerateEventUseCase generateEventUseCase;
  late CheckGameStatusUseCase checkGameStatusUseCase;
  late ProcessNextMonthUseCase processNextMonthUseCase;
  late ApplyEventOptionUseCase applyEventOptionUseCase;

  void setUpDependencies(int randomSeed) {
    eventPoolRepository = JsonEventPoolRepository();
    configRepository = JsonScenarioConfigRepository();
    
    calculateCashflowUseCase = CalculateCashflowUseCase();
    processLoansUseCase = ProcessLoansUseCase();
    updateMetricsUseCase = UpdateMetricsUseCase();
    
    final random = Random(randomSeed);
    generateEventUseCase = GenerateEventUseCase(eventPoolRepository, random);
    
    checkGameStatusUseCase = CheckGameStatusUseCase();
    final checkBehavioralInsightsUseCase = CheckBehavioralInsightsUseCase();
    
    processNextMonthUseCase = ProcessNextMonthUseCase(
      calculateCashflowUseCase,
      processLoansUseCase,
      updateMetricsUseCase,
      generateEventUseCase,
      checkGameStatusUseCase,
      checkBehavioralInsightsUseCase,
    );
    
    applyEventOptionUseCase = ApplyEventOptionUseCase(
      eventPoolRepository,
      checkGameStatusUseCase,
    );

    if (!GetIt.instance.isRegistered<SpendOnLeisureUseCase>()) {
      GetIt.instance.registerSingleton<SpendOnLeisureUseCase>(SpendOnLeisureUseCase(checkGameStatusUseCase));
    }
  }

  setUpAll(() {
    setUpDependencies(42);
  });

  double calculateNetWorth(GameState state) {
    final totalAssets = state.assets.fold<double>(0, (sum, a) => sum + a.baseValue);
    final totalLoans = state.loans.fold<double>(0, (sum, l) => sum + l.principalAmount);
    return state.cash + totalAssets - totalLoans;
  }

  void assertInvariants(GameState state, GameState prevState) {
    expect(state.stress, inInclusiveRange(0, 100), reason: 'Stress invariant violated');
    expect(state.creditScore, inInclusiveRange(300, 850), reason: 'Credit score invariant violated');
    expect(state.ageInMonths, prevState.ageInMonths + 1, reason: 'Age should increment by 1 each month');
    expect((calculateNetWorth(state) - state.netWorth).abs(), lessThan(0.01), reason: 'Net worth calculation mismatch');
  }

  GameState simulatePhase3Action(GameState currentState, GameState Function(GameState) action) {
    final netWorthBefore = calculateNetWorth(currentState);
    
    final newState = action(currentState);
    
    // TODO(task-6): Replace this simulation with real BuyAssetUseCase / PayDebtUseCase
    final netWorthAfter = calculateNetWorth(newState);
    
    // Net worth should be exactly the same after swapping cash for asset/debt
    expect((netWorthAfter - netWorthBefore).abs(), lessThan(0.01), reason: 'Net worth invariant violated during asset/debt swap');
    
    return newState;
  }

  group('Simulation Tests', () {
    test('Bot 1: Do-Nothing Strategy', () async {
      setUpDependencies(42);
      final config = await configRepository.loadScenarioConfig(Country.vietnam, 'vn_provincial');
      GameState state = GameStateFactory.fromConfig(config);
      
      int monthsPlayed = 0;
      bool isGameOver = false;

      final List<int> logMonths = [12, 60, 120, 240, 516];

      while (monthsPlayed < 520 && !isGameOver) {
        // Phase 2/3: Handle events from previous month
        if (state.currentEventId != null) {
          // Always pick first option (index 0)
          final events = await eventPoolRepository.loadEventPool(state.country, state.scenarioId);
          final eventDef = events.firstWhere((e) => e.event.id == state.currentEventId);
          final option = eventDef.event.options.first;
          
          final eventResult = await applyEventOptionUseCase(state, state.currentEventId!, option.id);
          eventResult.fold(
            (l) => fail('Failed to apply option: ${l.message}'),
            (r) {
              if (r is TurnLost) {
                isGameOver = true;
                state = r.state;
                debugPrint('Game Over Reason in Event: ${r.reason}');
              } else if (r is TurnWon) {
                fail('Do-Nothing bot should never win');
              } else {
                state = r.state;
              }
            }
          );
        }

        if (isGameOver) break;

        // Phase 4: Next Month
        final prevState = state;
        final resultEither = await processNextMonthUseCase(state);
        
        resultEither.fold(
          (l) => fail('Next month process failed: ${l.message}'),
          (r) {
            state = r.state;
            if (r is TurnLost) {
              isGameOver = true;
              debugPrint('Game Over Reason in NextMonth: ${r.reason}');
            } else if (r is TurnWon) {
              fail('Do-Nothing bot should never win');
            }
          }
        );
        
        monthsPlayed++;
        assertInvariants(state, prevState);

        if (logMonths.contains(monthsPlayed)) {
          debugPrint('Do-Nothing Bot - Month $monthsPlayed (Age: ${state.ageInMonths ~/ 12} years): Net Worth = ${calculateNetWorth(state)}');
        }
      }

      debugPrint('Do-Nothing Bot Finished at Month $monthsPlayed (Age: ${state.ageInMonths ~/ 12} years)');
      debugPrint('Final Net Worth: ${state.netWorth}');

      // Assertions
      expect(isGameOver, isTrue, reason: 'Bot should have lost by burnout, bankruptcy, or poorAtRetirement');
    });

    Future<void> runSmartDcaBot(int seed, {bool assertWin = false}) async {
      setUpDependencies(seed);
      final config = await configRepository.loadScenarioConfig(Country.vietnam, 'vn_provincial');
      GameState state = GameStateFactory.fromConfig(config);
      
      int monthsPlayed = 0;
      bool isGameOver = false;
      bool isWon = false;

      while (monthsPlayed < 520 && !isGameOver && !isWon) {
        // Phase 3: Player Action (Repay debt + DCA)
        // 1. Pay Debt
        if (state.cash > state.monthlyExpenses * 2 && state.loans.isNotEmpty) {
          final badLoans = state.loans.where((l) => l.interestRatePerYear > 0).toList();
          if (badLoans.isNotEmpty) {
            badLoans.sort((a, b) => b.interestRatePerYear.compareTo(a.interestRatePerYear));
            final targetLoan = badLoans.first;
            
            final amountToPay = (state.cash * 0.3).clamp(0.0, targetLoan.principalAmount).toDouble();
            
            if (amountToPay > 0) {
              state = simulatePhase3Action(state, (s) {
                final updatedLoans = s.loans.map((l) {
                  if (l.id == targetLoan.id) {
                    return l.copyWith(principalAmount: l.principalAmount - amountToPay);
                  }
                  return l;
                }).where((l) => l.principalAmount > 0.01).toList();
                
                return s.copyWith(
                  cash: s.cash - amountToPay,
                  loans: updatedLoans,
                );
              });
            }
          }
        }

        // 2. Buy Asset (DCA)
          // Phase 2: Action Phase -> DCA Bot Action
          // Bot uses the leisure valve if stress > 60 and cash > emergency fund (3 months expenses)
          if (state.stress > 60 && state.cash > state.totalMonthlyOutflow * 3) {
            // Target stress = 40, so need to reduce (state.stress - 40)
            final stressToReduce = state.stress - 40;
            // Calculate cash needed:
            final maxPossibleReductionThisMonth = state.maxLeisureStressReliefPerMonth - state.leisureReliefUsedThisMonth;
            final actualReductionTarget = (stressToReduce > maxPossibleReductionThisMonth) 
                ? maxPossibleReductionThisMonth 
                : stressToReduce;
            
            if (actualReductionTarget > 0) {
              final cashNeeded = actualReductionTarget * state.leisureCostPerStressPoint;
              
              if (state.cash >= cashNeeded) {
                final leisureUseCase = GetIt.instance<SpendOnLeisureUseCase>();
                final leisureResult = leisureUseCase.call(state, cashNeeded.toDouble());
                if (leisureResult.isRight()) {
                  final nextTurn = leisureResult.getRight().toNullable()!;
                  state = nextTurn.state;
                }
              }
            }
          }

          // Continue to DCA
          double investAmount = state.cash - (state.totalMonthlyOutflow * 3);
          if (investAmount > 0) {
            state = simulatePhase3Action(state, (s) {
              // Assume buying an ETF with 8% annual return (0.66% monthly)
              final asset = Asset(
                id: 'etf_${s.currentMonth}',
                name: 'VFMVN Diamond ETF',
                baseValue: investAmount,
                type: AssetType.stock,
                monthlyPassiveIncome: investAmount * 0.08 / 12,
              );
              return s.copyWith(
                cash: s.cash - investAmount,
                assets: [...s.assets, asset],
              );
            });
          }

        // 3. Handle Events
        if (state.currentEventId != null) {
          final events = await eventPoolRepository.loadEventPool(state.country, state.scenarioId);
          final eventDef = events.firstWhere((e) => e.event.id == state.currentEventId);
          
          final options = eventDef.event.options;
          EventOption bestOption = options.first;
          double bestScore = -double.infinity;
          
          for (var option in options) {
            final score = calculateOptionScore(option, state);
            
            if (score > bestScore) {
              bestScore = score;
              bestOption = option;
            }
          }
          
          debugPrint('[Month $monthsPlayed] Event: ${state.currentEventId} -> Chose: ${bestOption.id}');
          
          final eventResult = await applyEventOptionUseCase(state, state.currentEventId!, bestOption.id);
          eventResult.fold(
            (l) => fail('Failed to apply option: ${l.message}'),
            (r) {
              if (r is TurnLost) {
                isGameOver = true;
                state = r.state;
                debugPrint('DCA Bot Game Over in Event! Reason: ${r.reason}');
              } else if (r is TurnWon) {
                isWon = true;
                state = r.state;
              } else {
                state = r.state;
              }
            }
          );
        }

        if (isGameOver || isWon) break;

        // Phase 4: Next Month
        final prevState = state;
        final resultEither = await processNextMonthUseCase(state);
        
        resultEither.fold(
          (l) => fail('Next month process failed: ${l.message}'),
          (r) {
            state = r.state;
            if (r is TurnLost) {
              isGameOver = true;
              debugPrint('DCA Bot Game Over in NextMonth! Reason: ${r.reason}');
            } else if (r is TurnWon) {
              isWon = true;
            }
          }
        );
        
        monthsPlayed++;
        assertInvariants(state, prevState);
      }

      debugPrint('DCA Bot Finished at Month $monthsPlayed (Age: ${state.ageInMonths ~/ 12} years)');
      debugPrint('Final Net Worth: ${calculateNetWorth(state)}');
      debugPrint('Final Credit Score: ${state.creditScore}');
      
      if (isGameOver) {
        debugPrint('Final Loans:');
        for (var loan in state.loans) {
          debugPrint('- ${loan.name}: Principal = ${loan.principalAmount}, Min Payment = ${loan.minimumMonthlyPayment}');
        }
        debugPrint('Final Monthly Expenses: ${state.monthlyExpenses}');
      }
      
      if (assertWin) {
        expect(isWon, isTrue, reason: 'DCA Bot should win the game before retirement with seed $seed');
      }
    }

    test('Bot 2: Smart DCA + Debt Repayment Strategy (Seed 42)', () async {
      await runSmartDcaBot(42, assertWin: true);
    });

    test('Bot 2: Smart DCA + Debt Repayment Strategy (Seed 7)', () async {
      await runSmartDcaBot(7, assertWin: false);
    });

    test('Bot 2: Smart DCA + Debt Repayment Strategy (Seed 2026)', () async {
      await runSmartDcaBot(2026, assertWin: false);
    });

    test('calculateOptionScore evaluates e_buy_used_car options correctly', () async {
      setUpDependencies(42);
      final config = await configRepository.loadScenarioConfig(Country.vietnam, 'vn_provincial');
      GameState state = GameStateFactory.fromConfig(config);
      
      final events = await eventPoolRepository.loadEventPool(Country.vietnam, 'vn_provincial');
      final carEvent = events.firstWhere((e) => e.event.id == 'e_buy_used_car').event;
      
      final opt1 = carEvent.options.firstWhere((o) => o.id == 'buc_opt1'); // Buy used car
      final opt2 = carEvent.options.firstWhere((o) => o.id == 'buc_opt2'); // Buy new car with loan
      final opt3 = carEvent.options.firstWhere((o) => o.id == 'buc_opt3'); // Decline

      final score1 = calculateOptionScore(opt1, state);
      final score2 = calculateOptionScore(opt2, state);
      final score3 = calculateOptionScore(opt3, state);
      
      debugPrint('Score buc_opt1: $score1');
      debugPrint('Score buc_opt2: $score2');
      debugPrint('Score buc_opt3: $score3');

      expect(score2, lessThan(score1), reason: 'Buying new car on loan should be worse than buying used car outright');
      expect(score2, lessThan(score3), reason: 'Buying new car on loan should be worse than declining');
    });

    test('Manual Financial Calculation Verification: Compound Interest on Loan', () {
      final loan = const Loan(
        id: 'test_loan',
        name: 'Test Loan',
        principalAmount: 100000000,
        interestRatePerYear: 12.0,
        minimumMonthlyPayment: 2000000,
      );
      GameState state = GameState(
        scenarioId: 'test',
        country: Country.vietnam,
        currency: Currency.vnd,
        cash: 100000000, // Enough to cover min payment
        monthlyExpenses: 0,
        monthlyRent: 0,
        baseSalary: 0,
        loans: [loan],
      );

      final processLoansUseCase = ProcessLoansUseCase();
      for (int i = 0; i < 12; i++) {
        state = processLoansUseCase(state);
      }

      final updatedLoan = state.loans.first;
      expect(updatedLoan.principalAmount.round(), 87317497, reason: 'Compound interest calculation failed');
    });
  });
}
