import 'package:freezed_annotation/freezed_annotation.dart';
import 'asset.dart';
import 'loan.dart';

part 'event_effect.freezed.dart';
part 'event_effect.g.dart';

@freezed
abstract class EventEffect with _$EventEffect {
  const factory EventEffect({
    @Default(0.0) double cash,
    @Default(0) int stress,
    @Default(0) int network,
    @Default(0) int credit,
    @Default([]) List<Loan> addedLoans,
    @Default([]) List<Asset> addedAssets,
    @Default([]) List<String> addedFlags,
    @Default([]) List<String> removedFlags,
    String? insightCardId,
    @Default(0.0) double salaryDelta,
    @Default(0.0) double monthlyExpensesDelta,
    @Default(0.0) double cashBySalaryMultiplier,
    @Default(0.0) double cashByOutflowMultiplier,
  }) = _EventEffect;

  factory EventEffect.fromJson(Map<String, dynamic> json) => _$EventEffectFromJson(json);
}
