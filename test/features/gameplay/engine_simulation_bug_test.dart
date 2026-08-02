import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/apply_inflation_usecase.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/hive_game_state_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/spend_on_leisure_usecase.dart';
import 'package:flutter/services.dart';
import 'package:mocktail/mocktail.dart';

import 'dart:math';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/update_market_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/events/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/buy_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/market/sell_market_asset_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/toggle_health_insurance_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/bank/manage_savings_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/bank/take_bank_loan_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/actions/pay_debt_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/engine/check_behavioral_insights_usecase.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_scenario_config_repository.dart';

class MockHiveGameStateRepository extends Mock implements HiveGameStateRepository {}
class FakeGameState extends Fake implements GameState {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUpAll(() {
    registerFallbackValue(FakeGameState());
  });

  test('simulate 4 years auto advance', () async {
    final mockScenarioConfigRepo = JsonScenarioConfigRepository();

    final mockGameStateRepo = MockHiveGameStateRepository();
    when(() => mockGameStateRepo.loadGame()).thenAnswer((_) async => null);
    when(() => mockGameStateRepo.saveGame(any())).thenAnswer((_) async {});
    when(() => mockGameStateRepo.deleteSave()).thenAnswer((_) async {});

    final eventPoolRepo = JsonEventPoolRepository();
    
    final calculateCashflowUseCase = CalculateCashflowUseCase();
    final processLoansUseCase = ProcessLoansUseCase();
    final random = Random(42);
    final updateMarketUseCase = UpdateMarketUseCase(random);
    final updateMetricsUseCase = UpdateMetricsUseCase();
    final generateEventUseCase = GenerateEventUseCase(eventPoolRepo, random);
    final checkGameStatusUseCase = CheckGameStatusUseCase();
    final checkBehavioralInsightsUseCase = CheckBehavioralInsightsUseCase();

    final processNextMonthUseCase = ProcessNextMonthUseCase(
      calculateCashflowUseCase,
      processLoansUseCase,
      updateMarketUseCase,
      updateMetricsUseCase,
      generateEventUseCase,
      checkGameStatusUseCase,
      checkBehavioralInsightsUseCase,
      ApplyInflationUseCase(),
    );
    
    final buyMarketUseCase = BuyMarketAssetUseCase(checkGameStatusUseCase);
    final sellMarketUseCase = SellMarketAssetUseCase(checkGameStatusUseCase);
    final applyEventOptionUseCase = ApplyEventOptionUseCase(
      eventPoolRepo,
      checkGameStatusUseCase,
      buyMarketUseCase,
      sellMarketUseCase,
      random,
    );
    
    final spendOnLeisureUseCase = SpendOnLeisureUseCase(checkGameStatusUseCase);

    final cubit = GameEngineCubit(
      processNextMonthUseCase,
      applyEventOptionUseCase,
      spendOnLeisureUseCase,
      mockGameStateRepo,
      mockScenarioConfigRepo,
      eventPoolRepo,
      buyMarketUseCase,
      sellMarketUseCase,
      ToggleHealthInsuranceUseCase(checkGameStatusUseCase),
      DepositSavingsUseCase(checkGameStatusUseCase),
      WithdrawSavingsUseCase(checkGameStatusUseCase),
      TakeBankLoanUseCase(checkGameStatusUseCase),
      PayDebtUseCase(checkGameStatusUseCase),
    );

    // Bypassing root bundle for json loads in test environment
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      return '.';
    });

    await cubit.startNewGame(Country.vietnam, 'vn_provincial');

    // Wait for initial state to settle
    await Future.delayed(const Duration(milliseconds: 100));

    int years = 0;
    while (years < 20) {
      if (cubit.state is GameEngineGameOver || cubit.state is GameEngineWon) {
        break;
      }
      
      final state = cubit.state;
      if (state is GameEnginePlaying) {
        if (!state.isAutoAdvancing) {
          if (state.currentEvent != null) {
             await cubit.chooseEventOption(state.currentEvent!.id, state.currentEvent!.options.first.id);
          } else if (state.newlyUnlockedInsightCardIds.isNotEmpty) {
             cubit.clearNewlyUnlockedCards();
          } else {
             // either yearly recap or nothing, just call autoAdvance
             cubit.autoAdvance(tick: const Duration(milliseconds: 5));
          }
        }
      }
      await Future.delayed(const Duration(milliseconds: 50));
      
      if (cubit.state is GameEnginePlaying) {
         final currentMonth = (cubit.state as GameEnginePlaying).gameState.ageInMonths;
         if (currentMonth >= 240 + years * 12 + 12) {
            years++;
         }
      }
    }

    cubit.close();
  });
}
