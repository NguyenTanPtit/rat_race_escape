import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/usecases/process_next_month_usecase.dart';
import 'game_engine_state.dart';

class GameEngineCubit extends Cubit<GameEngineState> {
  final ProcessNextMonthUseCase _processNextMonthUseCase;

  GameEngineCubit(this._processNextMonthUseCase) : super(const GameEngineState.initial());

  /// Starts the game by emitting the playing state with the initial data.
  void startGame(GameState initialState) {
    emit(GameEngineState.playing(initialState));
  }

  /// Advances the game engine to the next month using the usecase pipeline.
  void nextMonth() {
    state.mapOrNull(
      playing: (playingState) {
        // Emit loading state (optional, just for brief animation)
        emit(const GameEngineState.loading());

        // Process the next month
        final result = _processNextMonthUseCase.call(playingState.gameState);

        // Handle the Either result
        result.fold(
          (failure) {
            emit(GameEngineState.error(failure.message));
          },
          (newState) {
            // Check game over conditions
            if (newState.stress >= 100) {
              emit(GameEngineState.gameOver('Burnout: Stress level reached maximum capacity.', newState));
              return;
            }

            if (newState.cash < -10000 && newState.creditScore <= 350) {
              emit(GameEngineState.gameOver('Bankrupt: Unrecoverable debt and poor credit.', newState));
              return;
            }

            // If no game over condition is met, continue playing
            emit(GameEngineState.playing(newState));
          },
        );
      },
    );
  }
}
