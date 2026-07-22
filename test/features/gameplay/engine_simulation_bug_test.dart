import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/json_event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/data/repositories/hive_game_state_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/spend_on_leisure_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/factories/game_state_factory.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/scenario_config_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:mocktail/mocktail.dart';

import 'dart:math';
import 'package:rat_race_escape/features/gameplay/domain/usecases/calculate_cashflow_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_loans_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/update_metrics_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/generate_event_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_game_status_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/check_behavioral_insights_usecase.dart';
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
    final updateMetricsUseCase = UpdateMetricsUseCase();
    final generateEventUseCase = GenerateEventUseCase(eventPoolRepo, Random(42));
    final checkGameStatusUseCase = CheckGameStatusUseCase();
    final checkBehavioralInsightsUseCase = CheckBehavioralInsightsUseCase();

    final processNextMonthUseCase = ProcessNextMonthUseCase(
      calculateCashflowUseCase,
      processLoansUseCase,
      updateMetricsUseCase,
      generateEventUseCase,
      checkGameStatusUseCase,
      checkBehavioralInsightsUseCase,
    );
    
    final applyEventOptionUseCase = ApplyEventOptionUseCase(
      eventPoolRepo,
      checkGameStatusUseCase,
    );
    
    final spendOnLeisureUseCase = SpendOnLeisureUseCase(checkGameStatusUseCase);

    final cubit = GameEngineCubit(
      processNextMonthUseCase,
      applyEventOptionUseCase,
      spendOnLeisureUseCase,
      mockGameStateRepo,
      mockScenarioConfigRepo,
      eventPoolRepo,
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
