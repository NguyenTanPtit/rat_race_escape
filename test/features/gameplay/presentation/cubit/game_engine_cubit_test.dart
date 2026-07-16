import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rat_race_escape/core/error/failure.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/apply_event_option_usecase.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_next_month_usecase.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/game_state_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/scenario_config_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/event_pool_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/event_definition.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';

import 'package:rat_race_escape/features/gameplay/domain/entities/scenario_config.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/spend_on_leisure_usecase.dart';

class MockProcessNextMonthUseCase implements ProcessNextMonthUseCase {
  Either<Failure, TurnResult> resultToReturn = Right(const TurnContinued(GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 0,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
  )));

  @override
  Future<Either<Failure, TurnResult>> call(GameState params) async {
    return resultToReturn;
  }
}

class MockApplyEventOptionUseCase implements ApplyEventOptionUseCase {
  Either<Failure, TurnResult> resultToReturn = Right(const TurnContinued(GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 0,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
  )));

  List<Either<Failure, TurnResult>>? resultsQueue;

  @override
  Future<Either<Failure, TurnResult>> call(GameState currentState, String eventId, String optionId) async {
    if (resultsQueue != null && resultsQueue!.isNotEmpty) {
      return resultsQueue!.removeAt(0);
    }
    return resultToReturn;
  }
}

class MockSpendOnLeisureUseCase implements SpendOnLeisureUseCase {
  Either<Failure, TurnResult> resultToReturn = Right(const TurnContinued(GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test',
    cash: 0,
    monthlyExpenses: 0,
    monthlyRent: 0,
    baseSalary: 0,
  )));

  @override
  Either<Failure, TurnResult> call(GameState state, double amount) {
    return resultToReturn;
  }
}

class MockGameStateRepository implements GameStateRepository {
  bool saveGameCalled = false;
  bool deleteSaveCalled = false;
  bool hasSavedGameCalled = false;
  bool loadGameCalled = false;
  GameState? savedState;
  
  GameState? stateToLoad;

  @override
  Future<void> saveGame(GameState state) async {
    saveGameCalled = true;
    savedState = state;
  }

  @override
  Future<GameState?> loadGame() async {
    loadGameCalled = true;
    return stateToLoad;
  }

  @override
  Future<bool> hasSavedGame() async {
    hasSavedGameCalled = true;
    return stateToLoad != null;
  }

  @override
  Future<void> deleteSave() async {
    deleteSaveCalled = true;
    savedState = null;
  }
}

class SlowMockProcessNextMonthUseCase implements ProcessNextMonthUseCase {
  int callCount = 0;
  @override
  Future<Either<Failure, TurnResult>> call(GameState params) async {
    callCount++;
    await Future.delayed(const Duration(milliseconds: 100));
    return Right(TurnContinued(params));
  }
}

class SlowMockApplyEventOptionUseCase implements ApplyEventOptionUseCase {
  int callCount = 0;
  @override
  Future<Either<Failure, TurnResult>> call(GameState currentState, String eventId, String optionId) async {
    callCount++;
    await Future.delayed(const Duration(milliseconds: 100));
    return Right(TurnContinued(currentState));
  }
}

class MockScenarioConfigRepository implements ScenarioConfigRepository {
  @override
  Future<ScenarioConfig> loadScenarioConfig(Country country, String scenarioId) async {
    return const ScenarioConfig(
      id: 'vn_provincial',
      initialCash: 10000000,
      monthlyExpenses: 5000000,
      monthlyRent: 3000000,
      baseSalary: 11000000,
      startAgeInMonths: 264,
      startCalendarMonth: 1,
      initialCreditScore: 600,
      housingLevel: HousingLevel.shabbyRoom,
      country: Country.vietnam,
      currency: 'VND',
      familySupportExpense: 0,
      maxLeisureStressReliefPerMonth: 20,
      leisureCostPerStressPoint: 100000,
      baseEventChance: 0.2,
      bankruptcyMonthsThreshold: 3,
    );
  }
}

class MockEventPoolRepository implements EventPoolRepository {
  List<EventDefinition> pool = [];
  
  @override
  Future<List<EventDefinition>> loadEventPool(Country country, String scenarioId, {String locale = 'vi'}) async {
    return pool;
  }
}

