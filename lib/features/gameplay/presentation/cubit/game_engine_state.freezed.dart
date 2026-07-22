// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_engine_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthlySummaryDelta {

 double get cashDelta; int get stressDelta; double get netWorthDelta; double get cashIn; double get cashOut;
/// Create a copy of MonthlySummaryDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlySummaryDeltaCopyWith<MonthlySummaryDelta> get copyWith => _$MonthlySummaryDeltaCopyWithImpl<MonthlySummaryDelta>(this as MonthlySummaryDelta, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlySummaryDelta&&(identical(other.cashDelta, cashDelta) || other.cashDelta == cashDelta)&&(identical(other.stressDelta, stressDelta) || other.stressDelta == stressDelta)&&(identical(other.netWorthDelta, netWorthDelta) || other.netWorthDelta == netWorthDelta)&&(identical(other.cashIn, cashIn) || other.cashIn == cashIn)&&(identical(other.cashOut, cashOut) || other.cashOut == cashOut));
}


@override
int get hashCode => Object.hash(runtimeType,cashDelta,stressDelta,netWorthDelta,cashIn,cashOut);

@override
String toString() {
  return 'MonthlySummaryDelta(cashDelta: $cashDelta, stressDelta: $stressDelta, netWorthDelta: $netWorthDelta, cashIn: $cashIn, cashOut: $cashOut)';
}


}

