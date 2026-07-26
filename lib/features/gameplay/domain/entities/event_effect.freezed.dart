// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketBuyFraction {

 String get classId; double get fraction;
/// Create a copy of MarketBuyFraction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketBuyFractionCopyWith<MarketBuyFraction> get copyWith => _$MarketBuyFractionCopyWithImpl<MarketBuyFraction>(this as MarketBuyFraction, _$identity);

  /// Serializes this MarketBuyFraction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketBuyFraction&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.fraction, fraction) || other.fraction == fraction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,fraction);

@override
String toString() {
  return 'MarketBuyFraction(classId: $classId, fraction: $fraction)';
}


}

/// @nodoc
abstract mixin class $MarketBuyFractionCopyWith<$Res>  {
  factory $MarketBuyFractionCopyWith(MarketBuyFraction value, $Res Function(MarketBuyFraction) _then) = _$MarketBuyFractionCopyWithImpl;
@useResult
$Res call({
 String classId, double fraction
});




}
/// @nodoc
class _$MarketBuyFractionCopyWithImpl<$Res>
    implements $MarketBuyFractionCopyWith<$Res> {
  _$MarketBuyFractionCopyWithImpl(this._self, this._then);

  final MarketBuyFraction _self;
  final $Res Function(MarketBuyFraction) _then;

/// Create a copy of MarketBuyFraction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? fraction = null,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,fraction: null == fraction ? _self.fraction : fraction // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketBuyFraction].
extension MarketBuyFractionPatterns on MarketBuyFraction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketBuyFraction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketBuyFraction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketBuyFraction value)  $default,){
final _that = this;
switch (_that) {
case _MarketBuyFraction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketBuyFraction value)?  $default,){
final _that = this;
switch (_that) {
case _MarketBuyFraction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classId,  double fraction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketBuyFraction() when $default != null:
return $default(_that.classId,_that.fraction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classId,  double fraction)  $default,) {final _that = this;
switch (_that) {
case _MarketBuyFraction():
return $default(_that.classId,_that.fraction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classId,  double fraction)?  $default,) {final _that = this;
switch (_that) {
case _MarketBuyFraction() when $default != null:
return $default(_that.classId,_that.fraction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketBuyFraction implements MarketBuyFraction {
  const _MarketBuyFraction({required this.classId, required this.fraction});
  factory _MarketBuyFraction.fromJson(Map<String, dynamic> json) => _$MarketBuyFractionFromJson(json);

@override final  String classId;
@override final  double fraction;

/// Create a copy of MarketBuyFraction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketBuyFractionCopyWith<_MarketBuyFraction> get copyWith => __$MarketBuyFractionCopyWithImpl<_MarketBuyFraction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketBuyFractionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketBuyFraction&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.fraction, fraction) || other.fraction == fraction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,fraction);

@override
String toString() {
  return 'MarketBuyFraction(classId: $classId, fraction: $fraction)';
}


}

/// @nodoc
abstract mixin class _$MarketBuyFractionCopyWith<$Res> implements $MarketBuyFractionCopyWith<$Res> {
  factory _$MarketBuyFractionCopyWith(_MarketBuyFraction value, $Res Function(_MarketBuyFraction) _then) = __$MarketBuyFractionCopyWithImpl;
@override @useResult
$Res call({
 String classId, double fraction
});




}
/// @nodoc
class __$MarketBuyFractionCopyWithImpl<$Res>
    implements _$MarketBuyFractionCopyWith<$Res> {
  __$MarketBuyFractionCopyWithImpl(this._self, this._then);

  final _MarketBuyFraction _self;
  final $Res Function(_MarketBuyFraction) _then;

/// Create a copy of MarketBuyFraction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? fraction = null,}) {
  return _then(_MarketBuyFraction(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,fraction: null == fraction ? _self.fraction : fraction // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MarketBuyDiscount {

 String get classId; double get amount; double get discount;
/// Create a copy of MarketBuyDiscount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketBuyDiscountCopyWith<MarketBuyDiscount> get copyWith => _$MarketBuyDiscountCopyWithImpl<MarketBuyDiscount>(this as MarketBuyDiscount, _$identity);

  /// Serializes this MarketBuyDiscount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketBuyDiscount&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.discount, discount) || other.discount == discount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,amount,discount);

@override
String toString() {
  return 'MarketBuyDiscount(classId: $classId, amount: $amount, discount: $discount)';
}


}

/// @nodoc
abstract mixin class $MarketBuyDiscountCopyWith<$Res>  {
  factory $MarketBuyDiscountCopyWith(MarketBuyDiscount value, $Res Function(MarketBuyDiscount) _then) = _$MarketBuyDiscountCopyWithImpl;
@useResult
$Res call({
 String classId, double amount, double discount
});




}
/// @nodoc
class _$MarketBuyDiscountCopyWithImpl<$Res>
    implements $MarketBuyDiscountCopyWith<$Res> {
  _$MarketBuyDiscountCopyWithImpl(this._self, this._then);

  final MarketBuyDiscount _self;
  final $Res Function(MarketBuyDiscount) _then;

/// Create a copy of MarketBuyDiscount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? amount = null,Object? discount = null,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketBuyDiscount].
extension MarketBuyDiscountPatterns on MarketBuyDiscount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketBuyDiscount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketBuyDiscount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketBuyDiscount value)  $default,){
final _that = this;
switch (_that) {
case _MarketBuyDiscount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketBuyDiscount value)?  $default,){
final _that = this;
switch (_that) {
case _MarketBuyDiscount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classId,  double amount,  double discount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketBuyDiscount() when $default != null:
return $default(_that.classId,_that.amount,_that.discount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classId,  double amount,  double discount)  $default,) {final _that = this;
switch (_that) {
case _MarketBuyDiscount():
return $default(_that.classId,_that.amount,_that.discount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classId,  double amount,  double discount)?  $default,) {final _that = this;
switch (_that) {
case _MarketBuyDiscount() when $default != null:
return $default(_that.classId,_that.amount,_that.discount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketBuyDiscount implements MarketBuyDiscount {
  const _MarketBuyDiscount({required this.classId, required this.amount, required this.discount});
  factory _MarketBuyDiscount.fromJson(Map<String, dynamic> json) => _$MarketBuyDiscountFromJson(json);

@override final  String classId;
@override final  double amount;
@override final  double discount;

/// Create a copy of MarketBuyDiscount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketBuyDiscountCopyWith<_MarketBuyDiscount> get copyWith => __$MarketBuyDiscountCopyWithImpl<_MarketBuyDiscount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketBuyDiscountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketBuyDiscount&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.discount, discount) || other.discount == discount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,amount,discount);

@override
String toString() {
  return 'MarketBuyDiscount(classId: $classId, amount: $amount, discount: $discount)';
}


}

/// @nodoc
abstract mixin class _$MarketBuyDiscountCopyWith<$Res> implements $MarketBuyDiscountCopyWith<$Res> {
  factory _$MarketBuyDiscountCopyWith(_MarketBuyDiscount value, $Res Function(_MarketBuyDiscount) _then) = __$MarketBuyDiscountCopyWithImpl;
@override @useResult
$Res call({
 String classId, double amount, double discount
});




}
/// @nodoc
class __$MarketBuyDiscountCopyWithImpl<$Res>
    implements _$MarketBuyDiscountCopyWith<$Res> {
  __$MarketBuyDiscountCopyWithImpl(this._self, this._then);

  final _MarketBuyDiscount _self;
  final $Res Function(_MarketBuyDiscount) _then;

/// Create a copy of MarketBuyDiscount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? amount = null,Object? discount = null,}) {
  return _then(_MarketBuyDiscount(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ForceMarketCrash {

 List<String> get classIds; int get minMonths; int get maxMonths;
/// Create a copy of ForceMarketCrash
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForceMarketCrashCopyWith<ForceMarketCrash> get copyWith => _$ForceMarketCrashCopyWithImpl<ForceMarketCrash>(this as ForceMarketCrash, _$identity);

  /// Serializes this ForceMarketCrash to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForceMarketCrash&&const DeepCollectionEquality().equals(other.classIds, classIds)&&(identical(other.minMonths, minMonths) || other.minMonths == minMonths)&&(identical(other.maxMonths, maxMonths) || other.maxMonths == maxMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(classIds),minMonths,maxMonths);

@override
String toString() {
  return 'ForceMarketCrash(classIds: $classIds, minMonths: $minMonths, maxMonths: $maxMonths)';
}


}

/// @nodoc
abstract mixin class $ForceMarketCrashCopyWith<$Res>  {
  factory $ForceMarketCrashCopyWith(ForceMarketCrash value, $Res Function(ForceMarketCrash) _then) = _$ForceMarketCrashCopyWithImpl;
@useResult
$Res call({
 List<String> classIds, int minMonths, int maxMonths
});




}
/// @nodoc
class _$ForceMarketCrashCopyWithImpl<$Res>
    implements $ForceMarketCrashCopyWith<$Res> {
  _$ForceMarketCrashCopyWithImpl(this._self, this._then);

  final ForceMarketCrash _self;
  final $Res Function(ForceMarketCrash) _then;

/// Create a copy of ForceMarketCrash
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classIds = null,Object? minMonths = null,Object? maxMonths = null,}) {
  return _then(_self.copyWith(
classIds: null == classIds ? _self.classIds : classIds // ignore: cast_nullable_to_non_nullable
as List<String>,minMonths: null == minMonths ? _self.minMonths : minMonths // ignore: cast_nullable_to_non_nullable
as int,maxMonths: null == maxMonths ? _self.maxMonths : maxMonths // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ForceMarketCrash].
extension ForceMarketCrashPatterns on ForceMarketCrash {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForceMarketCrash value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForceMarketCrash() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForceMarketCrash value)  $default,){
final _that = this;
switch (_that) {
case _ForceMarketCrash():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForceMarketCrash value)?  $default,){
final _that = this;
switch (_that) {
case _ForceMarketCrash() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> classIds,  int minMonths,  int maxMonths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForceMarketCrash() when $default != null:
return $default(_that.classIds,_that.minMonths,_that.maxMonths);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> classIds,  int minMonths,  int maxMonths)  $default,) {final _that = this;
switch (_that) {
case _ForceMarketCrash():
return $default(_that.classIds,_that.minMonths,_that.maxMonths);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> classIds,  int minMonths,  int maxMonths)?  $default,) {final _that = this;
switch (_that) {
case _ForceMarketCrash() when $default != null:
return $default(_that.classIds,_that.minMonths,_that.maxMonths);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForceMarketCrash implements ForceMarketCrash {
  const _ForceMarketCrash({required final  List<String> classIds, required this.minMonths, required this.maxMonths}): _classIds = classIds;
  factory _ForceMarketCrash.fromJson(Map<String, dynamic> json) => _$ForceMarketCrashFromJson(json);

 final  List<String> _classIds;
@override List<String> get classIds {
  if (_classIds is EqualUnmodifiableListView) return _classIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classIds);
}

@override final  int minMonths;
@override final  int maxMonths;

/// Create a copy of ForceMarketCrash
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForceMarketCrashCopyWith<_ForceMarketCrash> get copyWith => __$ForceMarketCrashCopyWithImpl<_ForceMarketCrash>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForceMarketCrashToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForceMarketCrash&&const DeepCollectionEquality().equals(other._classIds, _classIds)&&(identical(other.minMonths, minMonths) || other.minMonths == minMonths)&&(identical(other.maxMonths, maxMonths) || other.maxMonths == maxMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_classIds),minMonths,maxMonths);

@override
String toString() {
  return 'ForceMarketCrash(classIds: $classIds, minMonths: $minMonths, maxMonths: $maxMonths)';
}


}

/// @nodoc
abstract mixin class _$ForceMarketCrashCopyWith<$Res> implements $ForceMarketCrashCopyWith<$Res> {
  factory _$ForceMarketCrashCopyWith(_ForceMarketCrash value, $Res Function(_ForceMarketCrash) _then) = __$ForceMarketCrashCopyWithImpl;
@override @useResult
$Res call({
 List<String> classIds, int minMonths, int maxMonths
});




}
/// @nodoc
class __$ForceMarketCrashCopyWithImpl<$Res>
    implements _$ForceMarketCrashCopyWith<$Res> {
  __$ForceMarketCrashCopyWithImpl(this._self, this._then);

  final _ForceMarketCrash _self;
  final $Res Function(_ForceMarketCrash) _then;

/// Create a copy of ForceMarketCrash
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classIds = null,Object? minMonths = null,Object? maxMonths = null,}) {
  return _then(_ForceMarketCrash(
classIds: null == classIds ? _self._classIds : classIds // ignore: cast_nullable_to_non_nullable
as List<String>,minMonths: null == minMonths ? _self.minMonths : minMonths // ignore: cast_nullable_to_non_nullable
as int,maxMonths: null == maxMonths ? _self.maxMonths : maxMonths // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EventEffect {

 double get cash; int get stress; int get network; int get credit; List<Loan> get addedLoans; List<Asset> get addedAssets; List<String> get addedFlags; List<String> get removedFlags; String? get insightCardId; double get salaryDelta; double get monthlyExpensesDelta; double get cashBySalaryMultiplier; double get cashByOutflowMultiplier;// 6.2b: shocks, insurance and market-coupled effects
 double? get cashIfInsured;// replaces `cash` when the player has health insurance
 int get salarySuspendedMonths;// job loss: months without salary
 List<String> get marketSellAllClassIds;// panic sell, at market price + fee
 MarketBuyFraction? get marketBuyCashFraction; MarketBuyDiscount? get marketBuyDiscount; ForceMarketCrash? get forceMarketCrash;
/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEffectCopyWith<EventEffect> get copyWith => _$EventEffectCopyWithImpl<EventEffect>(this as EventEffect, _$identity);

  /// Serializes this EventEffect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEffect&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.network, network) || other.network == network)&&(identical(other.credit, credit) || other.credit == credit)&&const DeepCollectionEquality().equals(other.addedLoans, addedLoans)&&const DeepCollectionEquality().equals(other.addedAssets, addedAssets)&&const DeepCollectionEquality().equals(other.addedFlags, addedFlags)&&const DeepCollectionEquality().equals(other.removedFlags, removedFlags)&&(identical(other.insightCardId, insightCardId) || other.insightCardId == insightCardId)&&(identical(other.salaryDelta, salaryDelta) || other.salaryDelta == salaryDelta)&&(identical(other.monthlyExpensesDelta, monthlyExpensesDelta) || other.monthlyExpensesDelta == monthlyExpensesDelta)&&(identical(other.cashBySalaryMultiplier, cashBySalaryMultiplier) || other.cashBySalaryMultiplier == cashBySalaryMultiplier)&&(identical(other.cashByOutflowMultiplier, cashByOutflowMultiplier) || other.cashByOutflowMultiplier == cashByOutflowMultiplier)&&(identical(other.cashIfInsured, cashIfInsured) || other.cashIfInsured == cashIfInsured)&&(identical(other.salarySuspendedMonths, salarySuspendedMonths) || other.salarySuspendedMonths == salarySuspendedMonths)&&const DeepCollectionEquality().equals(other.marketSellAllClassIds, marketSellAllClassIds)&&(identical(other.marketBuyCashFraction, marketBuyCashFraction) || other.marketBuyCashFraction == marketBuyCashFraction)&&(identical(other.marketBuyDiscount, marketBuyDiscount) || other.marketBuyDiscount == marketBuyDiscount)&&(identical(other.forceMarketCrash, forceMarketCrash) || other.forceMarketCrash == forceMarketCrash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,cash,stress,network,credit,const DeepCollectionEquality().hash(addedLoans),const DeepCollectionEquality().hash(addedAssets),const DeepCollectionEquality().hash(addedFlags),const DeepCollectionEquality().hash(removedFlags),insightCardId,salaryDelta,monthlyExpensesDelta,cashBySalaryMultiplier,cashByOutflowMultiplier,cashIfInsured,salarySuspendedMonths,const DeepCollectionEquality().hash(marketSellAllClassIds),marketBuyCashFraction,marketBuyDiscount,forceMarketCrash]);

@override
String toString() {
  return 'EventEffect(cash: $cash, stress: $stress, network: $network, credit: $credit, addedLoans: $addedLoans, addedAssets: $addedAssets, addedFlags: $addedFlags, removedFlags: $removedFlags, insightCardId: $insightCardId, salaryDelta: $salaryDelta, monthlyExpensesDelta: $monthlyExpensesDelta, cashBySalaryMultiplier: $cashBySalaryMultiplier, cashByOutflowMultiplier: $cashByOutflowMultiplier, cashIfInsured: $cashIfInsured, salarySuspendedMonths: $salarySuspendedMonths, marketSellAllClassIds: $marketSellAllClassIds, marketBuyCashFraction: $marketBuyCashFraction, marketBuyDiscount: $marketBuyDiscount, forceMarketCrash: $forceMarketCrash)';
}


}

/// @nodoc
abstract mixin class $EventEffectCopyWith<$Res>  {
  factory $EventEffectCopyWith(EventEffect value, $Res Function(EventEffect) _then) = _$EventEffectCopyWithImpl;
@useResult
$Res call({
 double cash, int stress, int network, int credit, List<Loan> addedLoans, List<Asset> addedAssets, List<String> addedFlags, List<String> removedFlags, String? insightCardId, double salaryDelta, double monthlyExpensesDelta, double cashBySalaryMultiplier, double cashByOutflowMultiplier, double? cashIfInsured, int salarySuspendedMonths, List<String> marketSellAllClassIds, MarketBuyFraction? marketBuyCashFraction, MarketBuyDiscount? marketBuyDiscount, ForceMarketCrash? forceMarketCrash
});


$MarketBuyFractionCopyWith<$Res>? get marketBuyCashFraction;$MarketBuyDiscountCopyWith<$Res>? get marketBuyDiscount;$ForceMarketCrashCopyWith<$Res>? get forceMarketCrash;

}
/// @nodoc
class _$EventEffectCopyWithImpl<$Res>
    implements $EventEffectCopyWith<$Res> {
  _$EventEffectCopyWithImpl(this._self, this._then);

  final EventEffect _self;
  final $Res Function(EventEffect) _then;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cash = null,Object? stress = null,Object? network = null,Object? credit = null,Object? addedLoans = null,Object? addedAssets = null,Object? addedFlags = null,Object? removedFlags = null,Object? insightCardId = freezed,Object? salaryDelta = null,Object? monthlyExpensesDelta = null,Object? cashBySalaryMultiplier = null,Object? cashByOutflowMultiplier = null,Object? cashIfInsured = freezed,Object? salarySuspendedMonths = null,Object? marketSellAllClassIds = null,Object? marketBuyCashFraction = freezed,Object? marketBuyDiscount = freezed,Object? forceMarketCrash = freezed,}) {
  return _then(_self.copyWith(
cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as int,credit: null == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as int,addedLoans: null == addedLoans ? _self.addedLoans : addedLoans // ignore: cast_nullable_to_non_nullable
as List<Loan>,addedAssets: null == addedAssets ? _self.addedAssets : addedAssets // ignore: cast_nullable_to_non_nullable
as List<Asset>,addedFlags: null == addedFlags ? _self.addedFlags : addedFlags // ignore: cast_nullable_to_non_nullable
as List<String>,removedFlags: null == removedFlags ? _self.removedFlags : removedFlags // ignore: cast_nullable_to_non_nullable
as List<String>,insightCardId: freezed == insightCardId ? _self.insightCardId : insightCardId // ignore: cast_nullable_to_non_nullable
as String?,salaryDelta: null == salaryDelta ? _self.salaryDelta : salaryDelta // ignore: cast_nullable_to_non_nullable
as double,monthlyExpensesDelta: null == monthlyExpensesDelta ? _self.monthlyExpensesDelta : monthlyExpensesDelta // ignore: cast_nullable_to_non_nullable
as double,cashBySalaryMultiplier: null == cashBySalaryMultiplier ? _self.cashBySalaryMultiplier : cashBySalaryMultiplier // ignore: cast_nullable_to_non_nullable
as double,cashByOutflowMultiplier: null == cashByOutflowMultiplier ? _self.cashByOutflowMultiplier : cashByOutflowMultiplier // ignore: cast_nullable_to_non_nullable
as double,cashIfInsured: freezed == cashIfInsured ? _self.cashIfInsured : cashIfInsured // ignore: cast_nullable_to_non_nullable
as double?,salarySuspendedMonths: null == salarySuspendedMonths ? _self.salarySuspendedMonths : salarySuspendedMonths // ignore: cast_nullable_to_non_nullable
as int,marketSellAllClassIds: null == marketSellAllClassIds ? _self.marketSellAllClassIds : marketSellAllClassIds // ignore: cast_nullable_to_non_nullable
as List<String>,marketBuyCashFraction: freezed == marketBuyCashFraction ? _self.marketBuyCashFraction : marketBuyCashFraction // ignore: cast_nullable_to_non_nullable
as MarketBuyFraction?,marketBuyDiscount: freezed == marketBuyDiscount ? _self.marketBuyDiscount : marketBuyDiscount // ignore: cast_nullable_to_non_nullable
as MarketBuyDiscount?,forceMarketCrash: freezed == forceMarketCrash ? _self.forceMarketCrash : forceMarketCrash // ignore: cast_nullable_to_non_nullable
as ForceMarketCrash?,
  ));
}
/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketBuyFractionCopyWith<$Res>? get marketBuyCashFraction {
    if (_self.marketBuyCashFraction == null) {
    return null;
  }

  return $MarketBuyFractionCopyWith<$Res>(_self.marketBuyCashFraction!, (value) {
    return _then(_self.copyWith(marketBuyCashFraction: value));
  });
}/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketBuyDiscountCopyWith<$Res>? get marketBuyDiscount {
    if (_self.marketBuyDiscount == null) {
    return null;
  }

  return $MarketBuyDiscountCopyWith<$Res>(_self.marketBuyDiscount!, (value) {
    return _then(_self.copyWith(marketBuyDiscount: value));
  });
}/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForceMarketCrashCopyWith<$Res>? get forceMarketCrash {
    if (_self.forceMarketCrash == null) {
    return null;
  }

  return $ForceMarketCrashCopyWith<$Res>(_self.forceMarketCrash!, (value) {
    return _then(_self.copyWith(forceMarketCrash: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventEffect].
extension EventEffectPatterns on EventEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventEffect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventEffect value)  $default,){
final _that = this;
switch (_that) {
case _EventEffect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventEffect value)?  $default,){
final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cash,  int stress,  int network,  int credit,  List<Loan> addedLoans,  List<Asset> addedAssets,  List<String> addedFlags,  List<String> removedFlags,  String? insightCardId,  double salaryDelta,  double monthlyExpensesDelta,  double cashBySalaryMultiplier,  double cashByOutflowMultiplier,  double? cashIfInsured,  int salarySuspendedMonths,  List<String> marketSellAllClassIds,  MarketBuyFraction? marketBuyCashFraction,  MarketBuyDiscount? marketBuyDiscount,  ForceMarketCrash? forceMarketCrash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
return $default(_that.cash,_that.stress,_that.network,_that.credit,_that.addedLoans,_that.addedAssets,_that.addedFlags,_that.removedFlags,_that.insightCardId,_that.salaryDelta,_that.monthlyExpensesDelta,_that.cashBySalaryMultiplier,_that.cashByOutflowMultiplier,_that.cashIfInsured,_that.salarySuspendedMonths,_that.marketSellAllClassIds,_that.marketBuyCashFraction,_that.marketBuyDiscount,_that.forceMarketCrash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cash,  int stress,  int network,  int credit,  List<Loan> addedLoans,  List<Asset> addedAssets,  List<String> addedFlags,  List<String> removedFlags,  String? insightCardId,  double salaryDelta,  double monthlyExpensesDelta,  double cashBySalaryMultiplier,  double cashByOutflowMultiplier,  double? cashIfInsured,  int salarySuspendedMonths,  List<String> marketSellAllClassIds,  MarketBuyFraction? marketBuyCashFraction,  MarketBuyDiscount? marketBuyDiscount,  ForceMarketCrash? forceMarketCrash)  $default,) {final _that = this;
switch (_that) {
case _EventEffect():
return $default(_that.cash,_that.stress,_that.network,_that.credit,_that.addedLoans,_that.addedAssets,_that.addedFlags,_that.removedFlags,_that.insightCardId,_that.salaryDelta,_that.monthlyExpensesDelta,_that.cashBySalaryMultiplier,_that.cashByOutflowMultiplier,_that.cashIfInsured,_that.salarySuspendedMonths,_that.marketSellAllClassIds,_that.marketBuyCashFraction,_that.marketBuyDiscount,_that.forceMarketCrash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cash,  int stress,  int network,  int credit,  List<Loan> addedLoans,  List<Asset> addedAssets,  List<String> addedFlags,  List<String> removedFlags,  String? insightCardId,  double salaryDelta,  double monthlyExpensesDelta,  double cashBySalaryMultiplier,  double cashByOutflowMultiplier,  double? cashIfInsured,  int salarySuspendedMonths,  List<String> marketSellAllClassIds,  MarketBuyFraction? marketBuyCashFraction,  MarketBuyDiscount? marketBuyDiscount,  ForceMarketCrash? forceMarketCrash)?  $default,) {final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
return $default(_that.cash,_that.stress,_that.network,_that.credit,_that.addedLoans,_that.addedAssets,_that.addedFlags,_that.removedFlags,_that.insightCardId,_that.salaryDelta,_that.monthlyExpensesDelta,_that.cashBySalaryMultiplier,_that.cashByOutflowMultiplier,_that.cashIfInsured,_that.salarySuspendedMonths,_that.marketSellAllClassIds,_that.marketBuyCashFraction,_that.marketBuyDiscount,_that.forceMarketCrash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventEffect extends EventEffect {
  const _EventEffect({this.cash = 0.0, this.stress = 0, this.network = 0, this.credit = 0, final  List<Loan> addedLoans = const [], final  List<Asset> addedAssets = const [], final  List<String> addedFlags = const [], final  List<String> removedFlags = const [], this.insightCardId, this.salaryDelta = 0.0, this.monthlyExpensesDelta = 0.0, this.cashBySalaryMultiplier = 0.0, this.cashByOutflowMultiplier = 0.0, this.cashIfInsured, this.salarySuspendedMonths = 0, final  List<String> marketSellAllClassIds = const [], this.marketBuyCashFraction, this.marketBuyDiscount, this.forceMarketCrash}): _addedLoans = addedLoans,_addedAssets = addedAssets,_addedFlags = addedFlags,_removedFlags = removedFlags,_marketSellAllClassIds = marketSellAllClassIds,super._();
  factory _EventEffect.fromJson(Map<String, dynamic> json) => _$EventEffectFromJson(json);

@override@JsonKey() final  double cash;
@override@JsonKey() final  int stress;
@override@JsonKey() final  int network;
@override@JsonKey() final  int credit;
 final  List<Loan> _addedLoans;
@override@JsonKey() List<Loan> get addedLoans {
  if (_addedLoans is EqualUnmodifiableListView) return _addedLoans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addedLoans);
}

 final  List<Asset> _addedAssets;
@override@JsonKey() List<Asset> get addedAssets {
  if (_addedAssets is EqualUnmodifiableListView) return _addedAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addedAssets);
}

 final  List<String> _addedFlags;
@override@JsonKey() List<String> get addedFlags {
  if (_addedFlags is EqualUnmodifiableListView) return _addedFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addedFlags);
}

 final  List<String> _removedFlags;
@override@JsonKey() List<String> get removedFlags {
  if (_removedFlags is EqualUnmodifiableListView) return _removedFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_removedFlags);
}

@override final  String? insightCardId;
@override@JsonKey() final  double salaryDelta;
@override@JsonKey() final  double monthlyExpensesDelta;
@override@JsonKey() final  double cashBySalaryMultiplier;
@override@JsonKey() final  double cashByOutflowMultiplier;
// 6.2b: shocks, insurance and market-coupled effects
@override final  double? cashIfInsured;
// replaces `cash` when the player has health insurance
@override@JsonKey() final  int salarySuspendedMonths;
// job loss: months without salary
 final  List<String> _marketSellAllClassIds;
// job loss: months without salary
@override@JsonKey() List<String> get marketSellAllClassIds {
  if (_marketSellAllClassIds is EqualUnmodifiableListView) return _marketSellAllClassIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marketSellAllClassIds);
}

// panic sell, at market price + fee
@override final  MarketBuyFraction? marketBuyCashFraction;
@override final  MarketBuyDiscount? marketBuyDiscount;
@override final  ForceMarketCrash? forceMarketCrash;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventEffectCopyWith<_EventEffect> get copyWith => __$EventEffectCopyWithImpl<_EventEffect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventEffectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEffect&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.network, network) || other.network == network)&&(identical(other.credit, credit) || other.credit == credit)&&const DeepCollectionEquality().equals(other._addedLoans, _addedLoans)&&const DeepCollectionEquality().equals(other._addedAssets, _addedAssets)&&const DeepCollectionEquality().equals(other._addedFlags, _addedFlags)&&const DeepCollectionEquality().equals(other._removedFlags, _removedFlags)&&(identical(other.insightCardId, insightCardId) || other.insightCardId == insightCardId)&&(identical(other.salaryDelta, salaryDelta) || other.salaryDelta == salaryDelta)&&(identical(other.monthlyExpensesDelta, monthlyExpensesDelta) || other.monthlyExpensesDelta == monthlyExpensesDelta)&&(identical(other.cashBySalaryMultiplier, cashBySalaryMultiplier) || other.cashBySalaryMultiplier == cashBySalaryMultiplier)&&(identical(other.cashByOutflowMultiplier, cashByOutflowMultiplier) || other.cashByOutflowMultiplier == cashByOutflowMultiplier)&&(identical(other.cashIfInsured, cashIfInsured) || other.cashIfInsured == cashIfInsured)&&(identical(other.salarySuspendedMonths, salarySuspendedMonths) || other.salarySuspendedMonths == salarySuspendedMonths)&&const DeepCollectionEquality().equals(other._marketSellAllClassIds, _marketSellAllClassIds)&&(identical(other.marketBuyCashFraction, marketBuyCashFraction) || other.marketBuyCashFraction == marketBuyCashFraction)&&(identical(other.marketBuyDiscount, marketBuyDiscount) || other.marketBuyDiscount == marketBuyDiscount)&&(identical(other.forceMarketCrash, forceMarketCrash) || other.forceMarketCrash == forceMarketCrash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,cash,stress,network,credit,const DeepCollectionEquality().hash(_addedLoans),const DeepCollectionEquality().hash(_addedAssets),const DeepCollectionEquality().hash(_addedFlags),const DeepCollectionEquality().hash(_removedFlags),insightCardId,salaryDelta,monthlyExpensesDelta,cashBySalaryMultiplier,cashByOutflowMultiplier,cashIfInsured,salarySuspendedMonths,const DeepCollectionEquality().hash(_marketSellAllClassIds),marketBuyCashFraction,marketBuyDiscount,forceMarketCrash]);

@override
String toString() {
  return 'EventEffect(cash: $cash, stress: $stress, network: $network, credit: $credit, addedLoans: $addedLoans, addedAssets: $addedAssets, addedFlags: $addedFlags, removedFlags: $removedFlags, insightCardId: $insightCardId, salaryDelta: $salaryDelta, monthlyExpensesDelta: $monthlyExpensesDelta, cashBySalaryMultiplier: $cashBySalaryMultiplier, cashByOutflowMultiplier: $cashByOutflowMultiplier, cashIfInsured: $cashIfInsured, salarySuspendedMonths: $salarySuspendedMonths, marketSellAllClassIds: $marketSellAllClassIds, marketBuyCashFraction: $marketBuyCashFraction, marketBuyDiscount: $marketBuyDiscount, forceMarketCrash: $forceMarketCrash)';
}


}

/// @nodoc
abstract mixin class _$EventEffectCopyWith<$Res> implements $EventEffectCopyWith<$Res> {
  factory _$EventEffectCopyWith(_EventEffect value, $Res Function(_EventEffect) _then) = __$EventEffectCopyWithImpl;
@override @useResult
$Res call({
 double cash, int stress, int network, int credit, List<Loan> addedLoans, List<Asset> addedAssets, List<String> addedFlags, List<String> removedFlags, String? insightCardId, double salaryDelta, double monthlyExpensesDelta, double cashBySalaryMultiplier, double cashByOutflowMultiplier, double? cashIfInsured, int salarySuspendedMonths, List<String> marketSellAllClassIds, MarketBuyFraction? marketBuyCashFraction, MarketBuyDiscount? marketBuyDiscount, ForceMarketCrash? forceMarketCrash
});


@override $MarketBuyFractionCopyWith<$Res>? get marketBuyCashFraction;@override $MarketBuyDiscountCopyWith<$Res>? get marketBuyDiscount;@override $ForceMarketCrashCopyWith<$Res>? get forceMarketCrash;

}
/// @nodoc
class __$EventEffectCopyWithImpl<$Res>
    implements _$EventEffectCopyWith<$Res> {
  __$EventEffectCopyWithImpl(this._self, this._then);

  final _EventEffect _self;
  final $Res Function(_EventEffect) _then;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cash = null,Object? stress = null,Object? network = null,Object? credit = null,Object? addedLoans = null,Object? addedAssets = null,Object? addedFlags = null,Object? removedFlags = null,Object? insightCardId = freezed,Object? salaryDelta = null,Object? monthlyExpensesDelta = null,Object? cashBySalaryMultiplier = null,Object? cashByOutflowMultiplier = null,Object? cashIfInsured = freezed,Object? salarySuspendedMonths = null,Object? marketSellAllClassIds = null,Object? marketBuyCashFraction = freezed,Object? marketBuyDiscount = freezed,Object? forceMarketCrash = freezed,}) {
  return _then(_EventEffect(
cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as int,credit: null == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as int,addedLoans: null == addedLoans ? _self._addedLoans : addedLoans // ignore: cast_nullable_to_non_nullable
as List<Loan>,addedAssets: null == addedAssets ? _self._addedAssets : addedAssets // ignore: cast_nullable_to_non_nullable
as List<Asset>,addedFlags: null == addedFlags ? _self._addedFlags : addedFlags // ignore: cast_nullable_to_non_nullable
as List<String>,removedFlags: null == removedFlags ? _self._removedFlags : removedFlags // ignore: cast_nullable_to_non_nullable
as List<String>,insightCardId: freezed == insightCardId ? _self.insightCardId : insightCardId // ignore: cast_nullable_to_non_nullable
as String?,salaryDelta: null == salaryDelta ? _self.salaryDelta : salaryDelta // ignore: cast_nullable_to_non_nullable
as double,monthlyExpensesDelta: null == monthlyExpensesDelta ? _self.monthlyExpensesDelta : monthlyExpensesDelta // ignore: cast_nullable_to_non_nullable
as double,cashBySalaryMultiplier: null == cashBySalaryMultiplier ? _self.cashBySalaryMultiplier : cashBySalaryMultiplier // ignore: cast_nullable_to_non_nullable
as double,cashByOutflowMultiplier: null == cashByOutflowMultiplier ? _self.cashByOutflowMultiplier : cashByOutflowMultiplier // ignore: cast_nullable_to_non_nullable
as double,cashIfInsured: freezed == cashIfInsured ? _self.cashIfInsured : cashIfInsured // ignore: cast_nullable_to_non_nullable
as double?,salarySuspendedMonths: null == salarySuspendedMonths ? _self.salarySuspendedMonths : salarySuspendedMonths // ignore: cast_nullable_to_non_nullable
as int,marketSellAllClassIds: null == marketSellAllClassIds ? _self._marketSellAllClassIds : marketSellAllClassIds // ignore: cast_nullable_to_non_nullable
as List<String>,marketBuyCashFraction: freezed == marketBuyCashFraction ? _self.marketBuyCashFraction : marketBuyCashFraction // ignore: cast_nullable_to_non_nullable
as MarketBuyFraction?,marketBuyDiscount: freezed == marketBuyDiscount ? _self.marketBuyDiscount : marketBuyDiscount // ignore: cast_nullable_to_non_nullable
as MarketBuyDiscount?,forceMarketCrash: freezed == forceMarketCrash ? _self.forceMarketCrash : forceMarketCrash // ignore: cast_nullable_to_non_nullable
as ForceMarketCrash?,
  ));
}

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketBuyFractionCopyWith<$Res>? get marketBuyCashFraction {
    if (_self.marketBuyCashFraction == null) {
    return null;
  }

  return $MarketBuyFractionCopyWith<$Res>(_self.marketBuyCashFraction!, (value) {
    return _then(_self.copyWith(marketBuyCashFraction: value));
  });
}/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketBuyDiscountCopyWith<$Res>? get marketBuyDiscount {
    if (_self.marketBuyDiscount == null) {
    return null;
  }

  return $MarketBuyDiscountCopyWith<$Res>(_self.marketBuyDiscount!, (value) {
    return _then(_self.copyWith(marketBuyDiscount: value));
  });
}/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForceMarketCrashCopyWith<$Res>? get forceMarketCrash {
    if (_self.forceMarketCrash == null) {
    return null;
  }

  return $ForceMarketCrashCopyWith<$Res>(_self.forceMarketCrash!, (value) {
    return _then(_self.copyWith(forceMarketCrash: value));
  });
}
}

// dart format on
