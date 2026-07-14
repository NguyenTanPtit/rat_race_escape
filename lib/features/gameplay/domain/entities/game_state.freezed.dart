// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameState {

// 0. Bối cảnh Quốc gia & Tiền tệ
 Country get country; Currency get currency;// 1. Time
 int get currentMonth; int get ageInMonths;// Mặc định chung là 22 tuổi
 int get startCalendarMonth;// Tháng bắt đầu trong năm (1-12)
// 2. Financials (Bắt buộc phải khởi tạo tùy bối cảnh)
 double get cash; double get monthlyExpenses; double get baseSalary;// 3. Metrics
 int get stress; int get networkScore; int get creditScore;// 4. Visual States
 HousingLevel get housingLevel; List<String> get ownedItems;// 5. Active Event & Flags
 String? get currentEventId; Set<String> get flags;// 6. Inventories
 List<Asset> get assets; List<Loan> get loans;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&(identical(other.country, country) || other.country == country)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.currentMonth, currentMonth) || other.currentMonth == currentMonth)&&(identical(other.ageInMonths, ageInMonths) || other.ageInMonths == ageInMonths)&&(identical(other.startCalendarMonth, startCalendarMonth) || other.startCalendarMonth == startCalendarMonth)&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.networkScore, networkScore) || other.networkScore == networkScore)&&(identical(other.creditScore, creditScore) || other.creditScore == creditScore)&&(identical(other.housingLevel, housingLevel) || other.housingLevel == housingLevel)&&const DeepCollectionEquality().equals(other.ownedItems, ownedItems)&&(identical(other.currentEventId, currentEventId) || other.currentEventId == currentEventId)&&const DeepCollectionEquality().equals(other.flags, flags)&&const DeepCollectionEquality().equals(other.assets, assets)&&const DeepCollectionEquality().equals(other.loans, loans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,currency,currentMonth,ageInMonths,startCalendarMonth,cash,monthlyExpenses,baseSalary,stress,networkScore,creditScore,housingLevel,const DeepCollectionEquality().hash(ownedItems),currentEventId,const DeepCollectionEquality().hash(flags),const DeepCollectionEquality().hash(assets),const DeepCollectionEquality().hash(loans));

