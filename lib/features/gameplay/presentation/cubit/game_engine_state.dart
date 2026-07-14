import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/turn_result.dart';

part 'game_engine_state.freezed.dart';

@freezed
sealed class GameEngineState with _$GameEngineState {
  const factory GameEngineState.initial() = GameEngineInitial;
  const factory GameEngineState.playing(GameState gameState) = GameEnginePlaying;
  const factory GameEngineState.gameOver(GameOverReason reason, GameState finalState) = GameEngineGameOver;
  const factory GameEngineState.won(GameState finalState) = GameEngineWon;
  const factory GameEngineState.error(String message) = GameEngineError;
}
