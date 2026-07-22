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
mixin _$EventEffect {

 double get cash; int get stress; int get network; int get credit; List<Loan> get addedLoans; List<Asset> get addedAssets; List<String> get addedFlags; List<String> get removedFlags; String? get insightCardId; double get salaryDelta; double get monthlyExpensesDelta; double get cashBySalaryMultiplier; double get cashByOutflowMultiplier;
/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEffectCopyWith<EventEffect> get copyWith => _$EventEffectCopyWithImpl<EventEffect>(this as EventEffect, _$identity);

  /// Serializes this EventEffect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEffect&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.network, network) || other.network == network)&&(identical(other.credit, credit) || other.credit == credit)&&const DeepCollectionEquality().equals(other.addedLoans, addedLoans)&&const DeepCollectionEquality().equals(other.addedAssets, addedAssets)&&const DeepCollectionEquality().equals(other.addedFlags, addedFlags)&&const DeepCollectionEquality().equals(other.removedFlags, removedFlags)&&(identical(other.insightCardId, insightCardId) || other.insightCardId == insightCardId)&&(identical(other.salaryDelta, salaryDelta) || other.salaryDelta == salaryDelta)&&(identical(other.monthlyExpensesDelta, monthlyExpensesDelta) || other.monthlyExpensesDelta == monthlyExpensesDelta)&&(identical(other.cashBySalaryMultiplier, cashBySalaryMultiplier) || other.cashBySalaryMultiplier == cashBySalaryMultiplier)&&(identical(other.cashByOutflowMultiplier, cashByOutflowMultiplier) || other.cashByOutflowMultiplier == cashByOutflowMultiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cash,stress,network,credit,const DeepCollectionEquality().hash(addedLoans),const DeepCollectionEquality().hash(addedAssets),const DeepCollectionEquality().hash(addedFlags),const DeepCollectionEquality().hash(removedFlags),insightCardId,salaryDelta,monthlyExpensesDelta,cashBySalaryMultiplier,cashByOutflowMultiplier);

@override
String toString() {
  return 'EventEffect(cash: $cash, stress: $stress, network: $network, credit: $credit, addedLoans: $addedLoans, addedAssets: $addedAssets, addedFlags: $addedFlags, removedFlags: $removedFlags, insightCardId: $insightCardId, salaryDelta: $salaryDelta, monthlyExpensesDelta: $monthlyExpensesDelta, cashBySalaryMultiplier: $cashBySalaryMultiplier, cashByOutflowMultiplier: $cashByOutflowMultiplier)';
}


}

