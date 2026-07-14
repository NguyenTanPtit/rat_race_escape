import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/entities/turn_result.dart';
import '../../domain/usecases/process_next_month_usecase.dart';
import 'game_engine_state.dart';

@injectable
class GameEngineCubit extends Cubit<GameEngineState> {
  final ProcessNextMonthUseCase _processNextMonthUseCase;

  GameEngineCubit(this._processNextMonthUseCase) : super(const GameEngineState.initial());

  /// Starts the game by emitting the playing state with the initial data.
  void startGame(GameState initialState) {
    emit(GameEngineState.playing(initialState));
  }

  /// Advances the game engine to the next month using the usecase pipeline.
  Future<void> nextMonth() async {
    if (state is! GameEnginePlaying) return;
    
    final playingState = state as GameEnginePlaying;

    // Process the next month
    final result = await _processNextMonthUseCase.call(playingState.gameState);

    // Handle the Either result
    result.fold(
      (failure) {
        emit(GameEngineState.error(failure.message));
      },
      (turnResult) {
        switch (turnResult) {
          case TurnContinued():
            emit(GameEngineState.playing(turnResult.state));
          case TurnWon():
            emit(GameEngineState.gameOver('Victory: You have achieved financial freedom!', turnResult.state));
          case TurnLost():
            final reasonStr = switch (turnResult.reason) {
              GameOverReason.burnout => 'Burnout: Stress level reached maximum capacity.',
              GameOverReason.bankruptcy => 'Bankrupt: You ran out of cash to survive.',
              GameOverReason.debtSpiral => 'Debt Spiral: Unrecoverable debt and poor credit.',
              GameOverReason.poorAtRetirement => 'Retirement: Reached age 65 without financial freedom.',
            };
            emit(GameEngineState.gameOver(reasonStr, turnResult.state));
        }
      },
    );
  }
}
