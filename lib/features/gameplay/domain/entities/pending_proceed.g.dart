// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_proceed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingProceed _$PendingProceedFromJson(Map<String, dynamic> json) =>
    _PendingProceed(
      amount: (json['amount'] as num).toDouble(),
      monthsLeft: (json['monthsLeft'] as num).toInt(),
    );

Map<String, dynamic> _$PendingProceedToJson(_PendingProceed instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'monthsLeft': instance.monthsLeft,
    };
