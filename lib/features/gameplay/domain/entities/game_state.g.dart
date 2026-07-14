// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameState _$GameStateFromJson(Map<String, dynamic> json) => _GameState(
  country: $enumDecode(_$CountryEnumMap, json['country']),
  currency: $enumDecode(_$CurrencyEnumMap, json['currency']),
  currentMonth: (json['currentMonth'] as num?)?.toInt() ?? 1,
  ageInMonths: (json['ageInMonths'] as num?)?.toInt() ?? 264,
  startCalendarMonth: (json['startCalendarMonth'] as num?)?.toInt() ?? 1,
  cash: (json['cash'] as num).toDouble(),
  monthlyExpenses: (json['monthlyExpenses'] as num).toDouble(),
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
);

Map<String, dynamic> _$GameStateToJson(_GameState instance) =>
    <String, dynamic>{
      'country': _$CountryEnumMap[instance.country]!,
      'currency': _$CurrencyEnumMap[instance.currency]!,
      'currentMonth': instance.currentMonth,
      'ageInMonths': instance.ageInMonths,
      'startCalendarMonth': instance.startCalendarMonth,
      'cash': instance.cash,
      'monthlyExpenses': instance.monthlyExpenses,
      'baseSalary': instance.baseSalary,
      'stress': instance.stress,
      'networkScore': instance.networkScore,
      'creditScore': instance.creditScore,
      'housingLevel': _$HousingLevelEnumMap[instance.housingLevel]!,
      'ownedItems': instance.ownedItems,
      'currentEventId': instance.currentEventId,
      'flags': instance.flags.toList(),
      'assets': instance.assets.map((e) => e.toJson()).toList(),
      'loans': instance.loans.map((e) => e.toJson()).toList(),
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
