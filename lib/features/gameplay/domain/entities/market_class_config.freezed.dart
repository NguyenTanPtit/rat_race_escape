// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_class_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketClassConfig {

 String get id; String get name; AssetType get type; double get annualYieldRate;// % per year on base price 1.0
 double get monthlyDrift;// trend, % per month
 double get monthlyVolatility;// uniform noise amplitude, ± % per month
// Fraction of the gap to the trend price closed per month (0 = pure
// random walk). Keeps long-run prices anchored so yield-on-cost stays
// meaningful, and makes crashes recover gradually instead of forever.
 double get meanReversion; double get crashChance;// per month, only while regime is normal
 double get crashMonthlyDrift;// % per month while crashing (negative)
 int get crashMinMonths; int get crashMaxMonths; double get boomChance;// per month, only while regime is normal
 double get boomMonthlyDrift;// % per month while booming
 int get boomMinMonths; int get boomMaxMonths;
/// Create a copy of MarketClassConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketClassConfigCopyWith<MarketClassConfig> get copyWith => _$MarketClassConfigCopyWithImpl<MarketClassConfig>(this as MarketClassConfig, _$identity);

  /// Serializes this MarketClassConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketClassConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.annualYieldRate, annualYieldRate) || other.annualYieldRate == annualYieldRate)&&(identical(other.monthlyDrift, monthlyDrift) || other.monthlyDrift == monthlyDrift)&&(identical(other.monthlyVolatility, monthlyVolatility) || other.monthlyVolatility == monthlyVolatility)&&(identical(other.meanReversion, meanReversion) || other.meanReversion == meanReversion)&&(identical(other.crashChance, crashChance) || other.crashChance == crashChance)&&(identical(other.crashMonthlyDrift, crashMonthlyDrift) || other.crashMonthlyDrift == crashMonthlyDrift)&&(identical(other.crashMinMonths, crashMinMonths) || other.crashMinMonths == crashMinMonths)&&(identical(other.crashMaxMonths, crashMaxMonths) || other.crashMaxMonths == crashMaxMonths)&&(identical(other.boomChance, boomChance) || other.boomChance == boomChance)&&(identical(other.boomMonthlyDrift, boomMonthlyDrift) || other.boomMonthlyDrift == boomMonthlyDrift)&&(identical(other.boomMinMonths, boomMinMonths) || other.boomMinMonths == boomMinMonths)&&(identical(other.boomMaxMonths, boomMaxMonths) || other.boomMaxMonths == boomMaxMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,annualYieldRate,monthlyDrift,monthlyVolatility,meanReversion,crashChance,crashMonthlyDrift,crashMinMonths,crashMaxMonths,boomChance,boomMonthlyDrift,boomMinMonths,boomMaxMonths);

@override
String toString() {
  return 'MarketClassConfig(id: $id, name: $name, type: $type, annualYieldRate: $annualYieldRate, monthlyDrift: $monthlyDrift, monthlyVolatility: $monthlyVolatility, meanReversion: $meanReversion, crashChance: $crashChance, crashMonthlyDrift: $crashMonthlyDrift, crashMinMonths: $crashMinMonths, crashMaxMonths: $crashMaxMonths, boomChance: $boomChance, boomMonthlyDrift: $boomMonthlyDrift, boomMinMonths: $boomMinMonths, boomMaxMonths: $boomMaxMonths)';
}


}

