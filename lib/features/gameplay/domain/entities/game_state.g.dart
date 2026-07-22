// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameState _$GameStateFromJson(Map<String, dynamic> json) => _GameState(
  country: $enumDecode(_$CountryEnumMap, json['country']),
  currency: $enumDecode(_$CurrencyEnumMap, json['currency']),
  scenarioId: json['scenarioId'] as String,
  currentMonth: (json['currentMonth'] as num?)?.toInt() ?? 1,
  ageInMonths: (json['ageInMonths'] as num?)?.toInt() ?? 264,
  startCalendarMonth: (json['startCalendarMonth'] as num?)?.toInt() ?? 1,
  cash: (json['cash'] as num).toDouble(),
  monthlyExpenses: (json['monthlyExpenses'] as num).toDouble(),
  monthlyRent: (json['monthlyRent'] as num).toDouble(),
  baseSalary: (json['baseSalary'] as num).toDouble(),
  stress: (json['stress'] as num?)?.toInt() ?? 0,
  networkScore: (json['networkScore'] as num?)?.toInt() ?? 0,
  creditScore: (json['creditScore'] as num?)?.toInt() ?? 600,
  housingLevel:
      $enumDecodeNullable(_$HousingLevelEnumMap, json['housingLevel']) ??
      HousingLevel.shabbyRoom,
  ownedItems:
      (json['ownedItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  currentEventId: json['currentEventId'] as String?,
  flags:
      (json['flags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
      const {},
  unlockedInsightCardIds:
      (json['unlockedInsightCardIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet() ??
      const {},
  familySupportExpense:
      (json['familySupportExpense'] as num?)?.toDouble() ?? 0.0,
  baseEventChance: (json['baseEventChance'] as num?)?.toDouble() ?? 0.2,
  bankruptcyMonthsThreshold:
      (json['bankruptcyMonthsThreshold'] as num?)?.toInt() ?? 3,
  leisureCostPerStressPoint:
      (json['leisureCostPerStressPoint'] as num?)?.toDouble() ?? 100000,
  maxLeisureStressReliefPerMonth:
      (json['maxLeisureStressReliefPerMonth'] as num?)?.toInt() ?? 20,
  leisureReliefUsedThisMonth:
      (json['leisureReliefUsedThisMonth'] as num?)?.toInt() ?? 0,
  consecutiveMinimumCreditCardPayments:
      (json['consecutiveMinimumCreditCardPayments'] as num?)?.toInt() ?? 0,
  sideJobsWorkedThisMonth:
      (json['sideJobsWorkedThisMonth'] as num?)?.toInt() ?? 0,
  sideJobIncome: (json['sideJobIncome'] as num?)?.toDouble() ?? 2500000.0,
  sideJobStress: (json['sideJobStress'] as num?)?.toInt() ?? 8,
  maxSideJobsPerMonth: (json['maxSideJobsPerMonth'] as num?)?.toInt() ?? 2,
  assetSellFeeRate: (json['assetSellFeeRate'] as num?)?.toDouble() ?? 0.03,
  assets:
      (json['assets'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  loans:
      (json['loans'] as List<dynamic>?)
          ?.map((e) => Loan.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  market:
      (json['market'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, MarketClassState.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
);

Map<String, dynamic> _$GameStateToJson(_GameState instance) =>
    <String, dynamic>{
      'country': _$CountryEnumMap[instance.country]!,
      'currency': _$CurrencyEnumMap[instance.currency]!,
      'scenarioId': instance.scenarioId,
      'currentMonth': instance.currentMonth,
      'ageInMonths': instance.ageInMonths,
      'startCalendarMonth': instance.startCalendarMonth,
      'cash': instance.cash,
      'monthlyExpenses': instance.monthlyExpenses,
      'monthlyRent': instance.monthlyRent,
      'baseSalary': instance.baseSalary,
      'stress': instance.stress,
      'networkScore': instance.networkScore,
      'creditScore': instance.creditScore,
      'housingLevel': _$HousingLevelEnumMap[instance.housingLevel]!,
      'ownedItems': instance.ownedItems,
      'currentEventId': instance.currentEventId,
      'flags': instance.flags.toList(),
      'unlockedInsightCardIds': instance.unlockedInsightCardIds.toList(),
      'familySupportExpense': instance.familySupportExpense,
      'baseEventChance': instance.baseEventChance,
      'bankruptcyMonthsThreshold': instance.bankruptcyMonthsThreshold,
      'leisureCostPerStressPoint': instance.leisureCostPerStressPoint,
      'maxLeisureStressReliefPerMonth': instance.maxLeisureStressReliefPerMonth,
      'leisureReliefUsedThisMonth': instance.leisureReliefUsedThisMonth,
      'consecutiveMinimumCreditCardPayments':
          instance.consecutiveMinimumCreditCardPayments,
      'sideJobsWorkedThisMonth': instance.sideJobsWorkedThisMonth,
      'sideJobIncome': instance.sideJobIncome,
      'sideJobStress': instance.sideJobStress,
      'maxSideJobsPerMonth': instance.maxSideJobsPerMonth,
      'assetSellFeeRate': instance.assetSellFeeRate,
      'assets': instance.assets.map((e) => e.toJson()).toList(),
      'loans': instance.loans.map((e) => e.toJson()).toList(),
      'market': instance.market.map((k, e) => MapEntry(k, e.toJson())),
    };

const _$CountryEnumMap = {
  Country.vietnam: 'vietnam',
  Country.usa: 'usa',
  Country.japan: 'japan',
};

const _$CurrencyEnumMap = {
  Currency.vnd: 'vnd',
  Currency.usd: 'usd',
  Currency.jpy: 'jpy',
};

const _$HousingLevelEnumMap = {
  HousingLevel.shabbyRoom: 'shabbyRoom',
  HousingLevel.studio: 'studio',
  HousingLevel.condo: 'condo',
  HousingLevel.villa: 'villa',
  HousingLevel.luxuryCondo: 'luxuryCondo',
};
