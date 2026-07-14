// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_effect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventEffect _$EventEffectFromJson(Map<String, dynamic> json) => _EventEffect(
  cash: (json['cash'] as num?)?.toDouble() ?? 0.0,
  stress: (json['stress'] as num?)?.toInt() ?? 0,
  network: (json['network'] as num?)?.toInt() ?? 0,
  credit: (json['credit'] as num?)?.toInt() ?? 0,
  addedLoans:
      (json['addedLoans'] as List<dynamic>?)
          ?.map((e) => Loan.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  addedAssets:
      (json['addedAssets'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  addedFlags:
      (json['addedFlags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  removedFlags:
      (json['removedFlags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  insightCardId: json['insightCardId'] as String?,
  salaryDelta: (json['salaryDelta'] as num?)?.toDouble() ?? 0.0,
  monthlyExpensesDelta:
      (json['monthlyExpensesDelta'] as num?)?.toDouble() ?? 0.0,
  cashBySalaryMultiplier:
      (json['cashBySalaryMultiplier'] as num?)?.toDouble() ?? 0.0,
  cashByOutflowMultiplier:
      (json['cashByOutflowMultiplier'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$EventEffectToJson(_EventEffect instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'stress': instance.stress,
      'network': instance.network,
      'credit': instance.credit,
      'addedLoans': instance.addedLoans.map((e) => e.toJson()).toList(),
      'addedAssets': instance.addedAssets.map((e) => e.toJson()).toList(),
      'addedFlags': instance.addedFlags,
      'removedFlags': instance.removedFlags,
      'insightCardId': instance.insightCardId,
      'salaryDelta': instance.salaryDelta,
      'monthlyExpensesDelta': instance.monthlyExpensesDelta,
      'cashBySalaryMultiplier': instance.cashBySalaryMultiplier,
      'cashByOutflowMultiplier': instance.cashByOutflowMultiplier,
    };
