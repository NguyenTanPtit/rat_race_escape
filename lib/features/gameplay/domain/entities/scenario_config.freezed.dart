// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scenario_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScenarioConfig {

 String get id; double get initialCash; double get baseSalary; double get monthlyRent; double get monthlyExpenses; List<Asset> get initialAssets; List<Loan> get initialLoans; double get familySupportExpense; int get startAgeInMonths; int get startCalendarMonth; int get initialCreditScore; HousingLevel get housingLevel; Country get country; String get currency; int get bankruptcyMonthsThreshold; double get leisureCostPerStressPoint; int get maxLeisureStressReliefPerMonth; double get baseEventChance;
/// Create a copy of ScenarioConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioConfigCopyWith<ScenarioConfig> get copyWith => _$ScenarioConfigCopyWithImpl<ScenarioConfig>(this as ScenarioConfig, _$identity);

  /// Serializes this ScenarioConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.initialCash, initialCash) || other.initialCash == initialCash)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&const DeepCollectionEquality().equals(other.initialAssets, initialAssets)&&const DeepCollectionEquality().equals(other.initialLoans, initialLoans)&&(identical(other.familySupportExpense, familySupportExpense) || other.familySupportExpense == familySupportExpense)&&(identical(other.startAgeInMonths, startAgeInMonths) || other.startAgeInMonths == startAgeInMonths)&&(identical(other.startCalendarMonth, startCalendarMonth) || other.startCalendarMonth == startCalendarMonth)&&(identical(other.initialCreditScore, initialCreditScore) || other.initialCreditScore == initialCreditScore)&&(identical(other.housingLevel, housingLevel) || other.housingLevel == housingLevel)&&(identical(other.country, country) || other.country == country)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.bankruptcyMonthsThreshold, bankruptcyMonthsThreshold) || other.bankruptcyMonthsThreshold == bankruptcyMonthsThreshold)&&(identical(other.leisureCostPerStressPoint, leisureCostPerStressPoint) || other.leisureCostPerStressPoint == leisureCostPerStressPoint)&&(identical(other.maxLeisureStressReliefPerMonth, maxLeisureStressReliefPerMonth) || other.maxLeisureStressReliefPerMonth == maxLeisureStressReliefPerMonth)&&(identical(other.baseEventChance, baseEventChance) || other.baseEventChance == baseEventChance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,initialCash,baseSalary,monthlyRent,monthlyExpenses,const DeepCollectionEquality().hash(initialAssets),const DeepCollectionEquality().hash(initialLoans),familySupportExpense,startAgeInMonths,startCalendarMonth,initialCreditScore,housingLevel,country,currency,bankruptcyMonthsThreshold,leisureCostPerStressPoint,maxLeisureStressReliefPerMonth,baseEventChance);

@override
String toString() {
  return 'ScenarioConfig(id: $id, initialCash: $initialCash, baseSalary: $baseSalary, monthlyRent: $monthlyRent, monthlyExpenses: $monthlyExpenses, initialAssets: $initialAssets, initialLoans: $initialLoans, familySupportExpense: $familySupportExpense, startAgeInMonths: $startAgeInMonths, startCalendarMonth: $startCalendarMonth, initialCreditScore: $initialCreditScore, housingLevel: $housingLevel, country: $country, currency: $currency, bankruptcyMonthsThreshold: $bankruptcyMonthsThreshold, leisureCostPerStressPoint: $leisureCostPerStressPoint, maxLeisureStressReliefPerMonth: $maxLeisureStressReliefPerMonth, baseEventChance: $baseEventChance)';
}


}

