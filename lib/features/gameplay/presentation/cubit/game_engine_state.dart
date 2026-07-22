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
    @Default(0.0) double cashIn,
    @Default(0.0) double cashOut,
  }) = _MonthlySummaryDelta;
}

enum MarketStopKind { crash, boom }

/// Session-only info about why auto-advance stopped on a market move.
/// [changePercent] is the drawdown from peak (crash) or the gain over the
/// trailing 12-month average (boom), as a positive percentage.
@freezed
abstract class MarketStopInfo with _$MarketStopInfo {
  const factory MarketStopInfo({
    required String classId,
    required String className,
    required MarketStopKind kind,
    required double changePercent,
  }) = _MarketStopInfo;
}

@freezed
sealed class GameEngineState with _$GameEngineState {
  const factory GameEngineState.initial() = GameEngineInitial;
  const factory GameEngineState.playing(
    GameState gameState, [
    @Default({}) Set<String> newlyUnlockedInsightCardIds,
    MonthlySummaryDelta? monthlySummary,
    GameEvent? currentEvent,
    @Default(false) bool isAutoAdvancing,
    YearlyRecap? yearlyRecap,
    MarketStopInfo? marketStopInfo,
  ]) = GameEnginePlaying;
  const factory GameEngineState.gameOver(GameOverReason reason, GameState finalState, [@Default({}) Set<String> newlyUnlockedInsightCardIds]) = GameEngineGameOver;
  const factory GameEngineState.won(GameState finalState, [@Default({}) Set<String> newlyUnlockedInsightCardIds]) = GameEngineWon;
  const factory GameEngineState.error(String message) = GameEngineError;
}

typedef MonthlyHistoryRecord = ({
  int ageInMonths,
  double netWorth,
  double cashIn,
  double cashOut,
  double cashDelta,
  String? eventId,
});

@freezed
abstract class YearlyRecap with _$YearlyRecap {
  const factory YearlyRecap({
    required double totalCashIn,
    required double totalCashOut,
    required List<MonthlyHistoryRecord> topEvents, // Sorted by absolute cash impact
    required List<MonthlyHistoryRecord> fullHistory, // Last 12 months for chart
  }) = _YearlyRecap;
}