@override
String toString() {
  return 'GameState(country: $country, currency: $currency, currentMonth: $currentMonth, ageInMonths: $ageInMonths, startCalendarMonth: $startCalendarMonth, cash: $cash, monthlyExpenses: $monthlyExpenses, baseSalary: $baseSalary, stress: $stress, networkScore: $networkScore, creditScore: $creditScore, housingLevel: $housingLevel, ownedItems: $ownedItems, currentEventId: $currentEventId, flags: $flags, assets: $assets, loans: $loans)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 Country country, Currency currency, int currentMonth, int ageInMonths, int startCalendarMonth, double cash, double monthlyExpenses, double baseSalary, int stress, int networkScore, int creditScore, HousingLevel housingLevel, List<String> ownedItems, String? currentEventId, Set<String> flags, List<Asset> assets, List<Loan> loans
});




}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = null,Object? currency = null,Object? currentMonth = null,Object? ageInMonths = null,Object? startCalendarMonth = null,Object? cash = null,Object? monthlyExpenses = null,Object? baseSalary = null,Object? stress = null,Object? networkScore = null,Object? creditScore = null,Object? housingLevel = null,Object? ownedItems = null,Object? currentEventId = freezed,Object? flags = null,Object? assets = null,Object? loans = null,}) {
  return _then(_self.copyWith(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,currentMonth: null == currentMonth ? _self.currentMonth : currentMonth // ignore: cast_nullable_to_non_nullable
as int,ageInMonths: null == ageInMonths ? _self.ageInMonths : ageInMonths // ignore: cast_nullable_to_non_nullable
as int,startCalendarMonth: null == startCalendarMonth ? _self.startCalendarMonth : startCalendarMonth // ignore: cast_nullable_to_non_nullable
as int,cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,networkScore: null == networkScore ? _self.networkScore : networkScore // ignore: cast_nullable_to_non_nullable
as int,creditScore: null == creditScore ? _self.creditScore : creditScore // ignore: cast_nullable_to_non_nullable
as int,housingLevel: null == housingLevel ? _self.housingLevel : housingLevel // ignore: cast_nullable_to_non_nullable
as HousingLevel,ownedItems: null == ownedItems ? _self.ownedItems : ownedItems // ignore: cast_nullable_to_non_nullable
as List<String>,currentEventId: freezed == currentEventId ? _self.currentEventId : currentEventId // ignore: cast_nullable_to_non_nullable
as String?,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as Set<String>,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<Asset>,loans: null == loans ? _self.loans : loans // ignore: cast_nullable_to_non_nullable
as List<Loan>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Country country,  Currency currency,  int currentMonth,  int ageInMonths,  int startCalendarMonth,  double cash,  double monthlyExpenses,  double baseSalary,  int stress,  int networkScore,  int creditScore,  HousingLevel housingLevel,  List<String> ownedItems,  String? currentEventId,  Set<String> flags,  List<Asset> assets,  List<Loan> loans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.country,_that.currency,_that.currentMonth,_that.ageInMonths,_that.startCalendarMonth,_that.cash,_that.monthlyExpenses,_that.baseSalary,_that.stress,_that.networkScore,_that.creditScore,_that.housingLevel,_that.ownedItems,_that.currentEventId,_that.flags,_that.assets,_that.loans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Country country,  Currency currency,  int currentMonth,  int ageInMonths,  int startCalendarMonth,  double cash,  double monthlyExpenses,  double baseSalary,  int stress,  int networkScore,  int creditScore,  HousingLevel housingLevel,  List<String> ownedItems,  String? currentEventId,  Set<String> flags,  List<Asset> assets,  List<Loan> loans)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.country,_that.currency,_that.currentMonth,_that.ageInMonths,_that.startCalendarMonth,_that.cash,_that.monthlyExpenses,_that.baseSalary,_that.stress,_that.networkScore,_that.creditScore,_that.housingLevel,_that.ownedItems,_that.currentEventId,_that.flags,_that.assets,_that.loans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Country country,  Currency currency,  int currentMonth,  int ageInMonths,  int startCalendarMonth,  double cash,  double monthlyExpenses,  double baseSalary,  int stress,  int networkScore,  int creditScore,  HousingLevel housingLevel,  List<String> ownedItems,  String? currentEventId,  Set<String> flags,  List<Asset> assets,  List<Loan> loans)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.country,_that.currency,_that.currentMonth,_that.ageInMonths,_that.startCalendarMonth,_that.cash,_that.monthlyExpenses,_that.baseSalary,_that.stress,_that.networkScore,_that.creditScore,_that.housingLevel,_that.ownedItems,_that.currentEventId,_that.flags,_that.assets,_that.loans);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameState extends GameState {
  const _GameState({required this.country, required this.currency, this.currentMonth = 1, this.ageInMonths = 264, this.startCalendarMonth = 1, required this.cash, required this.monthlyExpenses, required this.baseSalary, this.stress = 0, this.networkScore = 0, this.creditScore = 600, this.housingLevel = HousingLevel.shabbyRoom, final  List<String> ownedItems = const [], this.currentEventId, final  Set<String> flags = const {}, final  List<Asset> assets = const [], final  List<Loan> loans = const []}): _ownedItems = ownedItems,_flags = flags,_assets = assets,_loans = loans,super._();
  factory _GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

// 0. Bối cảnh Quốc gia & Tiền tệ
@override final  Country country;
@override final  Currency currency;
// 1. Time
@override@JsonKey() final  int currentMonth;
@override@JsonKey() final  int ageInMonths;
// Mặc định chung là 22 tuổi
@override@JsonKey() final  int startCalendarMonth;
// Tháng bắt đầu trong năm (1-12)
// 2. Financials (Bắt buộc phải khởi tạo tùy bối cảnh)
@override final  double cash;
@override final  double monthlyExpenses;
@override final  double baseSalary;
// 3. Metrics
@override@JsonKey() final  int stress;
@override@JsonKey() final  int networkScore;
@override@JsonKey() final  int creditScore;
// 4. Visual States
@override@JsonKey() final  HousingLevel housingLevel;
 final  List<String> _ownedItems;
@override@JsonKey() List<String> get ownedItems {
  if (_ownedItems is EqualUnmodifiableListView) return _ownedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedItems);
}