/// @nodoc
abstract mixin class $MarketClassConfigCopyWith<$Res>  {
  factory $MarketClassConfigCopyWith(MarketClassConfig value, $Res Function(MarketClassConfig) _then) = _$MarketClassConfigCopyWithImpl;
@useResult
$Res call({
 String id, String name, AssetType type, double annualYieldRate, double monthlyDrift, double monthlyVolatility, double meanReversion, double crashChance, double crashMonthlyDrift, int crashMinMonths, int crashMaxMonths, double boomChance, double boomMonthlyDrift, int boomMinMonths, int boomMaxMonths
});




}
/// @nodoc
class _$MarketClassConfigCopyWithImpl<$Res>
    implements $MarketClassConfigCopyWith<$Res> {
  _$MarketClassConfigCopyWithImpl(this._self, this._then);

  final MarketClassConfig _self;
  final $Res Function(MarketClassConfig) _then;

/// Create a copy of MarketClassConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? annualYieldRate = null,Object? monthlyDrift = null,Object? monthlyVolatility = null,Object? meanReversion = null,Object? crashChance = null,Object? crashMonthlyDrift = null,Object? crashMinMonths = null,Object? crashMaxMonths = null,Object? boomChance = null,Object? boomMonthlyDrift = null,Object? boomMinMonths = null,Object? boomMaxMonths = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AssetType,annualYieldRate: null == annualYieldRate ? _self.annualYieldRate : annualYieldRate // ignore: cast_nullable_to_non_nullable
as double,monthlyDrift: null == monthlyDrift ? _self.monthlyDrift : monthlyDrift // ignore: cast_nullable_to_non_nullable
as double,monthlyVolatility: null == monthlyVolatility ? _self.monthlyVolatility : monthlyVolatility // ignore: cast_nullable_to_non_nullable
as double,meanReversion: null == meanReversion ? _self.meanReversion : meanReversion // ignore: cast_nullable_to_non_nullable
as double,crashChance: null == crashChance ? _self.crashChance : crashChance // ignore: cast_nullable_to_non_nullable
as double,crashMonthlyDrift: null == crashMonthlyDrift ? _self.crashMonthlyDrift : crashMonthlyDrift // ignore: cast_nullable_to_non_nullable
as double,crashMinMonths: null == crashMinMonths ? _self.crashMinMonths : crashMinMonths // ignore: cast_nullable_to_non_nullable
as int,crashMaxMonths: null == crashMaxMonths ? _self.crashMaxMonths : crashMaxMonths // ignore: cast_nullable_to_non_nullable
as int,boomChance: null == boomChance ? _self.boomChance : boomChance // ignore: cast_nullable_to_non_nullable
as double,boomMonthlyDrift: null == boomMonthlyDrift ? _self.boomMonthlyDrift : boomMonthlyDrift // ignore: cast_nullable_to_non_nullable
as double,boomMinMonths: null == boomMinMonths ? _self.boomMinMonths : boomMinMonths // ignore: cast_nullable_to_non_nullable
as int,boomMaxMonths: null == boomMaxMonths ? _self.boomMaxMonths : boomMaxMonths // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketClassConfig].
extension MarketClassConfigPatterns on MarketClassConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketClassConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketClassConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketClassConfig value)  $default,){
final _that = this;
switch (_that) {
case _MarketClassConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketClassConfig value)?  $default,){
final _that = this;
switch (_that) {
case _MarketClassConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  AssetType type,  double annualYieldRate,  double monthlyDrift,  double monthlyVolatility,  double meanReversion,  double crashChance,  double crashMonthlyDrift,  int crashMinMonths,  int crashMaxMonths,  double boomChance,  double boomMonthlyDrift,  int boomMinMonths,  int boomMaxMonths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketClassConfig() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.annualYieldRate,_that.monthlyDrift,_that.monthlyVolatility,_that.meanReversion,_that.crashChance,_that.crashMonthlyDrift,_that.crashMinMonths,_that.crashMaxMonths,_that.boomChance,_that.boomMonthlyDrift,_that.boomMinMonths,_that.boomMaxMonths);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  AssetType type,  double annualYieldRate,  double monthlyDrift,  double monthlyVolatility,  double meanReversion,  double crashChance,  double crashMonthlyDrift,  int crashMinMonths,  int crashMaxMonths,  double boomChance,  double boomMonthlyDrift,  int boomMinMonths,  int boomMaxMonths)  $default,) {final _that = this;
switch (_that) {
case _MarketClassConfig():
return $default(_that.id,_that.name,_that.type,_that.annualYieldRate,_that.monthlyDrift,_that.monthlyVolatility,_that.meanReversion,_that.crashChance,_that.crashMonthlyDrift,_that.crashMinMonths,_that.crashMaxMonths,_that.boomChance,_that.boomMonthlyDrift,_that.boomMinMonths,_that.boomMaxMonths);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  AssetType type,  double annualYieldRate,  double monthlyDrift,  double monthlyVolatility,  double meanReversion,  double crashChance,  double crashMonthlyDrift,  int crashMinMonths,  int crashMaxMonths,  double boomChance,  double boomMonthlyDrift,  int boomMinMonths,  int boomMaxMonths)?  $default,) {final _that = this;
switch (_that) {
case _MarketClassConfig() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.annualYieldRate,_that.monthlyDrift,_that.monthlyVolatility,_that.meanReversion,_that.crashChance,_that.crashMonthlyDrift,_that.crashMinMonths,_that.crashMaxMonths,_that.boomChance,_that.boomMonthlyDrift,_that.boomMinMonths,_that.boomMaxMonths);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketClassConfig implements MarketClassConfig {
  const _MarketClassConfig({required this.id, required this.name, this.type = AssetType.stock, required this.annualYieldRate, required this.monthlyDrift, required this.monthlyVolatility, this.meanReversion = 0.0, required this.crashChance, required this.crashMonthlyDrift, required this.crashMinMonths, required this.crashMaxMonths, required this.boomChance, required this.boomMonthlyDrift, required this.boomMinMonths, required this.boomMaxMonths});
  factory _MarketClassConfig.fromJson(Map<String, dynamic> json) => _$MarketClassConfigFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  AssetType type;
@override final  double annualYieldRate;
// % per year on base price 1.0
@override final  double monthlyDrift;
// trend, % per month
@override final  double monthlyVolatility;
// uniform noise amplitude, ± % per month
// Fraction of the gap to the trend price closed per month (0 = pure
// random walk). Keeps long-run prices anchored so yield-on-cost stays
// meaningful, and makes crashes recover gradually instead of forever.
@override@JsonKey() final  double meanReversion;
@override final  double crashChance;
// per month, only while regime is normal
@override final  double crashMonthlyDrift;
// % per month while crashing (negative)
@override final  int crashMinMonths;
@override final  int crashMaxMonths;
@override final  double boomChance;
// per month, only while regime is normal
@override final  double boomMonthlyDrift;
// % per month while booming
@override final  int boomMinMonths;
@override final  int boomMaxMonths;

/// Create a copy of MarketClassConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketClassConfigCopyWith<_MarketClassConfig> get copyWith => __$MarketClassConfigCopyWithImpl<_MarketClassConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketClassConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketClassConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.annualYieldRate, annualYieldRate) || other.annualYieldRate == annualYieldRate)&&(identical(other.monthlyDrift, monthlyDrift) || other.monthlyDrift == monthlyDrift)&&(identical(other.monthlyVolatility, monthlyVolatility) || other.monthlyVolatility == monthlyVolatility)&&(identical(other.meanReversion, meanReversion) || other.meanReversion == meanReversion)&&(identical(other.crashChance, crashChance) || other.crashChance == crashChance)&&(identical(other.crashMonthlyDrift, crashMonthlyDrift) || other.crashMonthlyDrift == crashMonthlyDrift)&&(identical(other.crashMinMonths, crashMinMonths) || other.crashMinMonths == crashMinMonths)&&(identical(other.crashMaxMonths, crashMaxMonths) || other.crashMaxMonths == crashMaxMonths)&&(identical(other.boomChance, boomChance) || other.boomChance == boomChance)&&(identical(other.boomMonthlyDrift, boomMonthlyDrift) || other.boomMonthlyDrift == boomMonthlyDrift)&&(identical(other.boomMinMonths, boomMinMonths) || other.boomMinMonths == boomMinMonths)&&(identical(other.boomMaxMonths, boomMaxMonths) || other.boomMaxMonths == boomMaxMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,annualYieldRate,monthlyDrift,monthlyVolatility,meanReversion,crashChance,crashMonthlyDrift,crashMinMonths,crashMaxMonths,boomChance,boomMonthlyDrift,boomMinMonths,boomMaxMonths);

@override
String toString() {
  return 'MarketClassConfig(id: $id, name: $name, type: $type, annualYieldRate: $annualYieldRate, monthlyDrift: $monthlyDrift, monthlyVolatility: $monthlyVolatility, meanReversion: $meanReversion, crashChance: $crashChance, crashMonthlyDrift: $crashMonthlyDrift, crashMinMonths: $crashMinMonths, crashMaxMonths: $crashMaxMonths, boomChance: $boomChance, boomMonthlyDrift: $boomMonthlyDrift, boomMinMonths: $boomMinMonths, boomMaxMonths: $boomMaxMonths)';
}


}

/// @nodoc
abstract mixin class _$MarketClassConfigCopyWith<$Res> implements $MarketClassConfigCopyWith<$Res> {
  factory _$MarketClassConfigCopyWith(_MarketClassConfig value, $Res Function(_MarketClassConfig) _then) = __$MarketClassConfigCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, AssetType type, double annualYieldRate, double monthlyDrift, double monthlyVolatility, double meanReversion, double crashChance, double crashMonthlyDrift, int crashMinMonths, int crashMaxMonths, double boomChance, double boomMonthlyDrift, int boomMinMonths, int boomMaxMonths
});




}
/// @nodoc
class __$MarketClassConfigCopyWithImpl<$Res>
    implements _$MarketClassConfigCopyWith<$Res> {
  __$MarketClassConfigCopyWithImpl(this._self, this._then);

  final _MarketClassConfig _self;
  final $Res Function(_MarketClassConfig) _then;

/// Create a copy of MarketClassConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? annualYieldRate = null,Object? monthlyDrift = null,Object? monthlyVolatility = null,Object? meanReversion = null,Object? crashChance = null,Object? crashMonthlyDrift = null,Object? crashMinMonths = null,Object? crashMaxMonths = null,Object? boomChance = null,Object? boomMonthlyDrift = null,Object? boomMinMonths = null,Object? boomMaxMonths = null,}) {
  return _then(_MarketClassConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AssetType,annualYieldRate: null == annualYieldRate ? _self.annualYieldRate : annualYieldRate // ignore: cast_nullable_to_non_nullable
as double,monthlyDrift: null == monthlyDrift ? _self.monthlyDrift : monthlyDrift // ignore: cast_nullable_to_non_nullable
as double,monthlyVolatility: null == monthlyVolatility ? _self.monthlyVolatility : monthlyVolatility // ignore: cast_nullable_to_non_nullable
as double,meanReversion: null == meanReversion ? _self.meanReversion : meanReversion // ignore: cast_nullable_to_non_nullable
as double,crashChance: null == crashChance ? _self.crashChance : crashChance // ignore: cast_nullable_to_non_nullable
as double,crashMonthlyDrift: null == crashMonthlyDrift ? _self.crashMonthlyDrift : crashMonthlyDrift // ignore: cast_nullable_to_non_nullable
as double,crashMinMonths: null == crashMinMonths ? _self.crashMinMonths : crashMinMonths // ignore: cast_nullable_to_non_nullable
as int,crashMaxMonths: null == crashMaxMonths ? _self.crashMaxMonths : crashMaxMonths // ignore: cast_nullable_to_non_nullable
as int,boomChance: null == boomChance ? _self.boomChance : boomChance // ignore: cast_nullable_to_non_nullable
as double,boomMonthlyDrift: null == boomMonthlyDrift ? _self.boomMonthlyDrift : boomMonthlyDrift // ignore: cast_nullable_to_non_nullable
as double,boomMinMonths: null == boomMinMonths ? _self.boomMinMonths : boomMinMonths // ignore: cast_nullable_to_non_nullable
as int,boomMaxMonths: null == boomMaxMonths ? _self.boomMaxMonths : boomMaxMonths // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
