// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_proceed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendingProceed {

 double get amount; int get monthsLeft;
/// Create a copy of PendingProceed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingProceedCopyWith<PendingProceed> get copyWith => _$PendingProceedCopyWithImpl<PendingProceed>(this as PendingProceed, _$identity);

  /// Serializes this PendingProceed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingProceed&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.monthsLeft, monthsLeft) || other.monthsLeft == monthsLeft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,monthsLeft);

@override
String toString() {
  return 'PendingProceed(amount: $amount, monthsLeft: $monthsLeft)';
}


}

/// @nodoc
abstract mixin class $PendingProceedCopyWith<$Res>  {
  factory $PendingProceedCopyWith(PendingProceed value, $Res Function(PendingProceed) _then) = _$PendingProceedCopyWithImpl;
@useResult
$Res call({
 double amount, int monthsLeft
});




}
/// @nodoc
class _$PendingProceedCopyWithImpl<$Res>
    implements $PendingProceedCopyWith<$Res> {
  _$PendingProceedCopyWithImpl(this._self, this._then);

  final PendingProceed _self;
  final $Res Function(PendingProceed) _then;

/// Create a copy of PendingProceed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? monthsLeft = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,monthsLeft: null == monthsLeft ? _self.monthsLeft : monthsLeft // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingProceed].
extension PendingProceedPatterns on PendingProceed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingProceed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingProceed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingProceed value)  $default,){
final _that = this;
switch (_that) {
case _PendingProceed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingProceed value)?  $default,){
final _that = this;
switch (_that) {
case _PendingProceed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  int monthsLeft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingProceed() when $default != null:
return $default(_that.amount,_that.monthsLeft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  int monthsLeft)  $default,) {final _that = this;
switch (_that) {
case _PendingProceed():
return $default(_that.amount,_that.monthsLeft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  int monthsLeft)?  $default,) {final _that = this;
switch (_that) {
case _PendingProceed() when $default != null:
return $default(_that.amount,_that.monthsLeft);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingProceed implements PendingProceed {
  const _PendingProceed({required this.amount, required this.monthsLeft});
  factory _PendingProceed.fromJson(Map<String, dynamic> json) => _$PendingProceedFromJson(json);

@override final  double amount;
@override final  int monthsLeft;

/// Create a copy of PendingProceed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingProceedCopyWith<_PendingProceed> get copyWith => __$PendingProceedCopyWithImpl<_PendingProceed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingProceedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingProceed&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.monthsLeft, monthsLeft) || other.monthsLeft == monthsLeft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,monthsLeft);

@override
String toString() {
  return 'PendingProceed(amount: $amount, monthsLeft: $monthsLeft)';
}


}

/// @nodoc
abstract mixin class _$PendingProceedCopyWith<$Res> implements $PendingProceedCopyWith<$Res> {
  factory _$PendingProceedCopyWith(_PendingProceed value, $Res Function(_PendingProceed) _then) = __$PendingProceedCopyWithImpl;
@override @useResult
$Res call({
 double amount, int monthsLeft
});




}
/// @nodoc
class __$PendingProceedCopyWithImpl<$Res>
    implements _$PendingProceedCopyWith<$Res> {
  __$PendingProceedCopyWithImpl(this._self, this._then);

  final _PendingProceed _self;
  final $Res Function(_PendingProceed) _then;

/// Create a copy of PendingProceed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? monthsLeft = null,}) {
  return _then(_PendingProceed(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,monthsLeft: null == monthsLeft ? _self.monthsLeft : monthsLeft // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