/// @nodoc
abstract mixin class $MonthlySummaryDeltaCopyWith<$Res>  {
  factory $MonthlySummaryDeltaCopyWith(MonthlySummaryDelta value, $Res Function(MonthlySummaryDelta) _then) = _$MonthlySummaryDeltaCopyWithImpl;
@useResult
$Res call({
 double cashDelta, int stressDelta, double netWorthDelta, double cashIn, double cashOut
});




}
/// @nodoc
class _$MonthlySummaryDeltaCopyWithImpl<$Res>
    implements $MonthlySummaryDeltaCopyWith<$Res> {
  _$MonthlySummaryDeltaCopyWithImpl(this._self, this._then);

  final MonthlySummaryDelta _self;
  final $Res Function(MonthlySummaryDelta) _then;

/// Create a copy of MonthlySummaryDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cashDelta = null,Object? stressDelta = null,Object? netWorthDelta = null,Object? cashIn = null,Object? cashOut = null,}) {
  return _then(_self.copyWith(
cashDelta: null == cashDelta ? _self.cashDelta : cashDelta // ignore: cast_nullable_to_non_nullable
as double,stressDelta: null == stressDelta ? _self.stressDelta : stressDelta // ignore: cast_nullable_to_non_nullable
as int,netWorthDelta: null == netWorthDelta ? _self.netWorthDelta : netWorthDelta // ignore: cast_nullable_to_non_nullable
as double,cashIn: null == cashIn ? _self.cashIn : cashIn // ignore: cast_nullable_to_non_nullable
as double,cashOut: null == cashOut ? _self.cashOut : cashOut // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlySummaryDelta].
extension MonthlySummaryDeltaPatterns on MonthlySummaryDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlySummaryDelta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlySummaryDelta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlySummaryDelta value)  $default,){
final _that = this;
switch (_that) {
case _MonthlySummaryDelta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlySummaryDelta value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlySummaryDelta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cashDelta,  int stressDelta,  double netWorthDelta,  double cashIn,  double cashOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlySummaryDelta() when $default != null:
return $default(_that.cashDelta,_that.stressDelta,_that.netWorthDelta,_that.cashIn,_that.cashOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cashDelta,  int stressDelta,  double netWorthDelta,  double cashIn,  double cashOut)  $default,) {final _that = this;
switch (_that) {
case _MonthlySummaryDelta():
return $default(_that.cashDelta,_that.stressDelta,_that.netWorthDelta,_that.cashIn,_that.cashOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cashDelta,  int stressDelta,  double netWorthDelta,  double cashIn,  double cashOut)?  $default,) {final _that = this;
switch (_that) {
case _MonthlySummaryDelta() when $default != null:
return $default(_that.cashDelta,_that.stressDelta,_that.netWorthDelta,_that.cashIn,_that.cashOut);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlySummaryDelta implements MonthlySummaryDelta {
  const _MonthlySummaryDelta({required this.cashDelta, required this.stressDelta, required this.netWorthDelta, this.cashIn = 0.0, this.cashOut = 0.0});
  

@override final  double cashDelta;
@override final  int stressDelta;
@override final  double netWorthDelta;
@override@JsonKey() final  double cashIn;
@override@JsonKey() final  double cashOut;

/// Create a copy of MonthlySummaryDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlySummaryDeltaCopyWith<_MonthlySummaryDelta> get copyWith => __$MonthlySummaryDeltaCopyWithImpl<_MonthlySummaryDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlySummaryDelta&&(identical(other.cashDelta, cashDelta) || other.cashDelta == cashDelta)&&(identical(other.stressDelta, stressDelta) || other.stressDelta == stressDelta)&&(identical(other.netWorthDelta, netWorthDelta) || other.netWorthDelta == netWorthDelta)&&(identical(other.cashIn, cashIn) || other.cashIn == cashIn)&&(identical(other.cashOut, cashOut) || other.cashOut == cashOut));
}


@override
int get hashCode => Object.hash(runtimeType,cashDelta,stressDelta,netWorthDelta,cashIn,cashOut);

@override
String toString() {
  return 'MonthlySummaryDelta(cashDelta: $cashDelta, stressDelta: $stressDelta, netWorthDelta: $netWorthDelta, cashIn: $cashIn, cashOut: $cashOut)';
}


}

/// @nodoc
abstract mixin class _$MonthlySummaryDeltaCopyWith<$Res> implements $MonthlySummaryDeltaCopyWith<$Res> {
  factory _$MonthlySummaryDeltaCopyWith(_MonthlySummaryDelta value, $Res Function(_MonthlySummaryDelta) _then) = __$MonthlySummaryDeltaCopyWithImpl;
@override @useResult
$Res call({
 double cashDelta, int stressDelta, double netWorthDelta, double cashIn, double cashOut
});




}
/// @nodoc
class __$MonthlySummaryDeltaCopyWithImpl<$Res>
    implements _$MonthlySummaryDeltaCopyWith<$Res> {
  __$MonthlySummaryDeltaCopyWithImpl(this._self, this._then);

  final _MonthlySummaryDelta _self;
  final $Res Function(_MonthlySummaryDelta) _then;

/// Create a copy of MonthlySummaryDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cashDelta = null,Object? stressDelta = null,Object? netWorthDelta = null,Object? cashIn = null,Object? cashOut = null,}) {
  return _then(_MonthlySummaryDelta(
cashDelta: null == cashDelta ? _self.cashDelta : cashDelta // ignore: cast_nullable_to_non_nullable
as double,stressDelta: null == stressDelta ? _self.stressDelta : stressDelta // ignore: cast_nullable_to_non_nullable
as int,netWorthDelta: null == netWorthDelta ? _self.netWorthDelta : netWorthDelta // ignore: cast_nullable_to_non_nullable
as double,cashIn: null == cashIn ? _self.cashIn : cashIn // ignore: cast_nullable_to_non_nullable
as double,cashOut: null == cashOut ? _self.cashOut : cashOut // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$GameEngineState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEngineState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameEngineState()';
}


}

/// @nodoc
class $GameEngineStateCopyWith<$Res>  {
$GameEngineStateCopyWith(GameEngineState _, $Res Function(GameEngineState) __);
}


/// Adds pattern-matching-related methods to [GameEngineState].
extension GameEngineStatePatterns on GameEngineState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameEngineInitial value)?  initial,TResult Function( GameEnginePlaying value)?  playing,TResult Function( GameEngineGameOver value)?  gameOver,TResult Function( GameEngineWon value)?  won,TResult Function( GameEngineError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameEngineInitial() when initial != null:
return initial(_that);case GameEnginePlaying() when playing != null:
return playing(_that);case GameEngineGameOver() when gameOver != null:
return gameOver(_that);case GameEngineWon() when won != null:
return won(_that);case GameEngineError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameEngineInitial value)  initial,required TResult Function( GameEnginePlaying value)  playing,required TResult Function( GameEngineGameOver value)  gameOver,required TResult Function( GameEngineWon value)  won,required TResult Function( GameEngineError value)  error,}){
final _that = this;
switch (_that) {
case GameEngineInitial():
return initial(_that);case GameEnginePlaying():
return playing(_that);case GameEngineGameOver():
return gameOver(_that);case GameEngineWon():
return won(_that);case GameEngineError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameEngineInitial value)?  initial,TResult? Function( GameEnginePlaying value)?  playing,TResult? Function( GameEngineGameOver value)?  gameOver,TResult? Function( GameEngineWon value)?  won,TResult? Function( GameEngineError value)?  error,}){
final _that = this;
switch (_that) {
case GameEngineInitial() when initial != null:
return initial(_that);case GameEnginePlaying() when playing != null:
return playing(_that);case GameEngineGameOver() when gameOver != null:
return gameOver(_that);case GameEngineWon() when won != null:
return won(_that);case GameEngineError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( GameState gameState,  Set<String> newlyUnlockedInsightCardIds,  MonthlySummaryDelta? monthlySummary,  GameEvent? currentEvent,  bool isAutoAdvancing,  YearlyRecap? yearlyRecap)?  playing,TResult Function( GameOverReason reason,  GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  gameOver,TResult Function( GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  won,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameEngineInitial() when initial != null:
return initial();case GameEnginePlaying() when playing != null:
return playing(_that.gameState,_that.newlyUnlockedInsightCardIds,_that.monthlySummary,_that.currentEvent,_that.isAutoAdvancing,_that.yearlyRecap);case GameEngineGameOver() when gameOver != null:
return gameOver(_that.reason,_that.finalState,_that.newlyUnlockedInsightCardIds);case GameEngineWon() when won != null:
return won(_that.finalState,_that.newlyUnlockedInsightCardIds);case GameEngineError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( GameState gameState,  Set<String> newlyUnlockedInsightCardIds,  MonthlySummaryDelta? monthlySummary,  GameEvent? currentEvent,  bool isAutoAdvancing,  YearlyRecap? yearlyRecap)  playing,required TResult Function( GameOverReason reason,  GameState finalState,  Set<String> newlyUnlockedInsightCardIds)  gameOver,required TResult Function( GameState finalState,  Set<String> newlyUnlockedInsightCardIds)  won,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case GameEngineInitial():
return initial();case GameEnginePlaying():
return playing(_that.gameState,_that.newlyUnlockedInsightCardIds,_that.monthlySummary,_that.currentEvent,_that.isAutoAdvancing,_that.yearlyRecap);case GameEngineGameOver():
return gameOver(_that.reason,_that.finalState,_that.newlyUnlockedInsightCardIds);case GameEngineWon():
return won(_that.finalState,_that.newlyUnlockedInsightCardIds);case GameEngineError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( GameState gameState,  Set<String> newlyUnlockedInsightCardIds,  MonthlySummaryDelta? monthlySummary,  GameEvent? currentEvent,  bool isAutoAdvancing,  YearlyRecap? yearlyRecap)?  playing,TResult? Function( GameOverReason reason,  GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  gameOver,TResult? Function( GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  won,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case GameEngineInitial() when initial != null:
return initial();case GameEnginePlaying() when playing != null:
return playing(_that.gameState,_that.newlyUnlockedInsightCardIds,_that.monthlySummary,_that.currentEvent,_that.isAutoAdvancing,_that.yearlyRecap);case GameEngineGameOver() when gameOver != null:
return gameOver(_that.reason,_that.finalState,_that.newlyUnlockedInsightCardIds);case GameEngineWon() when won != null:
return won(_that.finalState,_that.newlyUnlockedInsightCardIds);case GameEngineError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class GameEngineInitial implements GameEngineState {
  const GameEngineInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEngineInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameEngineState.initial()';
}


}




/// @nodoc


class GameEnginePlaying implements GameEngineState {
  const GameEnginePlaying(this.gameState, [final  Set<String> newlyUnlockedInsightCardIds = const {}, this.monthlySummary, this.currentEvent, this.isAutoAdvancing = false, this.yearlyRecap]): _newlyUnlockedInsightCardIds = newlyUnlockedInsightCardIds;
  

 final  GameState gameState;
 final  Set<String> _newlyUnlockedInsightCardIds;
@JsonKey() Set<String> get newlyUnlockedInsightCardIds {
  if (_newlyUnlockedInsightCardIds is EqualUnmodifiableSetView) return _newlyUnlockedInsightCardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_newlyUnlockedInsightCardIds);
}

 final  MonthlySummaryDelta? monthlySummary;
 final  GameEvent? currentEvent;
@JsonKey() final  bool isAutoAdvancing;
 final  YearlyRecap? yearlyRecap;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameEnginePlayingCopyWith<GameEnginePlaying> get copyWith => _$GameEnginePlayingCopyWithImpl<GameEnginePlaying>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEnginePlaying&&(identical(other.gameState, gameState) || other.gameState == gameState)&&const DeepCollectionEquality().equals(other._newlyUnlockedInsightCardIds, _newlyUnlockedInsightCardIds)&&(identical(other.monthlySummary, monthlySummary) || other.monthlySummary == monthlySummary)&&(identical(other.currentEvent, currentEvent) || other.currentEvent == currentEvent)&&(identical(other.isAutoAdvancing, isAutoAdvancing) || other.isAutoAdvancing == isAutoAdvancing)&&(identical(other.yearlyRecap, yearlyRecap) || other.yearlyRecap == yearlyRecap));
}


@override
int get hashCode => Object.hash(runtimeType,gameState,const DeepCollectionEquality().hash(_newlyUnlockedInsightCardIds),monthlySummary,currentEvent,isAutoAdvancing,yearlyRecap);

@override
String toString() {
  return 'GameEngineState.playing(gameState: $gameState, newlyUnlockedInsightCardIds: $newlyUnlockedInsightCardIds, monthlySummary: $monthlySummary, currentEvent: $currentEvent, isAutoAdvancing: $isAutoAdvancing, yearlyRecap: $yearlyRecap)';
}


}

/// @nodoc
abstract mixin class $GameEnginePlayingCopyWith<$Res> implements $GameEngineStateCopyWith<$Res> {
  factory $GameEnginePlayingCopyWith(GameEnginePlaying value, $Res Function(GameEnginePlaying) _then) = _$GameEnginePlayingCopyWithImpl;
@useResult
$Res call({
 GameState gameState, Set<String> newlyUnlockedInsightCardIds, MonthlySummaryDelta? monthlySummary, GameEvent? currentEvent, bool isAutoAdvancing, YearlyRecap? yearlyRecap
});


$GameStateCopyWith<$Res> get gameState;$MonthlySummaryDeltaCopyWith<$Res>? get monthlySummary;$GameEventCopyWith<$Res>? get currentEvent;$YearlyRecapCopyWith<$Res>? get yearlyRecap;

}
/// @nodoc
class _$GameEnginePlayingCopyWithImpl<$Res>
    implements $GameEnginePlayingCopyWith<$Res> {
  _$GameEnginePlayingCopyWithImpl(this._self, this._then);

  final GameEnginePlaying _self;
  final $Res Function(GameEnginePlaying) _then;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gameState = null,Object? newlyUnlockedInsightCardIds = null,Object? monthlySummary = freezed,Object? currentEvent = freezed,Object? isAutoAdvancing = null,Object? yearlyRecap = freezed,}) {
  return _then(GameEnginePlaying(
null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as GameState,null == newlyUnlockedInsightCardIds ? _self._newlyUnlockedInsightCardIds : newlyUnlockedInsightCardIds // ignore: cast_nullable_to_non_nullable
as Set<String>,freezed == monthlySummary ? _self.monthlySummary : monthlySummary // ignore: cast_nullable_to_non_nullable
as MonthlySummaryDelta?,freezed == currentEvent ? _self.currentEvent : currentEvent // ignore: cast_nullable_to_non_nullable
as GameEvent?,null == isAutoAdvancing ? _self.isAutoAdvancing : isAutoAdvancing // ignore: cast_nullable_to_non_nullable
as bool,freezed == yearlyRecap ? _self.yearlyRecap : yearlyRecap // ignore: cast_nullable_to_non_nullable
as YearlyRecap?,
  ));
}

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get gameState {
  
  return $GameStateCopyWith<$Res>(_self.gameState, (value) {
    return _then(_self.copyWith(gameState: value));
  });
}/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlySummaryDeltaCopyWith<$Res>? get monthlySummary {
    if (_self.monthlySummary == null) {
    return null;
  }

  return $MonthlySummaryDeltaCopyWith<$Res>(_self.monthlySummary!, (value) {
    return _then(_self.copyWith(monthlySummary: value));
  });
}/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameEventCopyWith<$Res>? get currentEvent {
    if (_self.currentEvent == null) {
    return null;
  }

  return $GameEventCopyWith<$Res>(_self.currentEvent!, (value) {
    return _then(_self.copyWith(currentEvent: value));
  });
}/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$YearlyRecapCopyWith<$Res>? get yearlyRecap {
    if (_self.yearlyRecap == null) {
    return null;
  }

  return $YearlyRecapCopyWith<$Res>(_self.yearlyRecap!, (value) {
    return _then(_self.copyWith(yearlyRecap: value));
  });
}
}

/// @nodoc


class GameEngineGameOver implements GameEngineState {
  const GameEngineGameOver(this.reason, this.finalState, [final  Set<String> newlyUnlockedInsightCardIds = const {}]): _newlyUnlockedInsightCardIds = newlyUnlockedInsightCardIds;
  

 final  GameOverReason reason;
 final  GameState finalState;
 final  Set<String> _newlyUnlockedInsightCardIds;
@JsonKey() Set<String> get newlyUnlockedInsightCardIds {
  if (_newlyUnlockedInsightCardIds is EqualUnmodifiableSetView) return _newlyUnlockedInsightCardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_newlyUnlockedInsightCardIds);
}


/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameEngineGameOverCopyWith<GameEngineGameOver> get copyWith => _$GameEngineGameOverCopyWithImpl<GameEngineGameOver>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEngineGameOver&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.finalState, finalState) || other.finalState == finalState)&&const DeepCollectionEquality().equals(other._newlyUnlockedInsightCardIds, _newlyUnlockedInsightCardIds));
}


