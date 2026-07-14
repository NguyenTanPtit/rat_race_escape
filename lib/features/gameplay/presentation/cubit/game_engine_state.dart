import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/game_state.dart';

part 'game_engine_state.freezed.dart';

@freezed
class GameEngineState with _$GameEngineState {
  const factory GameEngineState.initial() = _Initial;
  const factory GameEngineState.loading() = _Loading;
  const factory GameEngineState.playing(GameState gameState) = _Playing;
  const factory GameEngineState.gameOver(String reason, GameState finalState) = _GameOver;
  const factory GameEngineState.error(String message) = _Error;
}