/// @nodoc
abstract mixin class $EventEffectCopyWith<$Res>  {
  factory $EventEffectCopyWith(EventEffect value, $Res Function(EventEffect) _then) = _$EventEffectCopyWithImpl;
@useResult
$Res call({
 double cash, int stress, int network, int credit, List<Loan> addedLoans, List<Asset> addedAssets, List<String> addedFlags, List<String> removedFlags, String? insightCardId, double salaryDelta, double monthlyExpensesDelta, double cashBySalaryMultiplier, double cashByOutflowMultiplier
});




}
/// @nodoc
class _$EventEffectCopyWithImpl<$Res>
    implements $EventEffectCopyWith<$Res> {
  _$EventEffectCopyWithImpl(this._self, this._then);

  final EventEffect _self;
  final $Res Function(EventEffect) _then;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cash = null,Object? stress = null,Object? network = null,Object? credit = null,Object? addedLoans = null,Object? addedAssets = null,Object? addedFlags = null,Object? removedFlags = null,Object? insightCardId = freezed,Object? salaryDelta = null,Object? monthlyExpensesDelta = null,Object? cashBySalaryMultiplier = null,Object? cashByOutflowMultiplier = null,}) {
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
as double,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cash,  int stress,  int network,  int credit,  List<Loan> addedLoans,  List<Asset> addedAssets,  List<String> addedFlags,  List<String> removedFlags,  String? insightCardId,  double salaryDelta,  double monthlyExpensesDelta,  double cashBySalaryMultiplier,  double cashByOutflowMultiplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
return $default(_that.cash,_that.stress,_that.network,_that.credit,_that.addedLoans,_that.addedAssets,_that.addedFlags,_that.removedFlags,_that.insightCardId,_that.salaryDelta,_that.monthlyExpensesDelta,_that.cashBySalaryMultiplier,_that.cashByOutflowMultiplier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cash,  int stress,  int network,  int credit,  List<Loan> addedLoans,  List<Asset> addedAssets,  List<String> addedFlags,  List<String> removedFlags,  String? insightCardId,  double salaryDelta,  double monthlyExpensesDelta,  double cashBySalaryMultiplier,  double cashByOutflowMultiplier)  $default,) {final _that = this;
switch (_that) {
case _EventEffect():
return $default(_that.cash,_that.stress,_that.network,_that.credit,_that.addedLoans,_that.addedAssets,_that.addedFlags,_that.removedFlags,_that.insightCardId,_that.salaryDelta,_that.monthlyExpensesDelta,_that.cashBySalaryMultiplier,_that.cashByOutflowMultiplier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cash,  int stress,  int network,  int credit,  List<Loan> addedLoans,  List<Asset> addedAssets,  List<String> addedFlags,  List<String> removedFlags,  String? insightCardId,  double salaryDelta,  double monthlyExpensesDelta,  double cashBySalaryMultiplier,  double cashByOutflowMultiplier)?  $default,) {final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
return $default(_that.cash,_that.stress,_that.network,_that.credit,_that.addedLoans,_that.addedAssets,_that.addedFlags,_that.removedFlags,_that.insightCardId,_that.salaryDelta,_that.monthlyExpensesDelta,_that.cashBySalaryMultiplier,_that.cashByOutflowMultiplier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventEffect extends EventEffect {
  const _EventEffect({this.cash = 0.0, this.stress = 0, this.network = 0, this.credit = 0, final  List<Loan> addedLoans = const [], final  List<Asset> addedAssets = const [], final  List<String> addedFlags = const [], final  List<String> removedFlags = const [], this.insightCardId, this.salaryDelta = 0.0, this.monthlyExpensesDelta = 0.0, this.cashBySalaryMultiplier = 0.0, this.cashByOutflowMultiplier = 0.0}): _addedLoans = addedLoans,_addedAssets = addedAssets,_addedFlags = addedFlags,_removedFlags = removedFlags,super._();
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEffect&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.network, network) || other.network == network)&&(identical(other.credit, credit) || other.credit == credit)&&const DeepCollectionEquality().equals(other._addedLoans, _addedLoans)&&const DeepCollectionEquality().equals(other._addedAssets, _addedAssets)&&const DeepCollectionEquality().equals(other._addedFlags, _addedFlags)&&const DeepCollectionEquality().equals(other._removedFlags, _removedFlags)&&(identical(other.insightCardId, insightCardId) || other.insightCardId == insightCardId)&&(identical(other.salaryDelta, salaryDelta) || other.salaryDelta == salaryDelta)&&(identical(other.monthlyExpensesDelta, monthlyExpensesDelta) || other.monthlyExpensesDelta == monthlyExpensesDelta)&&(identical(other.cashBySalaryMultiplier, cashBySalaryMultiplier) || other.cashBySalaryMultiplier == cashBySalaryMultiplier)&&(identical(other.cashByOutflowMultiplier, cashByOutflowMultiplier) || other.cashByOutflowMultiplier == cashByOutflowMultiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cash,stress,network,credit,const DeepCollectionEquality().hash(_addedLoans),const DeepCollectionEquality().hash(_addedAssets),const DeepCollectionEquality().hash(_addedFlags),const DeepCollectionEquality().hash(_removedFlags),insightCardId,salaryDelta,monthlyExpensesDelta,cashBySalaryMultiplier,cashByOutflowMultiplier);

@override
String toString() {
  return 'EventEffect(cash: $cash, stress: $stress, network: $network, credit: $credit, addedLoans: $addedLoans, addedAssets: $addedAssets, addedFlags: $addedFlags, removedFlags: $removedFlags, insightCardId: $insightCardId, salaryDelta: $salaryDelta, monthlyExpensesDelta: $monthlyExpensesDelta, cashBySalaryMultiplier: $cashBySalaryMultiplier, cashByOutflowMultiplier: $cashByOutflowMultiplier)';
}


}

/// @nodoc
abstract mixin class _$EventEffectCopyWith<$Res> implements $EventEffectCopyWith<$Res> {
  factory _$EventEffectCopyWith(_EventEffect value, $Res Function(_EventEffect) _then) = __$EventEffectCopyWithImpl;
@override @useResult
$Res call({
 double cash, int stress, int network, int credit, List<Loan> addedLoans, List<Asset> addedAssets, List<String> addedFlags, List<String> removedFlags, String? insightCardId, double salaryDelta, double monthlyExpensesDelta, double cashBySalaryMultiplier, double cashByOutflowMultiplier
});




}
/// @nodoc
class __$EventEffectCopyWithImpl<$Res>
    implements _$EventEffectCopyWith<$Res> {
  __$EventEffectCopyWithImpl(this._self, this._then);

  final _EventEffect _self;
  final $Res Function(_EventEffect) _then;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cash = null,Object? stress = null,Object? network = null,Object? credit = null,Object? addedLoans = null,Object? addedAssets = null,Object? addedFlags = null,Object? removedFlags = null,Object? insightCardId = freezed,Object? salaryDelta = null,Object? monthlyExpensesDelta = null,Object? cashBySalaryMultiplier = null,Object? cashByOutflowMultiplier = null,}) {
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
as double,
  ));
}


}

// dart format on
