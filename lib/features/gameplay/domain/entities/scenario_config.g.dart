// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScenarioConfig _$ScenarioConfigFromJson(Map<String, dynamic> json) =>
    _ScenarioConfig(
      id: json['id'] as String,
      initialCash: (json['initialCash'] as num).toDouble(),
      baseSalary: (json['baseSalary'] as num).toDouble(),
      monthlyRent: (json['monthlyRent'] as num).toDouble(),
      monthlyExpenses: (json['monthlyExpenses'] as num).toDouble(),
      initialAssets:
          (json['initialAssets'] as List<dynamic>?)
              ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      initialLoans:
          (json['initialLoans'] as List<dynamic>?)
              ?.map((e) => Loan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      familySupportExpense:
          (json['familySupportExpense'] as num?)?.toDouble() ?? 0.0,
      startAgeInMonths: (json['startAgeInMonths'] as num).toInt(),
      startCalendarMonth: (json['startCalendarMonth'] as num).toInt(),
      initialCreditScore: (json['initialCreditScore'] as num).toInt(),
      housingLevel: $enumDecode(_$HousingLevelEnumMap, json['housingLevel']),
      country: $enumDecode(_$CountryEnumMap, json['country']),
      currency: json['currency'] as String,
      bankruptcyMonthsThreshold:
          (json['bankruptcyMonthsThreshold'] as num?)?.toInt() ?? 3,
      leisureCostPerStressPoint:
          (json['leisureCostPerStressPoint'] as num?)?.toDouble() ?? 100000,
      maxLeisureStressReliefPerMonth:
          (json['maxLeisureStressReliefPerMonth'] as num?)?.toInt() ?? 20,
      baseEventChance: (json['baseEventChance'] as num?)?.toDouble() ?? 0.2,
      sideJobIncome: (json['sideJobIncome'] as num?)?.toDouble() ?? 2500000.0,
      sideJobStress: (json['sideJobStress'] as num?)?.toInt() ?? 8,
      maxSideJobsPerMonth: (json['maxSideJobsPerMonth'] as num?)?.toInt() ?? 2,
      assetSellFeeRate: (json['assetSellFeeRate'] as num?)?.toDouble() ?? 0.03,
    );

Map<String, dynamic> _$ScenarioConfigToJson(_ScenarioConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'initialCash': instance.initialCash,
      'baseSalary': instance.baseSalary,
      'monthlyRent': instance.monthlyRent,
      'monthlyExpenses': instance.monthlyExpenses,
      'initialAssets': instance.initialAssets.map((e) => e.toJson()).toList(),
      'initialLoans': instance.initialLoans.map((e) => e.toJson()).toList(),
      'familySupportExpense': instance.familySupportExpense,
      'startAgeInMonths': instance.startAgeInMonths,
      'startCalendarMonth': instance.startCalendarMonth,
      'initialCreditScore': instance.initialCreditScore,
      'housingLevel': _$HousingLevelEnumMap[instance.housingLevel]!,
      'country': _$CountryEnumMap[instance.country]!,
      'currency': instance.currency,
      'bankruptcyMonthsThreshold': instance.bankruptcyMonthsThreshold,
      'leisureCostPerStressPoint': instance.leisureCostPerStressPoint,
      'maxLeisureStressReliefPerMonth': instance.maxLeisureStressReliefPerMonth,
      'baseEventChance': instance.baseEventChance,
      'sideJobIncome': instance.sideJobIncome,
      'sideJobStress': instance.sideJobStress,
      'maxSideJobsPerMonth': instance.maxSideJobsPerMonth,
      'assetSellFeeRate': instance.assetSellFeeRate,
    };

const _$HousingLevelEnumMap = {
  HousingLevel.shabbyRoom: 'shabbyRoom',
  HousingLevel.studio: 'studio',
  HousingLevel.condo: 'condo',
  HousingLevel.villa: 'villa',
  HousingLevel.luxuryCondo: 'luxuryCondo',
};

const _$CountryEnumMap = {
  Country.vietnam: 'vietnam',
  Country.usa: 'usa',
  Country.japan: 'japan',
};
