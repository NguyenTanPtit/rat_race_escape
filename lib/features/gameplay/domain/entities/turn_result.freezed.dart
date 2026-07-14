// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'turn_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TurnResult {

 GameState get state;
/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnResultCopyWith<TurnResult> get copyWith => _$TurnResultCopyWithImpl<TurnResult>(this as TurnResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnResult&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'TurnResult(state: $state)';
}


}

/// @nodoc
abstract mixin class $TurnResultCopyWith<$Res>  {
  factory $TurnResultCopyWith(TurnResult value, $Res Function(TurnResult) _then) = _$TurnResultCopyWithImpl;
@useResult
$Res call({
 GameState state
});


$GameStateCopyWith<$Res> get state;

}
/// @nodoc
class _$TurnResultCopyWithImpl<$Res>
    implements $TurnResultCopyWith<$Res> {
  _$TurnResultCopyWithImpl(this._self, this._then);

  final TurnResult _self;
  final $Res Function(TurnResult) _then;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as GameState,
  ));
}
/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get state {
  
  return $GameStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [TurnResult].
extension TurnResultPatterns on TurnResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TurnContinued value)?  continued,TResult Function( TurnWon value)?  won,TResult Function( TurnLost value)?  lost,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TurnContinued() when continued != null:
return continued(_that);case TurnWon() when won != null:
return won(_that);case TurnLost() when lost != null:
return lost(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TurnContinued value)  continued,required TResult Function( TurnWon value)  won,required TResult Function( TurnLost value)  lost,}){
final _that = this;
switch (_that) {
case TurnContinued():
return continued(_that);case TurnWon():
return won(_that);case TurnLost():
return lost(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TurnContinued value)?  continued,TResult? Function( TurnWon value)?  won,TResult? Function( TurnLost value)?  lost,}){
final _that = this;
switch (_that) {
case TurnContinued() when continued != null:
return continued(_that);case TurnWon() when won != null:
return won(_that);case TurnLost() when lost != null:
return lost(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( GameState state)?  continued,TResult Function( GameState state)?  won,TResult Function( GameState state,  GameOverReason reason)?  lost,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TurnContinued() when continued != null:
return continued(_that.state);case TurnWon() when won != null:
return won(_that.state);case TurnLost() when lost != null:
return lost(_that.state,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( GameState state)  continued,required TResult Function( GameState state)  won,required TResult Function( GameState state,  GameOverReason reason)  lost,}) {final _that = this;
switch (_that) {
case TurnContinued():
return continued(_that.state);case TurnWon():
return won(_that.state);case TurnLost():
return lost(_that.state,_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( GameState state)?  continued,TResult? Function( GameState state)?  won,TResult? Function( GameState state,  GameOverReason reason)?  lost,}) {final _that = this;
switch (_that) {
case TurnContinued() when continued != null:
return continued(_that.state);case TurnWon() when won != null:
return won(_that.state);case TurnLost() when lost != null:
return lost(_that.state,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class TurnContinued implements TurnResult {
  const TurnContinued(this.state);
  

@override final  GameState state;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnContinuedCopyWith<TurnContinued> get copyWith => _$TurnContinuedCopyWithImpl<TurnContinued>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnContinued&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'TurnResult.continued(state: $state)';
}


}

/// @nodoc
abstract mixin class $TurnContinuedCopyWith<$Res> implements $TurnResultCopyWith<$Res> {
  factory $TurnContinuedCopyWith(TurnContinued value, $Res Function(TurnContinued) _then) = _$TurnContinuedCopyWithImpl;
@override @useResult
$Res call({
 GameState state
});


@override $GameStateCopyWith<$Res> get state;

}
/// @nodoc
class _$TurnContinuedCopyWithImpl<$Res>
    implements $TurnContinuedCopyWith<$Res> {
  _$TurnContinuedCopyWithImpl(this._self, this._then);

  final TurnContinued _self;
  final $Res Function(TurnContinued) _then;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(TurnContinued(
null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as GameState,
  ));
}

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get state {
  
  return $GameStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

/// @nodoc


class TurnWon implements TurnResult {
  const TurnWon(this.state);
  

@override final  GameState state;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnWonCopyWith<TurnWon> get copyWith => _$TurnWonCopyWithImpl<TurnWon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnWon&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'TurnResult.won(state: $state)';
}


}

/// @nodoc
abstract mixin class $TurnWonCopyWith<$Res> implements $TurnResultCopyWith<$Res> {
  factory $TurnWonCopyWith(TurnWon value, $Res Function(TurnWon) _then) = _$TurnWonCopyWithImpl;
@override @useResult
$Res call({
 GameState state
});


@override $GameStateCopyWith<$Res> get state;

}
/// @nodoc
class _$TurnWonCopyWithImpl<$Res>
    implements $TurnWonCopyWith<$Res> {
  _$TurnWonCopyWithImpl(this._self, this._then);

  final TurnWon _self;
  final $Res Function(TurnWon) _then;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(TurnWon(
null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as GameState,
  ));
}

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get state {
  
  return $GameStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

/// @nodoc


class TurnLost implements TurnResult {
  const TurnLost(this.state, this.reason);
  

@override final  GameState state;
 final  GameOverReason reason;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TurnLostCopyWith<TurnLost> get copyWith => _$TurnLostCopyWithImpl<TurnLost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TurnLost&&(identical(other.state, state) || other.state == state)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,state,reason);

@override
String toString() {
  return 'TurnResult.lost(state: $state, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $TurnLostCopyWith<$Res> implements $TurnResultCopyWith<$Res> {
  factory $TurnLostCopyWith(TurnLost value, $Res Function(TurnLost) _then) = _$TurnLostCopyWithImpl;
@override @useResult
$Res call({
 GameState state, GameOverReason reason
});


@override $GameStateCopyWith<$Res> get state;

}
/// @nodoc
class _$TurnLostCopyWithImpl<$Res>
    implements $TurnLostCopyWith<$Res> {
  _$TurnLostCopyWithImpl(this._self, this._then);

  final TurnLost _self;
  final $Res Function(TurnLost) _then;

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? reason = null,}) {
  return _then(TurnLost(
null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as GameState,null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as GameOverReason,
  ));
}

/// Create a copy of TurnResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get state {
  
  return $GameStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

// dart format on