// 5. Active Event & Flags
@override final  String? currentEventId;
 final  Set<String> _flags;
@override@JsonKey() Set<String> get flags {
  if (_flags is EqualUnmodifiableSetView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_flags);
}

// 6. Inventories
 final  List<Asset> _assets;
// 6. Inventories
@override@JsonKey() List<Asset> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<Loan> _loans;
@override@JsonKey() List<Loan> get loans {
  if (_loans is EqualUnmodifiableListView) return _loans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_loans);
}


/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&(identical(other.country, country) || other.country == country)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.currentMonth, currentMonth) || other.currentMonth == currentMonth)&&(identical(other.ageInMonths, ageInMonths) || other.ageInMonths == ageInMonths)&&(identical(other.startCalendarMonth, startCalendarMonth) || other.startCalendarMonth == startCalendarMonth)&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.networkScore, networkScore) || other.networkScore == networkScore)&&(identical(other.creditScore, creditScore) || other.creditScore == creditScore)&&(identical(other.housingLevel, housingLevel) || other.housingLevel == housingLevel)&&const DeepCollectionEquality().equals(other._ownedItems, _ownedItems)&&(identical(other.currentEventId, currentEventId) || other.currentEventId == currentEventId)&&const DeepCollectionEquality().equals(other._flags, _flags)&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._loans, _loans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,country,currency,currentMonth,ageInMonths,startCalendarMonth,cash,monthlyExpenses,baseSalary,stress,networkScore,creditScore,housingLevel,const DeepCollectionEquality().hash(_ownedItems),currentEventId,const DeepCollectionEquality().hash(_flags),const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_loans));

@override
String toString() {
  return 'GameState(country: $country, currency: $currency, currentMonth: $currentMonth, ageInMonths: $ageInMonths, startCalendarMonth: $startCalendarMonth, cash: $cash, monthlyExpenses: $monthlyExpenses, baseSalary: $baseSalary, stress: $stress, networkScore: $networkScore, creditScore: $creditScore, housingLevel: $housingLevel, ownedItems: $ownedItems, currentEventId: $currentEventId, flags: $flags, assets: $assets, loans: $loans)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 Country country, Currency currency, int currentMonth, int ageInMonths, int startCalendarMonth, double cash, double monthlyExpenses, double baseSalary, int stress, int networkScore, int creditScore, HousingLevel housingLevel, List<String> ownedItems, String? currentEventId, Set<String> flags, List<Asset> assets, List<Loan> loans
});




}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = null,Object? currency = null,Object? currentMonth = null,Object? ageInMonths = null,Object? startCalendarMonth = null,Object? cash = null,Object? monthlyExpenses = null,Object? baseSalary = null,Object? stress = null,Object? networkScore = null,Object? creditScore = null,Object? housingLevel = null,Object? ownedItems = null,Object? currentEventId = freezed,Object? flags = null,Object? assets = null,Object? loans = null,}) {
  return _then(_GameState(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,currentMonth: null == currentMonth ? _self.currentMonth : currentMonth // ignore: cast_nullable_to_non_nullable
as int,ageInMonths: null == ageInMonths ? _self.ageInMonths : ageInMonths // ignore: cast_nullable_to_non_nullable
as int,startCalendarMonth: null == startCalendarMonth ? _self.startCalendarMonth : startCalendarMonth // ignore: cast_nullable_to_non_nullable
as int,cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,networkScore: null == networkScore ? _self.networkScore : networkScore // ignore: cast_nullable_to_non_nullable
as int,creditScore: null == creditScore ? _self.creditScore : creditScore // ignore: cast_nullable_to_non_nullable
as int,housingLevel: null == housingLevel ? _self.housingLevel : housingLevel // ignore: cast_nullable_to_non_nullable
as HousingLevel,ownedItems: null == ownedItems ? _self._ownedItems : ownedItems // ignore: cast_nullable_to_non_nullable
as List<String>,currentEventId: freezed == currentEventId ? _self.currentEventId : currentEventId // ignore: cast_nullable_to_non_nullable
as String?,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as Set<String>,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<Asset>,loans: null == loans ? _self._loans : loans // ignore: cast_nullable_to_non_nullable
as List<Loan>,
  ));
}


}

// dart format on
