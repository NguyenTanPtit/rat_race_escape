import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_proceed.freezed.dart';
part 'pending_proceed.g.dart';

/// Sale proceeds waiting for settlement: the money is yours (counts toward
/// net worth) but is NOT spendable until [monthsLeft] reaches zero.
@freezed
abstract class PendingProceed with _$PendingProceed {
  const factory PendingProceed({
    required double amount,
    required int monthsLeft,
  }) = _PendingProceed;

  factory PendingProceed.fromJson(Map<String, dynamic> json) =>
      _$PendingProceedFromJson(json);
}