void main() {
  late GameEngineCubit cubit;
  late MockProcessNextMonthUseCase mockProcessNextMonthUseCase;
  late MockApplyEventOptionUseCase mockApplyEventOptionUseCase;
  late MockSpendOnLeisureUseCase mockSpendOnLeisureUseCase;
  late MockGameStateRepository mockGameStateRepository;
  late MockScenarioConfigRepository mockScenarioConfigRepository;
  late MockEventPoolRepository mockEventPoolRepository;

  setUp(() {
    mockProcessNextMonthUseCase = MockProcessNextMonthUseCase();
    mockApplyEventOptionUseCase = MockApplyEventOptionUseCase();
    mockSpendOnLeisureUseCase = MockSpendOnLeisureUseCase();
    mockGameStateRepository = MockGameStateRepository();
    mockScenarioConfigRepository = MockScenarioConfigRepository();
    mockEventPoolRepository = MockEventPoolRepository();
    cubit = GameEngineCubit(
      mockProcessNextMonthUseCase,
      mockApplyEventOptionUseCase,
      mockSpendOnLeisureUseCase,
      mockGameStateRepository,
      mockScenarioConfigRepository,
      mockEventPoolRepository,
    );
  });

  tearDown(() {
    cubit.close();
  });

  const baseState = GameState(
    country: Country.vietnam,
    currency: Currency.vnd,
    scenarioId: 'test_scenario',
    cash: 10000000,
    monthlyExpenses: 5000000,
    monthlyRent: 3000000,
    baseSalary: 15000000,
    stress: 20,
  );

  test('initial state should be GameEngineState.initial', () {
    expect(cubit.state, const GameEngineState.initial());
  });

  blocTest<GameEngineCubit, GameEngineState>(
    'startGame emits playing state and calls saveGame',
    build: () => cubit,
    act: (cubit) => cubit.startGame(baseState),
    expect: () => [
      const GameEngineState.playing(baseState),
    ],
    verify: (_) {
      expect(mockGameStateRepository.saveGameCalled, isTrue);
    },
  );

  blocTest<GameEngineCubit, GameEngineState>(
    'startNewGame loads scenario config, emits playing state with correct scenarioId and baseSalary, and calls saveGame',
    build: () => cubit,
    act: (cubit) => cubit.startNewGame(Country.vietnam, 'vn_provincial'),
    expect: () => [
      isA<GameEnginePlaying>()
          .having((s) => s.gameState.scenarioId, 'scenarioId', 'vn_provincial')
          .having((s) => s.gameState.baseSalary, 'baseSalary', 11000000),
    ],
    verify: (_) {
      expect(mockGameStateRepository.saveGameCalled, isTrue);
    },
  );

  blocTest<GameEngineCubit, GameEngineState>(
    'loadGame sets activeEvent in playing state if currentEventId is not null',
    build: () {
      mockGameStateRepository.stateToLoad = baseState.copyWith(currentEventId: 'event_1');
      mockEventPoolRepository.pool = [
        const EventDefinition(
          event: GameEvent(id: 'event_1', title: 'Test', description: 'Test desc', options: []),
          weight: 1,
          trigger: EventTrigger(),
        )
      ];
      return cubit;
    },
    act: (cubit) => cubit.loadGame(),
    expect: () => [
      isA<GameEnginePlaying>()
          .having((s) => s.gameState.currentEventId, 'currentEventId', 'event_1')
          .having((s) => s.currentEvent?.id, 'currentEvent.id', 'event_1'),
    ],
  );

  final changedState = baseState.copyWith(
    cash: 12000000,
    stress: 25,
  );
  
  final monthlySummary = const MonthlySummaryDelta(
    cashDelta: 2000000,
    stressDelta: 5,
    netWorthDelta: 2000000, // old baseState net worth is same as cash since assets = 0, loans = 0
  );

  group('nextMonth', () {
    blocTest<GameEngineCubit, GameEngineState>(
      'emits nothing if current state is not playing',
      build: () => cubit,
      act: (cubit) => cubit.nextMonth(),
      expect: () => [],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'guard: emits nothing and does not call usecase if currentEventId is not null',
      build: () => cubit,
      seed: () => GameEngineState.playing(baseState.copyWith(currentEventId: 'event_x')),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits playing state with monthlySummary when TurnContinued is returned, and calls saveGame',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnContinued(changedState));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineState.playing(changedState, {}, monthlySummary),
      ],
      verify: (_) {
        expect(mockGameStateRepository.saveGameCalled, isTrue);
      },
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits gameOver state when TurnLost is returned, and calls deleteSave',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnLost(
          changedState.copyWith(unlockedInsightCardIds: {'ic_new1'}), 
          GameOverReason.burnout, 
        ));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineGameOver(
          GameOverReason.burnout,
          changedState.copyWith(unlockedInsightCardIds: {'ic_new1'}), 
          {'ic_new1'}
        ),
      ],
      verify: (_) {
        expect(mockGameStateRepository.deleteSaveCalled, isTrue);
      },
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits won state when TurnWon is returned, and calls deleteSave',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnWon(
          changedState.copyWith(unlockedInsightCardIds: {'ic_new2'})
        ));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineWon(
          changedState.copyWith(unlockedInsightCardIds: {'ic_new2'}),
          {'ic_new2'}
        ),
      ],
      verify: (_) {
        expect(mockGameStateRepository.deleteSaveCalled, isTrue);
      },
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits error state when usecase fails',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Left(Failure('Simulation error'));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        const GameEngineState.error('Simulation error'),
      ],
    );

    test('ignores second nextMonth call if already processing (double-tap protection)', () async {
      final slowMock = SlowMockProcessNextMonthUseCase();
      final cubit2 = GameEngineCubit(
        slowMock,
        mockApplyEventOptionUseCase,
        mockSpendOnLeisureUseCase,
        mockGameStateRepository,
        mockScenarioConfigRepository,
        mockEventPoolRepository,
      );
      
      cubit2.startGame(baseState);
      
      // Call twice without waiting
      cubit2.nextMonth();
      cubit2.nextMonth();
      
      // Wait for it to finish
      await Future.delayed(const Duration(milliseconds: 200));
      
      // Should only be called once
      expect(slowMock.callCount, 1);
      cubit2.close();
    });
  });

  group('chooseEventOption & spendOnLeisure', () {
    test('ignores second chooseEventOption call if already processing (double-tap protection)', () async {
      final slowMock = SlowMockApplyEventOptionUseCase();
      final cubit2 = GameEngineCubit(
        mockProcessNextMonthUseCase,
        slowMock,
        mockSpendOnLeisureUseCase,
        mockGameStateRepository,
        mockScenarioConfigRepository,
        mockEventPoolRepository,
      );
      
      cubit2.startGame(baseState.copyWith(currentEventId: 'event_1'));
      
      // Call twice without waiting
      cubit2.chooseEventOption('event_1', 'opt1');
      cubit2.chooseEventOption('event_1', 'opt1');
      
      // Wait for it to finish
      await Future.delayed(const Duration(milliseconds: 200));
      
      // Should only be called once
      expect(slowMock.callCount, 1);
      cubit2.close();
    });

    blocTest<GameEngineCubit, GameEngineState>(
      'chooseEventOption emits nothing if not playing',
      build: () => cubit,
      act: (cubit) => cubit.chooseEventOption('event1', 'opt1'),
      expect: () => [],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'spendOnLeisure emits nothing if not playing',
      build: () => cubit,
      act: (cubit) => cubit.spendOnLeisure(500),
      expect: () => [],
    );
    blocTest<GameEngineCubit, GameEngineState>(
      'chooseEventOption emits playing state WITHOUT monthlySummary and calls saveGame',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnContinued(changedState));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [
        GameEngineState.playing(changedState), // NO monthly summary
      ],
      verify: (_) {
        expect(mockGameStateRepository.saveGameCalled, isTrue);
      },
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'spendOnLeisure emits playing state WITHOUT monthlySummary and calls saveGame',
      build: () {
        mockSpendOnLeisureUseCase.resultToReturn = Right(TurnContinued(changedState));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.spendOnLeisure(500000),
      expect: () => [
        GameEngineState.playing(changedState), // NO monthly summary
      ],
      verify: (_) {
        expect(mockGameStateRepository.saveGameCalled, isTrue);
      },
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'chooseEventOption emits gameOver state when TurnLost is returned immediately after applying option',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnLost(
          changedState, 
          GameOverReason.bankruptcy, 
        ));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [
        GameEngineGameOver(
          GameOverReason.bankruptcy,
          changedState, 
          const {}
        ),
      ],
      verify: (_) {
        expect(mockGameStateRepository.deleteSaveCalled, isTrue);
      },
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'chooseEventOption emits silent playing state when Left(Failure) is returned',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Left(Failure('Some error'));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [],
    );
  });

  group('loadGame', () {
    blocTest<GameEngineCubit, GameEngineState>(
      'emits playing state with loaded game state',
      build: () {
        mockGameStateRepository.stateToLoad = changedState;
        return cubit;
      },
      act: (cubit) => cubit.loadGame(),
      expect: () => [
        GameEngineState.playing(changedState),
      ],
    );
  });

  group('newlyUnlockedInsightCardIds', () {
    final stateWithCard1 = baseState.copyWith(unlockedInsightCardIds: {'card_1'});
    final stateWithCard1And2 = baseState.copyWith(unlockedInsightCardIds: {'card_1', 'card_2'});

    blocTest<GameEngineCubit, GameEngineState>(
      'emits newly unlocked cards when playing state continues',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnContinued(stateWithCard1And2));
        return cubit;
      },
      seed: () => GameEngineState.playing(stateWithCard1),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        // It's from nextMonth so monthlySummary will be calculated, let's omit the exact summary check for brevity or calculate it
        // Actually since we test exact state, we must provide the summary
        GameEngineState.playing(stateWithCard1And2, {'card_2'}, const MonthlySummaryDelta(cashDelta: 0, stressDelta: 0, netWorthDelta: 0)),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'newlyUnlockedInsightCardIds emits newly unlocked cards when turn lost immediately after option chosen',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnLost(
          stateWithCard1And2,
          GameOverReason.burnout,
        ));
        return cubit;
      },
      seed: () => GameEngineState.playing(stateWithCard1),
      act: (cubit) => cubit.chooseEventOption('event_1', 'opt_1'),
      expect: () => [
        GameEngineGameOver(GameOverReason.burnout, stateWithCard1And2, {'card_2'}),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'newlyUnlockedInsightCardIds emits newly unlocked cards when won',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnWon(stateWithCard1And2));
        return cubit;
      },
      seed: () => GameEngineState.playing(stateWithCard1),
      act: (cubit) => cubit.chooseEventOption('event_1', 'opt_1'),
      expect: () => [
        GameEngineWon(stateWithCard1And2, {'card_2'}),
      ],
    );
  });
}
