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

void main() {
  late GameEngineCubit cubit;
  late MockProcessNextMonthUseCase mockProcessNextMonthUseCase;
  late MockApplyEventOptionUseCase mockApplyEventOptionUseCase;
  late MockSpendOnLeisureUseCase mockSpendOnLeisureUseCase;

  setUp(() {
    mockProcessNextMonthUseCase = MockProcessNextMonthUseCase();
    mockApplyEventOptionUseCase = MockApplyEventOptionUseCase();
    mockSpendOnLeisureUseCase = MockSpendOnLeisureUseCase();
    cubit = GameEngineCubit(
      mockProcessNextMonthUseCase,
      mockApplyEventOptionUseCase,
      mockSpendOnLeisureUseCase,
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
  );

  test('initial state should be GameEngineState.initial', () {
    expect(cubit.state, const GameEngineState.initial());
  });

  blocTest<GameEngineCubit, GameEngineState>(
    'startGame emits playing state',
    build: () => cubit,
    act: (cubit) => cubit.startGame(baseState),
    expect: () => [
      const GameEngineState.playing(baseState),
    ],
  );

  final changedState = baseState.copyWith(cash: 9999999);

  group('nextMonth', () {
    blocTest<GameEngineCubit, GameEngineState>(
      'emits nothing if current state is not playing',
      build: () => cubit,
      act: (cubit) => cubit.nextMonth(),
      expect: () => [],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits playing state when TurnContinued is returned',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnContinued(changedState));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineState.playing(changedState),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits gameOver state when TurnLost is returned',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnLost(changedState, GameOverReason.bankruptcy));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineState.gameOver(GameOverReason.bankruptcy, changedState),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits won state when TurnWon is returned',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnWon(changedState));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineState.won(changedState),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits error state when Failure is returned',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Left(Failure('Something went wrong'));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        const GameEngineState.error('Something went wrong'),
      ],
    );
  });

  group('chooseEventOption', () {
    blocTest<GameEngineCubit, GameEngineState>(
      'emits nothing if current state is not playing',
      build: () => cubit,
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits playing state when TurnContinued is returned after applying option',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnContinued(changedState));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [
        GameEngineState.playing(changedState),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits gameOver state when TurnLost is returned immediately after applying option',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnLost(changedState, GameOverReason.burnout));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [
        GameEngineState.gameOver(GameOverReason.burnout, changedState),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits nothing when Failure is returned by applyEventOptionUseCase (e.g. double tap)',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Left(Failure('Invalid active event'));
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'double tap: apply same option 2 times sequentially -> second time state remains GameEnginePlaying of the first time without error',
      build: () {
        mockApplyEventOptionUseCase.resultsQueue = [
          Right(TurnContinued(changedState)), // 1st tap succeeds
          Left(Failure('Invalid active event')), // 2nd tap fails
        ];
        return cubit;
      },
      seed: () => const GameEngineState.playing(baseState),
      act: (cubit) async {
        await cubit.chooseEventOption('e_1', 'o_1');
        await cubit.chooseEventOption('e_1', 'o_1');
      },
      expect: () => [
        GameEngineState.playing(changedState), // Only the first success is emitted
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
        GameEngineState.playing(stateWithCard1And2, {'card_2'}),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits newly unlocked cards when turn lost immediately after option chosen',
      build: () {
        mockApplyEventOptionUseCase.resultToReturn = Right(TurnLost(stateWithCard1And2, GameOverReason.burnout));
        return cubit;
      },
      seed: () => GameEngineState.playing(stateWithCard1),
      act: (cubit) => cubit.chooseEventOption('e_1', 'o_1'),
      expect: () => [
        GameEngineState.gameOver(GameOverReason.burnout, stateWithCard1And2, {'card_2'}),
      ],
    );

    blocTest<GameEngineCubit, GameEngineState>(
      'emits newly unlocked cards when won',
      build: () {
        mockProcessNextMonthUseCase.resultToReturn = Right(TurnWon(stateWithCard1And2));
        return cubit;
      },
      seed: () => GameEngineState.playing(stateWithCard1),
      act: (cubit) => cubit.nextMonth(),
      expect: () => [
        GameEngineState.won(stateWithCard1And2, {'card_2'}),
      ],
    );
  });
}