@override
int get hashCode => Object.hash(runtimeType,reason,finalState,const DeepCollectionEquality().hash(_newlyUnlockedInsightCardIds));

@override
String toString() {
  return 'GameEngineState.gameOver(reason: $reason, finalState: $finalState, newlyUnlockedInsightCardIds: $newlyUnlockedInsightCardIds)';
}


}

/// @nodoc
abstract mixin class $GameEngineGameOverCopyWith<$Res> implements $GameEngineStateCopyWith<$Res> {
  factory $GameEngineGameOverCopyWith(GameEngineGameOver value, $Res Function(GameEngineGameOver) _then) = _$GameEngineGameOverCopyWithImpl;
@useResult
$Res call({
 GameOverReason reason, GameState finalState, Set<String> newlyUnlockedInsightCardIds
});


$GameStateCopyWith<$Res> get finalState;

}
/// @nodoc
class _$GameEngineGameOverCopyWithImpl<$Res>
    implements $GameEngineGameOverCopyWith<$Res> {
  _$GameEngineGameOverCopyWithImpl(this._self, this._then);

  final GameEngineGameOver _self;
  final $Res Function(GameEngineGameOver) _then;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? finalState = null,Object? newlyUnlockedInsightCardIds = null,}) {
  return _then(GameEngineGameOver(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as GameOverReason,null == finalState ? _self.finalState : finalState // ignore: cast_nullable_to_non_nullable
as GameState,null == newlyUnlockedInsightCardIds ? _self._newlyUnlockedInsightCardIds : newlyUnlockedInsightCardIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get finalState {
  
  return $GameStateCopyWith<$Res>(_self.finalState, (value) {
    return _then(_self.copyWith(finalState: value));
  });
}
}

/// @nodoc


class GameEngineWon implements GameEngineState {
  const GameEngineWon(this.finalState, [final  Set<String> newlyUnlockedInsightCardIds = const {}]): _newlyUnlockedInsightCardIds = newlyUnlockedInsightCardIds;
  

 final  GameState finalState;
 final  Set<String> _newlyUnlockedInsightCardIds;
@JsonKey() Set<String> get newlyUnlockedInsightCardIds {
  if (_newlyUnlockedInsightCardIds is EqualUnmodifiableSetView) return _newlyUnlockedInsightCardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_newlyUnlockedInsightCardIds);
}


/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameEngineWonCopyWith<GameEngineWon> get copyWith => _$GameEngineWonCopyWithImpl<GameEngineWon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEngineWon&&(identical(other.finalState, finalState) || other.finalState == finalState)&&const DeepCollectionEquality().equals(other._newlyUnlockedInsightCardIds, _newlyUnlockedInsightCardIds));
}


