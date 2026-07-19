// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetListing {

 String get id; String get name; AssetType get type; double get annualYieldRate;
/// Create a copy of AssetListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetListingCopyWith<AssetListing> get copyWith => _$AssetListingCopyWithImpl<AssetListing>(this as AssetListing, _$identity);

  /// Serializes this AssetListing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetListing&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.annualYieldRate, annualYieldRate) || other.annualYieldRate == annualYieldRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,annualYieldRate);

@override
String toString() {
  return 'AssetListing(id: $id, name: $name, type: $type, annualYieldRate: $annualYieldRate)';
}


}

/// @nodoc
abstract mixin class $AssetListingCopyWith<$Res>  {
  factory $AssetListingCopyWith(AssetListing value, $Res Function(AssetListing) _then) = _$AssetListingCopyWithImpl;
@useResult
$Res call({
 String id, String name, AssetType type, double annualYieldRate
});




}
/// @nodoc
class _$AssetListingCopyWithImpl<$Res>
    implements $AssetListingCopyWith<$Res> {
  _$AssetListingCopyWithImpl(this._self, this._then);

  final AssetListing _self;
  final $Res Function(AssetListing) _then;

/// Create a copy of AssetListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? annualYieldRate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AssetType,annualYieldRate: null == annualYieldRate ? _self.annualYieldRate : annualYieldRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetListing].
extension AssetListingPatterns on AssetListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetListing value)  $default,){
final _that = this;
switch (_that) {
case _AssetListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetListing value)?  $default,){
final _that = this;
switch (_that) {
case _AssetListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  AssetType type,  double annualYieldRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetListing() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.annualYieldRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  AssetType type,  double annualYieldRate)  $default,) {final _that = this;
switch (_that) {
case _AssetListing():
return $default(_that.id,_that.name,_that.type,_that.annualYieldRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  AssetType type,  double annualYieldRate)?  $default,) {final _that = this;
switch (_that) {
case _AssetListing() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.annualYieldRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetListing implements AssetListing {
  const _AssetListing({required this.id, required this.name, required this.type, required this.annualYieldRate});
  factory _AssetListing.fromJson(Map<String, dynamic> json) => _$AssetListingFromJson(json);

@override final  String id;
@override final  String name;
@override final  AssetType type;
@override final  double annualYieldRate;

/// Create a copy of AssetListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetListingCopyWith<_AssetListing> get copyWith => __$AssetListingCopyWithImpl<_AssetListing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetListingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetListing&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.annualYieldRate, annualYieldRate) || other.annualYieldRate == annualYieldRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,annualYieldRate);

@override
String toString() {
  return 'AssetListing(id: $id, name: $name, type: $type, annualYieldRate: $annualYieldRate)';
}


}

/// @nodoc
abstract mixin class _$AssetListingCopyWith<$Res> implements $AssetListingCopyWith<$Res> {
  factory _$AssetListingCopyWith(_AssetListing value, $Res Function(_AssetListing) _then) = __$AssetListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, AssetType type, double annualYieldRate
});




}
/// @nodoc
class __$AssetListingCopyWithImpl<$Res>
    implements _$AssetListingCopyWith<$Res> {
  __$AssetListingCopyWithImpl(this._self, this._then);

  final _AssetListing _self;
  final $Res Function(_AssetListing) _then;

/// Create a copy of AssetListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? annualYieldRate = null,}) {
  return _then(_AssetListing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AssetType,annualYieldRate: null == annualYieldRate ? _self.annualYieldRate : annualYieldRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
