// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseConfig {

 String get id; String get name; double get baseCost;// real price; multiply by inflationIndex to buy
 int get durationMonths; int get stressPerMonth;// added every month while studying
 double get salaryBoostRate;
/// Create a copy of CourseConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseConfigCopyWith<CourseConfig> get copyWith => _$CourseConfigCopyWithImpl<CourseConfig>(this as CourseConfig, _$identity);

  /// Serializes this CourseConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.baseCost, baseCost) || other.baseCost == baseCost)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.stressPerMonth, stressPerMonth) || other.stressPerMonth == stressPerMonth)&&(identical(other.salaryBoostRate, salaryBoostRate) || other.salaryBoostRate == salaryBoostRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,baseCost,durationMonths,stressPerMonth,salaryBoostRate);

@override
String toString() {
  return 'CourseConfig(id: $id, name: $name, baseCost: $baseCost, durationMonths: $durationMonths, stressPerMonth: $stressPerMonth, salaryBoostRate: $salaryBoostRate)';
}


}

/// @nodoc
abstract mixin class $CourseConfigCopyWith<$Res>  {
  factory $CourseConfigCopyWith(CourseConfig value, $Res Function(CourseConfig) _then) = _$CourseConfigCopyWithImpl;
@useResult
$Res call({
 String id, String name, double baseCost, int durationMonths, int stressPerMonth, double salaryBoostRate
});




}
/// @nodoc
class _$CourseConfigCopyWithImpl<$Res>
    implements $CourseConfigCopyWith<$Res> {
  _$CourseConfigCopyWithImpl(this._self, this._then);

  final CourseConfig _self;
  final $Res Function(CourseConfig) _then;

/// Create a copy of CourseConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? baseCost = null,Object? durationMonths = null,Object? stressPerMonth = null,Object? salaryBoostRate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseCost: null == baseCost ? _self.baseCost : baseCost // ignore: cast_nullable_to_non_nullable
as double,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,stressPerMonth: null == stressPerMonth ? _self.stressPerMonth : stressPerMonth // ignore: cast_nullable_to_non_nullable
as int,salaryBoostRate: null == salaryBoostRate ? _self.salaryBoostRate : salaryBoostRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseConfig].
extension CourseConfigPatterns on CourseConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseConfig value)  $default,){
final _that = this;
switch (_that) {
case _CourseConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseConfig value)?  $default,){
final _that = this;
switch (_that) {
case _CourseConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double baseCost,  int durationMonths,  int stressPerMonth,  double salaryBoostRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseConfig() when $default != null:
return $default(_that.id,_that.name,_that.baseCost,_that.durationMonths,_that.stressPerMonth,_that.salaryBoostRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double baseCost,  int durationMonths,  int stressPerMonth,  double salaryBoostRate)  $default,) {final _that = this;
switch (_that) {
case _CourseConfig():
return $default(_that.id,_that.name,_that.baseCost,_that.durationMonths,_that.stressPerMonth,_that.salaryBoostRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double baseCost,  int durationMonths,  int stressPerMonth,  double salaryBoostRate)?  $default,) {final _that = this;
switch (_that) {
case _CourseConfig() when $default != null:
return $default(_that.id,_that.name,_that.baseCost,_that.durationMonths,_that.stressPerMonth,_that.salaryBoostRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseConfig implements CourseConfig {
  const _CourseConfig({required this.id, required this.name, required this.baseCost, required this.durationMonths, required this.stressPerMonth, required this.salaryBoostRate});
  factory _CourseConfig.fromJson(Map<String, dynamic> json) => _$CourseConfigFromJson(json);

@override final  String id;
@override final  String name;
@override final  double baseCost;
// real price; multiply by inflationIndex to buy
@override final  int durationMonths;
@override final  int stressPerMonth;
// added every month while studying
@override final  double salaryBoostRate;

/// Create a copy of CourseConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseConfigCopyWith<_CourseConfig> get copyWith => __$CourseConfigCopyWithImpl<_CourseConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.baseCost, baseCost) || other.baseCost == baseCost)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.stressPerMonth, stressPerMonth) || other.stressPerMonth == stressPerMonth)&&(identical(other.salaryBoostRate, salaryBoostRate) || other.salaryBoostRate == salaryBoostRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,baseCost,durationMonths,stressPerMonth,salaryBoostRate);

@override
String toString() {
  return 'CourseConfig(id: $id, name: $name, baseCost: $baseCost, durationMonths: $durationMonths, stressPerMonth: $stressPerMonth, salaryBoostRate: $salaryBoostRate)';
}


}

/// @nodoc
abstract mixin class _$CourseConfigCopyWith<$Res> implements $CourseConfigCopyWith<$Res> {
  factory _$CourseConfigCopyWith(_CourseConfig value, $Res Function(_CourseConfig) _then) = __$CourseConfigCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double baseCost, int durationMonths, int stressPerMonth, double salaryBoostRate
});




}
/// @nodoc
class __$CourseConfigCopyWithImpl<$Res>
    implements _$CourseConfigCopyWith<$Res> {
  __$CourseConfigCopyWithImpl(this._self, this._then);

  final _CourseConfig _self;
  final $Res Function(_CourseConfig) _then;

/// Create a copy of CourseConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? baseCost = null,Object? durationMonths = null,Object? stressPerMonth = null,Object? salaryBoostRate = null,}) {
  return _then(_CourseConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseCost: null == baseCost ? _self.baseCost : baseCost // ignore: cast_nullable_to_non_nullable
as double,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,stressPerMonth: null == stressPerMonth ? _self.stressPerMonth : stressPerMonth // ignore: cast_nullable_to_non_nullable
as int,salaryBoostRate: null == salaryBoostRate ? _self.salaryBoostRate : salaryBoostRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