@override
int get hashCode => Object.hash(runtimeType,finalState,const DeepCollectionEquality().hash(_newlyUnlockedInsightCardIds));

@override
String toString() {
  return 'GameEngineState.won(finalState: $finalState, newlyUnlockedInsightCardIds: $newlyUnlockedInsightCardIds)';
}


}

/// @nodoc
abstract mixin class $GameEngineWonCopyWith<$Res> implements $GameEngineStateCopyWith<$Res> {
  factory $GameEngineWonCopyWith(GameEngineWon value, $Res Function(GameEngineWon) _then) = _$GameEngineWonCopyWithImpl;
@useResult
$Res call({
 GameState finalState, Set<String> newlyUnlockedInsightCardIds
});


$GameStateCopyWith<$Res> get finalState;

}
/// @nodoc
class _$GameEngineWonCopyWithImpl<$Res>
    implements $GameEngineWonCopyWith<$Res> {
  _$GameEngineWonCopyWithImpl(this._self, this._then);

  final GameEngineWon _self;
  final $Res Function(GameEngineWon) _then;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? finalState = null,Object? newlyUnlockedInsightCardIds = null,}) {
  return _then(GameEngineWon(
null == finalState ? _self.finalState : finalState // ignore: cast_nullable_to_non_nullable
as GameState,null == newlyUnlockedInsightCardIds ? _self._newlyUnlockedInsightCardIds : newlyUnlockedInsightCardIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameStateCopyWith<$Res> get finalState {
  
  return $GameStateCopyWith<$Res>(_self.finalState, (value) {
    return _then(_self.copyWith(finalState: value));
  });
}
}

/// @nodoc


class GameEngineError implements GameEngineState {
  const GameEngineError(this.message);
  

 final  String message;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameEngineErrorCopyWith<GameEngineError> get copyWith => _$GameEngineErrorCopyWithImpl<GameEngineError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEngineError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GameEngineState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $GameEngineErrorCopyWith<$Res> implements $GameEngineStateCopyWith<$Res> {
  factory $GameEngineErrorCopyWith(GameEngineError value, $Res Function(GameEngineError) _then) = _$GameEngineErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GameEngineErrorCopyWithImpl<$Res>
    implements $GameEngineErrorCopyWith<$Res> {
  _$GameEngineErrorCopyWithImpl(this._self, this._then);

  final GameEngineError _self;
  final $Res Function(GameEngineError) _then;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GameEngineError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$YearlyRecap {

 double get totalCashIn; double get totalCashOut; List<MonthlyHistoryRecord> get topEvents;// Sorted by absolute cash impact
 List<MonthlyHistoryRecord> get fullHistory;
/// Create a copy of YearlyRecap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YearlyRecapCopyWith<YearlyRecap> get copyWith => _$YearlyRecapCopyWithImpl<YearlyRecap>(this as YearlyRecap, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YearlyRecap&&(identical(other.totalCashIn, totalCashIn) || other.totalCashIn == totalCashIn)&&(identical(other.totalCashOut, totalCashOut) || other.totalCashOut == totalCashOut)&&const DeepCollectionEquality().equals(other.topEvents, topEvents)&&const DeepCollectionEquality().equals(other.fullHistory, fullHistory));
}


@override
int get hashCode => Object.hash(runtimeType,totalCashIn,totalCashOut,const DeepCollectionEquality().hash(topEvents),const DeepCollectionEquality().hash(fullHistory));

@override
String toString() {
  return 'YearlyRecap(totalCashIn: $totalCashIn, totalCashOut: $totalCashOut, topEvents: $topEvents, fullHistory: $fullHistory)';
}


}

/// @nodoc
abstract mixin class $YearlyRecapCopyWith<$Res>  {
  factory $YearlyRecapCopyWith(YearlyRecap value, $Res Function(YearlyRecap) _then) = _$YearlyRecapCopyWithImpl;
@useResult
$Res call({
 double totalCashIn, double totalCashOut, List<MonthlyHistoryRecord> topEvents, List<MonthlyHistoryRecord> fullHistory
});




}
/// @nodoc
class _$YearlyRecapCopyWithImpl<$Res>
    implements $YearlyRecapCopyWith<$Res> {
  _$YearlyRecapCopyWithImpl(this._self, this._then);

  final YearlyRecap _self;
  final $Res Function(YearlyRecap) _then;

/// Create a copy of YearlyRecap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCashIn = null,Object? totalCashOut = null,Object? topEvents = null,Object? fullHistory = null,}) {
  return _then(_self.copyWith(
totalCashIn: null == totalCashIn ? _self.totalCashIn : totalCashIn // ignore: cast_nullable_to_non_nullable
as double,totalCashOut: null == totalCashOut ? _self.totalCashOut : totalCashOut // ignore: cast_nullable_to_non_nullable
as double,topEvents: null == topEvents ? _self.topEvents : topEvents // ignore: cast_nullable_to_non_nullable
as List<MonthlyHistoryRecord>,fullHistory: null == fullHistory ? _self.fullHistory : fullHistory // ignore: cast_nullable_to_non_nullable
as List<MonthlyHistoryRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [YearlyRecap].
extension YearlyRecapPatterns on YearlyRecap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YearlyRecap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YearlyRecap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YearlyRecap value)  $default,){
final _that = this;
switch (_that) {
case _YearlyRecap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YearlyRecap value)?  $default,){
final _that = this;
switch (_that) {
case _YearlyRecap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalCashIn,  double totalCashOut,  List<MonthlyHistoryRecord> topEvents,  List<MonthlyHistoryRecord> fullHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YearlyRecap() when $default != null:
return $default(_that.totalCashIn,_that.totalCashOut,_that.topEvents,_that.fullHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalCashIn,  double totalCashOut,  List<MonthlyHistoryRecord> topEvents,  List<MonthlyHistoryRecord> fullHistory)  $default,) {final _that = this;
switch (_that) {
case _YearlyRecap():
return $default(_that.totalCashIn,_that.totalCashOut,_that.topEvents,_that.fullHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalCashIn,  double totalCashOut,  List<MonthlyHistoryRecord> topEvents,  List<MonthlyHistoryRecord> fullHistory)?  $default,) {final _that = this;
switch (_that) {
case _YearlyRecap() when $default != null:
return $default(_that.totalCashIn,_that.totalCashOut,_that.topEvents,_that.fullHistory);case _:
  return null;

}
}

}

/// @nodoc


class _YearlyRecap implements YearlyRecap {
  const _YearlyRecap({required this.totalCashIn, required this.totalCashOut, required final  List<MonthlyHistoryRecord> topEvents, required final  List<MonthlyHistoryRecord> fullHistory}): _topEvents = topEvents,_fullHistory = fullHistory;
  

@override final  double totalCashIn;
@override final  double totalCashOut;
 final  List<MonthlyHistoryRecord> _topEvents;
@override List<MonthlyHistoryRecord> get topEvents {
  if (_topEvents is EqualUnmodifiableListView) return _topEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topEvents);
}

// Sorted by absolute cash impact
 final  List<MonthlyHistoryRecord> _fullHistory;
// Sorted by absolute cash impact
@override List<MonthlyHistoryRecord> get fullHistory {
  if (_fullHistory is EqualUnmodifiableListView) return _fullHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fullHistory);
}


/// Create a copy of YearlyRecap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YearlyRecapCopyWith<_YearlyRecap> get copyWith => __$YearlyRecapCopyWithImpl<_YearlyRecap>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YearlyRecap&&(identical(other.totalCashIn, totalCashIn) || other.totalCashIn == totalCashIn)&&(identical(other.totalCashOut, totalCashOut) || other.totalCashOut == totalCashOut)&&const DeepCollectionEquality().equals(other._topEvents, _topEvents)&&const DeepCollectionEquality().equals(other._fullHistory, _fullHistory));
}


@override
int get hashCode => Object.hash(runtimeType,totalCashIn,totalCashOut,const DeepCollectionEquality().hash(_topEvents),const DeepCollectionEquality().hash(_fullHistory));

@override
String toString() {
  return 'YearlyRecap(totalCashIn: $totalCashIn, totalCashOut: $totalCashOut, topEvents: $topEvents, fullHistory: $fullHistory)';
}


}

/// @nodoc
abstract mixin class _$YearlyRecapCopyWith<$Res> implements $YearlyRecapCopyWith<$Res> {
  factory _$YearlyRecapCopyWith(_YearlyRecap value, $Res Function(_YearlyRecap) _then) = __$YearlyRecapCopyWithImpl;
@override @useResult
$Res call({
 double totalCashIn, double totalCashOut, List<MonthlyHistoryRecord> topEvents, List<MonthlyHistoryRecord> fullHistory
});




}
/// @nodoc
class __$YearlyRecapCopyWithImpl<$Res>
    implements _$YearlyRecapCopyWith<$Res> {
  __$YearlyRecapCopyWithImpl(this._self, this._then);

  final _YearlyRecap _self;
  final $Res Function(_YearlyRecap) _then;

/// Create a copy of YearlyRecap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCashIn = null,Object? totalCashOut = null,Object? topEvents = null,Object? fullHistory = null,}) {
  return _then(_YearlyRecap(
totalCashIn: null == totalCashIn ? _self.totalCashIn : totalCashIn // ignore: cast_nullable_to_non_nullable
as double,totalCashOut: null == totalCashOut ? _self.totalCashOut : totalCashOut // ignore: cast_nullable_to_non_nullable
as double,topEvents: null == topEvents ? _self._topEvents : topEvents // ignore: cast_nullable_to_non_nullable
as List<MonthlyHistoryRecord>,fullHistory: null == fullHistory ? _self._fullHistory : fullHistory // ignore: cast_nullable_to_non_nullable
as List<MonthlyHistoryRecord>,
  ));
}


}

// dart format on
