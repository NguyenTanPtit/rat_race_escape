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

 double get initialCash; double get baseSalary; double get monthlyRent; List<Asset> get initialAssets; double get familySupportExpense;
/// Create a copy of ScenarioConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScenarioConfigCopyWith<ScenarioConfig> get copyWith => _$ScenarioConfigCopyWithImpl<ScenarioConfig>(this as ScenarioConfig, _$identity);

  /// Serializes this ScenarioConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScenarioConfig&&(identical(other.initialCash, initialCash) || other.initialCash == initialCash)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&const DeepCollectionEquality().equals(other.initialAssets, initialAssets)&&(identical(other.familySupportExpense, familySupportExpense) || other.familySupportExpense == familySupportExpense));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,initialCash,baseSalary,monthlyRent,const DeepCollectionEquality().hash(initialAssets),familySupportExpense);

@override
String toString() {
  return 'ScenarioConfig(initialCash: $initialCash, baseSalary: $baseSalary, monthlyRent: $monthlyRent, initialAssets: $initialAssets, familySupportExpense: $familySupportExpense)';
}


}

/// @nodoc
abstract mixin class $ScenarioConfigCopyWith<$Res>  {
  factory $ScenarioConfigCopyWith(ScenarioConfig value, $Res Function(ScenarioConfig) _then) = _$ScenarioConfigCopyWithImpl;
@useResult
$Res call({
 double initialCash, double baseSalary, double monthlyRent, List<Asset> initialAssets, double familySupportExpense
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
@pragma('vm:prefer-inline') @override $Res call({Object? initialCash = null,Object? baseSalary = null,Object? monthlyRent = null,Object? initialAssets = null,Object? familySupportExpense = null,}) {
  return _then(_self.copyWith(
initialCash: null == initialCash ? _self.initialCash : initialCash // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,initialAssets: null == initialAssets ? _self.initialAssets : initialAssets // ignore: cast_nullable_to_non_nullable
as List<Asset>,familySupportExpense: null == familySupportExpense ? _self.familySupportExpense : familySupportExpense // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double initialCash,  double baseSalary,  double monthlyRent,  List<Asset> initialAssets,  double familySupportExpense)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScenarioConfig() when $default != null:
return $default(_that.initialCash,_that.baseSalary,_that.monthlyRent,_that.initialAssets,_that.familySupportExpense);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double initialCash,  double baseSalary,  double monthlyRent,  List<Asset> initialAssets,  double familySupportExpense)  $default,) {final _that = this;
switch (_that) {
case _ScenarioConfig():
return $default(_that.initialCash,_that.baseSalary,_that.monthlyRent,_that.initialAssets,_that.familySupportExpense);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double initialCash,  double baseSalary,  double monthlyRent,  List<Asset> initialAssets,  double familySupportExpense)?  $default,) {final _that = this;
switch (_that) {
case _ScenarioConfig() when $default != null:
return $default(_that.initialCash,_that.baseSalary,_that.monthlyRent,_that.initialAssets,_that.familySupportExpense);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScenarioConfig implements ScenarioConfig {
  const _ScenarioConfig({required this.initialCash, required this.baseSalary, required this.monthlyRent, final  List<Asset> initialAssets = const [], this.familySupportExpense = 0.0}): _initialAssets = initialAssets;
  factory _ScenarioConfig.fromJson(Map<String, dynamic> json) => _$ScenarioConfigFromJson(json);

@override final  double initialCash;
@override final  double baseSalary;
@override final  double monthlyRent;
 final  List<Asset> _initialAssets;
@override@JsonKey() List<Asset> get initialAssets {
  if (_initialAssets is EqualUnmodifiableListView) return _initialAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialAssets);
}

@override@JsonKey() final  double familySupportExpense;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScenarioConfig&&(identical(other.initialCash, initialCash) || other.initialCash == initialCash)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&const DeepCollectionEquality().equals(other._initialAssets, _initialAssets)&&(identical(other.familySupportExpense, familySupportExpense) || other.familySupportExpense == familySupportExpense));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,initialCash,baseSalary,monthlyRent,const DeepCollectionEquality().hash(_initialAssets),familySupportExpense);

@override
String toString() {
  return 'ScenarioConfig(initialCash: $initialCash, baseSalary: $baseSalary, monthlyRent: $monthlyRent, initialAssets: $initialAssets, familySupportExpense: $familySupportExpense)';
}


}

/// @nodoc
abstract mixin class _$ScenarioConfigCopyWith<$Res> implements $ScenarioConfigCopyWith<$Res> {
  factory _$ScenarioConfigCopyWith(_ScenarioConfig value, $Res Function(_ScenarioConfig) _then) = __$ScenarioConfigCopyWithImpl;
@override @useResult
$Res call({
 double initialCash, double baseSalary, double monthlyRent, List<Asset> initialAssets, double familySupportExpense
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
@override @pragma('vm:prefer-inline') $Res call({Object? initialCash = null,Object? baseSalary = null,Object? monthlyRent = null,Object? initialAssets = null,Object? familySupportExpense = null,}) {
  return _then(_ScenarioConfig(
initialCash: null == initialCash ? _self.initialCash : initialCash // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,initialAssets: null == initialAssets ? _self._initialAssets : initialAssets // ignore: cast_nullable_to_non_nullable
as List<Asset>,familySupportExpense: null == familySupportExpense ? _self.familySupportExpense : familySupportExpense // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
