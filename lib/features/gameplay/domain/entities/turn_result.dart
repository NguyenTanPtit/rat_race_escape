import 'package:freezed_annotation/freezed_annotation.dart';
import 'game_state.dart';

part 'turn_result.freezed.dart';

@freezed
sealed class TurnResult with _$TurnResult {
  const factory TurnResult.continued(GameState state) = TurnContinued;
  const factory TurnResult.won(GameState state) = TurnWon;
  const factory TurnResult.lost(GameState state, GameOverReason reason) = TurnLost;
}

enum GameOverReason { burnout, bankruptcy, debtSpiral, poorAtRetirement }
