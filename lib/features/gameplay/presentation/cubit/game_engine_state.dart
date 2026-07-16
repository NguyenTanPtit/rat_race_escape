import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/game_event.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/turn_result.dart';

part 'game_engine_state.freezed.dart';

@freezed
abstract class MonthlySummaryDelta with _$MonthlySummaryDelta {
  const factory MonthlySummaryDelta({
    required double cashDelta,
    required int stressDelta,
    required double netWorthDelta,
  }) = _MonthlySummaryDelta;
}

@freezed
sealed class GameEngineState with _$GameEngineState {
  const factory GameEngineState.initial() = GameEngineInitial;
  const factory GameEngineState.playing(
    GameState gameState, [
    @Default({}) Set<String> newlyUnlockedInsightCardIds,
    MonthlySummaryDelta? monthlySummary,
    GameEvent? currentEvent,
  ]) = GameEnginePlaying;
  const factory GameEngineState.gameOver(GameOverReason reason, GameState finalState, [@Default({}) Set<String> newlyUnlockedInsightCardIds]) = GameEngineGameOver;
  const factory GameEngineState.won(GameState finalState, [@Default({}) Set<String> newlyUnlockedInsightCardIds]) = GameEngineWon;
  const factory GameEngineState.error(String message) = GameEngineError;
}
