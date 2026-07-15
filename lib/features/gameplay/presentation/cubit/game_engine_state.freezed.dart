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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( GameState gameState,  Set<String> newlyUnlockedInsightCardIds)?  playing,TResult Function( GameOverReason reason,  GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  gameOver,TResult Function( GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  won,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameEngineInitial() when initial != null:
return initial();case GameEnginePlaying() when playing != null:
return playing(_that.gameState,_that.newlyUnlockedInsightCardIds);case GameEngineGameOver() when gameOver != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( GameState gameState,  Set<String> newlyUnlockedInsightCardIds)  playing,required TResult Function( GameOverReason reason,  GameState finalState,  Set<String> newlyUnlockedInsightCardIds)  gameOver,required TResult Function( GameState finalState,  Set<String> newlyUnlockedInsightCardIds)  won,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case GameEngineInitial():
return initial();case GameEnginePlaying():
return playing(_that.gameState,_that.newlyUnlockedInsightCardIds);case GameEngineGameOver():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( GameState gameState,  Set<String> newlyUnlockedInsightCardIds)?  playing,TResult? Function( GameOverReason reason,  GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  gameOver,TResult? Function( GameState finalState,  Set<String> newlyUnlockedInsightCardIds)?  won,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case GameEngineInitial() when initial != null:
return initial();case GameEnginePlaying() when playing != null:
return playing(_that.gameState,_that.newlyUnlockedInsightCardIds);case GameEngineGameOver() when gameOver != null:
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
  const GameEnginePlaying(this.gameState, [final  Set<String> newlyUnlockedInsightCardIds = const {}]): _newlyUnlockedInsightCardIds = newlyUnlockedInsightCardIds;
  

 final  GameState gameState;
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
$GameEnginePlayingCopyWith<GameEnginePlaying> get copyWith => _$GameEnginePlayingCopyWithImpl<GameEnginePlaying>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEnginePlaying&&(identical(other.gameState, gameState) || other.gameState == gameState)&&const DeepCollectionEquality().equals(other._newlyUnlockedInsightCardIds, _newlyUnlockedInsightCardIds));
}


@override
int get hashCode => Object.hash(runtimeType,gameState,const DeepCollectionEquality().hash(_newlyUnlockedInsightCardIds));

@override
String toString() {
  return 'GameEngineState.playing(gameState: $gameState, newlyUnlockedInsightCardIds: $newlyUnlockedInsightCardIds)';
}


}

/// @nodoc
abstract mixin class $GameEnginePlayingCopyWith<$Res> implements $GameEngineStateCopyWith<$Res> {
  factory $GameEnginePlayingCopyWith(GameEnginePlaying value, $Res Function(GameEnginePlaying) _then) = _$GameEnginePlayingCopyWithImpl;
@useResult
$Res call({
 GameState gameState, Set<String> newlyUnlockedInsightCardIds
});


$GameStateCopyWith<$Res> get gameState;

}
/// @nodoc
class _$GameEnginePlayingCopyWithImpl<$Res>
    implements $GameEnginePlayingCopyWith<$Res> {
  _$GameEnginePlayingCopyWithImpl(this._self, this._then);

  final GameEnginePlaying _self;
  final $Res Function(GameEnginePlaying) _then;

/// Create a copy of GameEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gameState = null,Object? newlyUnlockedInsightCardIds = null,}) {
  return _then(GameEnginePlaying(
null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as GameState,null == newlyUnlockedInsightCardIds ? _self._newlyUnlockedInsightCardIds : newlyUnlockedInsightCardIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
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

// dart format on
