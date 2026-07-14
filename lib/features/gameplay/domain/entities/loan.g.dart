// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Loan _$LoanFromJson(Map<String, dynamic> json) => _Loan(
  id: json['id'] as String,
  name: json['name'] as String,
  principalAmount: (json['principalAmount'] as num).toDouble(),
  interestRatePerYear: (json['interestRatePerYear'] as num).toDouble(),
  minimumMonthlyPayment: (json['minimumMonthlyPayment'] as num).toDouble(),
  type:
      $enumDecodeNullable(_$LoanTypeEnumMap, json['type']) ??
      LoanType.creditCard,
);

Map<String, dynamic> _$LoanToJson(_Loan instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'principalAmount': instance.principalAmount,
  'interestRatePerYear': instance.interestRatePerYear,
  'minimumMonthlyPayment': instance.minimumMonthlyPayment,
  'type': _$LoanTypeEnumMap[instance.type]!,
};

const _$LoanTypeEnumMap = {
  LoanType.creditCard: 'creditCard',
  LoanType.personalLoan: 'personalLoan',
  LoanType.mortgage: 'mortgage',
  LoanType.blackMarket: 'blackMarket',
};