/// @nodoc
abstract mixin class $ScenarioConfigCopyWith<$Res>  {
  factory $ScenarioConfigCopyWith(ScenarioConfig value, $Res Function(ScenarioConfig) _then) = _$ScenarioConfigCopyWithImpl;
@useResult
$Res call({
 String id, double initialCash, double baseSalary, double monthlyRent, double monthlyExpenses, List<Asset> initialAssets, List<Loan> initialLoans, double familySupportExpense, int startAgeInMonths, int startCalendarMonth, int initialCreditScore, HousingLevel housingLevel, Country country, String currency, int bankruptcyMonthsThreshold, double leisureCostPerStressPoint, int maxLeisureStressReliefPerMonth, double baseEventChance
});




}
/// @nodoc
class _$ScenarioConfigCopyWithImpl<$Res>
    implements $ScenarioConfigCopyWith<$Res> {
  _$ScenarioConfigCopyWithImpl(this._self, this._then);

  final ScenarioConfig _self;
  final $Res Function(ScenarioConfig) _then;

/// Create a copy of ScenarioConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? initialCash = null,Object? baseSalary = null,Object? monthlyRent = null,Object? monthlyExpenses = null,Object? initialAssets = null,Object? initialLoans = null,Object? familySupportExpense = null,Object? startAgeInMonths = null,Object? startCalendarMonth = null,Object? initialCreditScore = null,Object? housingLevel = null,Object? country = null,Object? currency = null,Object? bankruptcyMonthsThreshold = null,Object? leisureCostPerStressPoint = null,Object? maxLeisureStressReliefPerMonth = null,Object? baseEventChance = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,initialCash: null == initialCash ? _self.initialCash : initialCash // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,initialAssets: null == initialAssets ? _self.initialAssets : initialAssets // ignore: cast_nullable_to_non_nullable
as List<Asset>,initialLoans: null == initialLoans ? _self.initialLoans : initialLoans // ignore: cast_nullable_to_non_nullable
as List<Loan>,familySupportExpense: null == familySupportExpense ? _self.familySupportExpense : familySupportExpense // ignore: cast_nullable_to_non_nullable
as double,startAgeInMonths: null == startAgeInMonths ? _self.startAgeInMonths : startAgeInMonths // ignore: cast_nullable_to_non_nullable
as int,startCalendarMonth: null == startCalendarMonth ? _self.startCalendarMonth : startCalendarMonth // ignore: cast_nullable_to_non_nullable
as int,initialCreditScore: null == initialCreditScore ? _self.initialCreditScore : initialCreditScore // ignore: cast_nullable_to_non_nullable
as int,housingLevel: null == housingLevel ? _self.housingLevel : housingLevel // ignore: cast_nullable_to_non_nullable
as HousingLevel,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,bankruptcyMonthsThreshold: null == bankruptcyMonthsThreshold ? _self.bankruptcyMonthsThreshold : bankruptcyMonthsThreshold // ignore: cast_nullable_to_non_nullable
as int,leisureCostPerStressPoint: null == leisureCostPerStressPoint ? _self.leisureCostPerStressPoint : leisureCostPerStressPoint // ignore: cast_nullable_to_non_nullable
as double,maxLeisureStressReliefPerMonth: null == maxLeisureStressReliefPerMonth ? _self.maxLeisureStressReliefPerMonth : maxLeisureStressReliefPerMonth // ignore: cast_nullable_to_non_nullable
as int,baseEventChance: null == baseEventChance ? _self.baseEventChance : baseEventChance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScenarioConfig].
extension ScenarioConfigPatterns on ScenarioConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScenarioConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScenarioConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScenarioConfig value)  $default,){
final _that = this;
switch (_that) {
case _ScenarioConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScenarioConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ScenarioConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double initialCash,  double baseSalary,  double monthlyRent,  double monthlyExpenses,  List<Asset> initialAssets,  List<Loan> initialLoans,  double familySupportExpense,  int startAgeInMonths,  int startCalendarMonth,  int initialCreditScore,  HousingLevel housingLevel,  Country country,  String currency,  int bankruptcyMonthsThreshold,  double leisureCostPerStressPoint,  int maxLeisureStressReliefPerMonth,  double baseEventChance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioConfig() when $default != null:
return $default(_that.id,_that.initialCash,_that.baseSalary,_that.monthlyRent,_that.monthlyExpenses,_that.initialAssets,_that.initialLoans,_that.familySupportExpense,_that.startAgeInMonths,_that.startCalendarMonth,_that.initialCreditScore,_that.housingLevel,_that.country,_that.currency,_that.bankruptcyMonthsThreshold,_that.leisureCostPerStressPoint,_that.maxLeisureStressReliefPerMonth,_that.baseEventChance);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double initialCash,  double baseSalary,  double monthlyRent,  double monthlyExpenses,  List<Asset> initialAssets,  List<Loan> initialLoans,  double familySupportExpense,  int startAgeInMonths,  int startCalendarMonth,  int initialCreditScore,  HousingLevel housingLevel,  Country country,  String currency,  int bankruptcyMonthsThreshold,  double leisureCostPerStressPoint,  int maxLeisureStressReliefPerMonth,  double baseEventChance)  $default,) {final _that = this;
switch (_that) {
case _ScenarioConfig():
return $default(_that.id,_that.initialCash,_that.baseSalary,_that.monthlyRent,_that.monthlyExpenses,_that.initialAssets,_that.initialLoans,_that.familySupportExpense,_that.startAgeInMonths,_that.startCalendarMonth,_that.initialCreditScore,_that.housingLevel,_that.country,_that.currency,_that.bankruptcyMonthsThreshold,_that.leisureCostPerStressPoint,_that.maxLeisureStressReliefPerMonth,_that.baseEventChance);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double initialCash,  double baseSalary,  double monthlyRent,  double monthlyExpenses,  List<Asset> initialAssets,  List<Loan> initialLoans,  double familySupportExpense,  int startAgeInMonths,  int startCalendarMonth,  int initialCreditScore,  HousingLevel housingLevel,  Country country,  String currency,  int bankruptcyMonthsThreshold,  double leisureCostPerStressPoint,  int maxLeisureStressReliefPerMonth,  double baseEventChance)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioConfig() when $default != null:
return $default(_that.id,_that.initialCash,_that.baseSalary,_that.monthlyRent,_that.monthlyExpenses,_that.initialAssets,_that.initialLoans,_that.familySupportExpense,_that.startAgeInMonths,_that.startCalendarMonth,_that.initialCreditScore,_that.housingLevel,_that.country,_that.currency,_that.bankruptcyMonthsThreshold,_that.leisureCostPerStressPoint,_that.maxLeisureStressReliefPerMonth,_that.baseEventChance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioConfig implements ScenarioConfig {
  const _ScenarioConfig({required this.id, required this.initialCash, required this.baseSalary, required this.monthlyRent, required this.monthlyExpenses, final  List<Asset> initialAssets = const [], final  List<Loan> initialLoans = const [], this.familySupportExpense = 0.0, required this.startAgeInMonths, required this.startCalendarMonth, required this.initialCreditScore, required this.housingLevel, required this.country, required this.currency, this.bankruptcyMonthsThreshold = 3, this.leisureCostPerStressPoint = 100000, this.maxLeisureStressReliefPerMonth = 20, this.baseEventChance = 0.2}): _initialAssets = initialAssets,_initialLoans = initialLoans;
  factory _ScenarioConfig.fromJson(Map<String, dynamic> json) => _$ScenarioConfigFromJson(json);

@override final  String id;
@override final  double initialCash;
@override final  double baseSalary;
@override final  double monthlyRent;
@override final  double monthlyExpenses;
 final  List<Asset> _initialAssets;
@override@JsonKey() List<Asset> get initialAssets {
  if (_initialAssets is EqualUnmodifiableListView) return _initialAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialAssets);
}

 final  List<Loan> _initialLoans;
@override@JsonKey() List<Loan> get initialLoans {
  if (_initialLoans is EqualUnmodifiableListView) return _initialLoans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialLoans);
}

@override@JsonKey() final  double familySupportExpense;
@override final  int startAgeInMonths;
@override final  int startCalendarMonth;
@override final  int initialCreditScore;
@override final  HousingLevel housingLevel;
@override final  Country country;
@override final  String currency;
@override@JsonKey() final  int bankruptcyMonthsThreshold;
@override@JsonKey() final  double leisureCostPerStressPoint;
@override@JsonKey() final  int maxLeisureStressReliefPerMonth;
@override@JsonKey() final  double baseEventChance;

/// Create a copy of ScenarioConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScenarioConfigCopyWith<_ScenarioConfig> get copyWith => __$ScenarioConfigCopyWithImpl<_ScenarioConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScenarioConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.initialCash, initialCash) || other.initialCash == initialCash)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&const DeepCollectionEquality().equals(other._initialAssets, _initialAssets)&&const DeepCollectionEquality().equals(other._initialLoans, _initialLoans)&&(identical(other.familySupportExpense, familySupportExpense) || other.familySupportExpense == familySupportExpense)&&(identical(other.startAgeInMonths, startAgeInMonths) || other.startAgeInMonths == startAgeInMonths)&&(identical(other.startCalendarMonth, startCalendarMonth) || other.startCalendarMonth == startCalendarMonth)&&(identical(other.initialCreditScore, initialCreditScore) || other.initialCreditScore == initialCreditScore)&&(identical(other.housingLevel, housingLevel) || other.housingLevel == housingLevel)&&(identical(other.country, country) || other.country == country)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.bankruptcyMonthsThreshold, bankruptcyMonthsThreshold) || other.bankruptcyMonthsThreshold == bankruptcyMonthsThreshold)&&(identical(other.leisureCostPerStressPoint, leisureCostPerStressPoint) || other.leisureCostPerStressPoint == leisureCostPerStressPoint)&&(identical(other.maxLeisureStressReliefPerMonth, maxLeisureStressReliefPerMonth) || other.maxLeisureStressReliefPerMonth == maxLeisureStressReliefPerMonth)&&(identical(other.baseEventChance, baseEventChance) || other.baseEventChance == baseEventChance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,initialCash,baseSalary,monthlyRent,monthlyExpenses,const DeepCollectionEquality().hash(_initialAssets),const DeepCollectionEquality().hash(_initialLoans),familySupportExpense,startAgeInMonths,startCalendarMonth,initialCreditScore,housingLevel,country,currency,bankruptcyMonthsThreshold,leisureCostPerStressPoint,maxLeisureStressReliefPerMonth,baseEventChance);

@override
String toString() {
  return 'ScenarioConfig(id: $id, initialCash: $initialCash, baseSalary: $baseSalary, monthlyRent: $monthlyRent, monthlyExpenses: $monthlyExpenses, initialAssets: $initialAssets, initialLoans: $initialLoans, familySupportExpense: $familySupportExpense, startAgeInMonths: $startAgeInMonths, startCalendarMonth: $startCalendarMonth, initialCreditScore: $initialCreditScore, housingLevel: $housingLevel, country: $country, currency: $currency, bankruptcyMonthsThreshold: $bankruptcyMonthsThreshold, leisureCostPerStressPoint: $leisureCostPerStressPoint, maxLeisureStressReliefPerMonth: $maxLeisureStressReliefPerMonth, baseEventChance: $baseEventChance)';
}


}

