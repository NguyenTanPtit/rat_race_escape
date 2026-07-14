// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_engine_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameEngineState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GameState gameState) playing,
    required TResult Function(String reason, GameState finalState) gameOver,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GameState gameState)? playing,
    TResult? Function(String reason, GameState finalState)? gameOver,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GameState gameState)? playing,
    TResult Function(String reason, GameState finalState)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEngineStateCopyWith<$Res> {
  factory $GameEngineStateCopyWith(
          GameEngineState value, $Res Function(GameEngineState) then) =
      _$GameEngineStateCopyWithImpl<$Res, GameEngineState>;
}

/// @nodoc
class _$GameEngineStateCopyWithImpl<$Res, $Val extends GameEngineState>
    implements $GameEngineStateCopyWith<$Res> {
  _$GameEngineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$GameEngineStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'GameEngineState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GameState gameState) playing,
    required TResult Function(String reason, GameState finalState) gameOver,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GameState gameState)? playing,
    TResult? Function(String reason, GameState finalState)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GameState gameState)? playing,
    TResult Function(String reason, GameState finalState)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GameEngineState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$GameEngineStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'GameEngineState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GameState gameState) playing,
    required TResult Function(String reason, GameState finalState) gameOver,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GameState gameState)? playing,
    TResult? Function(String reason, GameState finalState)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GameState gameState)? playing,
    TResult Function(String reason, GameState finalState)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements GameEngineState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
          _$PlayingImpl value, $Res Function(_$PlayingImpl) then) =
      __$$PlayingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GameState gameState});

  $GameStateCopyWith<$Res> get gameState;
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$GameEngineStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
      _$PlayingImpl _value, $Res Function(_$PlayingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameState = null,
  }) {
    return _then(_$PlayingImpl(
      null == gameState
          ? _value.gameState
          : gameState // ignore: cast_nullable_to_non_nullable
              as GameState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GameStateCopyWith<$Res> get gameState {
    return $GameStateCopyWith<$Res>(_value.gameState, (value) {
      return _then(_value.copyWith(gameState: value));
    });
  }
}

/// @nodoc

class _$PlayingImpl implements _Playing {
  const _$PlayingImpl(this.gameState);

  @override
  final GameState gameState;

  @override
  String toString() {
    return 'GameEngineState.playing(gameState: $gameState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayingImpl &&
            (identical(other.gameState, gameState) ||
                other.gameState == gameState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      __$$PlayingImplCopyWithImpl<_$PlayingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GameState gameState) playing,
    required TResult Function(String reason, GameState finalState) gameOver,
    required TResult Function(String message) error,
  }) {
    return playing(gameState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GameState gameState)? playing,
    TResult? Function(String reason, GameState finalState)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return playing?.call(gameState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GameState gameState)? playing,
    TResult Function(String reason, GameState finalState)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(gameState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class _Playing implements GameEngineState {
  const factory _Playing(final GameState gameState) = _$PlayingImpl;

  GameState get gameState;
  @JsonKey(ignore: true)
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GameOverImplCopyWith<$Res> {
  factory _$$GameOverImplCopyWith(
          _$GameOverImpl value, $Res Function(_$GameOverImpl) then) =
      __$$GameOverImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason, GameState finalState});

  $GameStateCopyWith<$Res> get finalState;
}

/// @nodoc
class __$$GameOverImplCopyWithImpl<$Res>
    extends _$GameEngineStateCopyWithImpl<$Res, _$GameOverImpl>
    implements _$$GameOverImplCopyWith<$Res> {
  __$$GameOverImplCopyWithImpl(
      _$GameOverImpl _value, $Res Function(_$GameOverImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? finalState = null,
  }) {
    return _then(_$GameOverImpl(
      null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      null == finalState
          ? _value.finalState
          : finalState // ignore: cast_nullable_to_non_nullable
              as GameState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GameStateCopyWith<$Res> get finalState {
    return $GameStateCopyWith<$Res>(_value.finalState, (value) {
      return _then(_value.copyWith(finalState: value));
    });
  }
}

/// @nodoc

class _$GameOverImpl implements _GameOver {
  const _$GameOverImpl(this.reason, this.finalState);

  @override
  final String reason;
  @override
  final GameState finalState;

  @override
  String toString() {
    return 'GameEngineState.gameOver(reason: $reason, finalState: $finalState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameOverImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.finalState, finalState) ||
                other.finalState == finalState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason, finalState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameOverImplCopyWith<_$GameOverImpl> get copyWith =>
      __$$GameOverImplCopyWithImpl<_$GameOverImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GameState gameState) playing,
    required TResult Function(String reason, GameState finalState) gameOver,
    required TResult Function(String message) error,
  }) {
    return gameOver(reason, finalState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GameState gameState)? playing,
    TResult? Function(String reason, GameState finalState)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return gameOver?.call(reason, finalState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GameState gameState)? playing,
    TResult Function(String reason, GameState finalState)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (gameOver != null) {
      return gameOver(reason, finalState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return gameOver(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return gameOver?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (gameOver != null) {
      return gameOver(this);
    }
    return orElse();
  }
}

abstract class _GameOver implements GameEngineState {
  const factory _GameOver(final String reason, final GameState finalState) =
      _$GameOverImpl;

  String get reason;
  GameState get finalState;
  @JsonKey(ignore: true)
  _$$GameOverImplCopyWith<_$GameOverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$GameEngineStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'GameEngineState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(GameState gameState) playing,
    required TResult Function(String reason, GameState finalState) gameOver,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(GameState gameState)? playing,
    TResult? Function(String reason, GameState finalState)? gameOver,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(GameState gameState)? playing,
    TResult Function(String reason, GameState finalState)? gameOver,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Playing value) playing,
    required TResult Function(_GameOver value) gameOver,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Playing value)? playing,
    TResult? Function(_GameOver value)? gameOver,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Playing value)? playing,
    TResult Function(_GameOver value)? gameOver,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements GameEngineState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