/// @nodoc
abstract mixin class _$ScenarioConfigCopyWith<$Res> implements $ScenarioConfigCopyWith<$Res> {
  factory _$ScenarioConfigCopyWith(_ScenarioConfig value, $Res Function(_ScenarioConfig) _then) = __$ScenarioConfigCopyWithImpl;
@override @useResult
$Res call({
 String id, double initialCash, double baseSalary, double monthlyRent, double monthlyExpenses, List<Asset> initialAssets, List<Loan> initialLoans, double familySupportExpense, int startAgeInMonths, int startCalendarMonth, int initialCreditScore, HousingLevel housingLevel, Country country, String currency, int bankruptcyMonthsThreshold, double leisureCostPerStressPoint, int maxLeisureStressReliefPerMonth, double baseEventChance
});




}
/// @nodoc
class __$ScenarioConfigCopyWithImpl<$Res>
    implements _$ScenarioConfigCopyWith<$Res> {
  __$ScenarioConfigCopyWithImpl(this._self, this._then);

  final _ScenarioConfig _self;
  final $Res Function(_ScenarioConfig) _then;

/// Create a copy of ScenarioConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? initialCash = null,Object? baseSalary = null,Object? monthlyRent = null,Object? monthlyExpenses = null,Object? initialAssets = null,Object? initialLoans = null,Object? familySupportExpense = null,Object? startAgeInMonths = null,Object? startCalendarMonth = null,Object? initialCreditScore = null,Object? housingLevel = null,Object? country = null,Object? currency = null,Object? bankruptcyMonthsThreshold = null,Object? leisureCostPerStressPoint = null,Object? maxLeisureStressReliefPerMonth = null,Object? baseEventChance = null,}) {
  return _then(_ScenarioConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,initialCash: null == initialCash ? _self.initialCash : initialCash // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,initialAssets: null == initialAssets ? _self._initialAssets : initialAssets // ignore: cast_nullable_to_non_nullable
as List<Asset>,initialLoans: null == initialLoans ? _self._initialLoans : initialLoans // ignore: cast_nullable_to_non_nullable
as List<Loan>,familySupportExpense: null == familySupportExpense ? _self.familySupportExpense : familySupportExpense // ignore: cast_nullable_to_non_nullable
as double,startAgeInMonths: null == startAgeInMonths ? _self.startAgeInMonths : startAgeInMonths // ignore: cast_nullable_to_non_nullable
as int,startCalendarMonth: null == startCalendarMonth ? _self.startCalendarMonth : startCalendarMonth // ignore: cast_nullable_to_non_nullable
as int,initialCreditScore: null == initialCreditScore ? _self.initialCreditScore : initialCreditScore // ignore: cast_nullable_to_non_nullable
as int,housingLevel: null == housingLevel ? _self.housingLevel : housingLevel // ignore: cast_nullable_to_non_nullable
as HousingLevel,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,bankruptcyMonthsThreshold: null == bankruptcyMonthsThreshold ? _self.bankruptcyMonthsThreshold : bankruptcyMonthsThreshold // ignore: cast_nullable_to_non_nullable
as int,leisureCostPerStressPoint: null == leisureCostPerStressPoint ? _self.leisureCostPerStressPoint : leisureCostPerStressPoint // ignore: cast_nullable_to_non_nullable
as double,maxLeisureStressReliefPerMonth: null == maxLeisureStressReliefPerMonth ? _self.maxLeisureStressReliefPerMonth : maxLeisureStressReliefPerMonth // ignore: cast_nullable_to_non_nullable
as int,baseEventChance: null == baseEventChance ? _self.baseEventChance : baseEventChance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
