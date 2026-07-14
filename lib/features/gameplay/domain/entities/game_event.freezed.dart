// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<EventOption> get options => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameEventCopyWith<GameEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
  @useResult
  $Res call(
      {String id, String title, String description, List<EventOption> options});
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<EventOption>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameEventImplCopyWith<$Res>
    implements $GameEventCopyWith<$Res> {
  factory _$$GameEventImplCopyWith(
          _$GameEventImpl value, $Res Function(_$GameEventImpl) then) =
      __$$GameEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String title, String description, List<EventOption> options});
}

/// @nodoc
class __$$GameEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameEventImpl>
    implements _$$GameEventImplCopyWith<$Res> {
  __$$GameEventImplCopyWithImpl(
      _$GameEventImpl _value, $Res Function(_$GameEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? options = null,
  }) {
    return _then(_$GameEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<EventOption>,
    ));
  }
}

/// @nodoc

class _$GameEventImpl implements _GameEvent {
  const _$GameEventImpl(
      {required this.id,
      required this.title,
      required this.description,
      final List<EventOption> options = const []})
      : _options = options;

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  final List<EventOption> _options;
  @override
  @JsonKey()
  List<EventOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'GameEvent(id: $id, title: $title, description: $description, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      const DeepCollectionEquality().hash(_options));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      __$$GameEventImplCopyWithImpl<_$GameEventImpl>(this, _$identity);
}

abstract class _GameEvent implements GameEvent {
  const factory _GameEvent(
      {required final String id,
      required final String title,
      required final String description,
      final List<EventOption> options}) = _$GameEventImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<EventOption> get options;
  @override
  @JsonKey(ignore: true)
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventOption {
  String get id => throw _privateConstructorUsedError;
  String get label =>
      throw _privateConstructorUsedError; // Nút bấm hiển thị (VD: "Đi nhậu xả láng")
// Các tác động (Trade-offs) khi chọn option này
  double get cashEffect => throw _privateConstructorUsedError;
  int get stressEffect => throw _privateConstructorUsedError;
  int get networkEffect => throw _privateConstructorUsedError;
  int get creditEffect => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventOptionCopyWith<EventOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventOptionCopyWith<$Res> {
  factory $EventOptionCopyWith(
          EventOption value, $Res Function(EventOption) then) =
      _$EventOptionCopyWithImpl<$Res, EventOption>;
  @useResult
  $Res call(
      {String id,
      String label,
      double cashEffect,
      int stressEffect,
      int networkEffect,
      int creditEffect});
}

/// @nodoc
class _$EventOptionCopyWithImpl<$Res, $Val extends EventOption>
    implements $EventOptionCopyWith<$Res> {
  _$EventOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? cashEffect = null,
    Object? stressEffect = null,
    Object? networkEffect = null,
    Object? creditEffect = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      cashEffect: null == cashEffect
          ? _value.cashEffect
          : cashEffect // ignore: cast_nullable_to_non_nullable
              as double,
      stressEffect: null == stressEffect
          ? _value.stressEffect
          : stressEffect // ignore: cast_nullable_to_non_nullable
              as int,
      networkEffect: null == networkEffect
          ? _value.networkEffect
          : networkEffect // ignore: cast_nullable_to_non_nullable
              as int,
      creditEffect: null == creditEffect
          ? _value.creditEffect
          : creditEffect // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventOptionImplCopyWith<$Res>
    implements $EventOptionCopyWith<$Res> {
  factory _$$EventOptionImplCopyWith(
          _$EventOptionImpl value, $Res Function(_$EventOptionImpl) then) =
      __$$EventOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      double cashEffect,
      int stressEffect,
      int networkEffect,
      int creditEffect});
}

/// @nodoc
class __$$EventOptionImplCopyWithImpl<$Res>
    extends _$EventOptionCopyWithImpl<$Res, _$EventOptionImpl>
    implements _$$EventOptionImplCopyWith<$Res> {
  __$$EventOptionImplCopyWithImpl(
      _$EventOptionImpl _value, $Res Function(_$EventOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? cashEffect = null,
    Object? stressEffect = null,
    Object? networkEffect = null,
    Object? creditEffect = null,
  }) {
    return _then(_$EventOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      cashEffect: null == cashEffect
          ? _value.cashEffect
          : cashEffect // ignore: cast_nullable_to_non_nullable
              as double,
      stressEffect: null == stressEffect
          ? _value.stressEffect
          : stressEffect // ignore: cast_nullable_to_non_nullable
              as int,
      networkEffect: null == networkEffect
          ? _value.networkEffect
          : networkEffect // ignore: cast_nullable_to_non_nullable
              as int,
      creditEffect: null == creditEffect
          ? _value.creditEffect
          : creditEffect // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$EventOptionImpl implements _EventOption {
  const _$EventOptionImpl(
      {required this.id,
      required this.label,
      this.cashEffect = 0.0,
      this.stressEffect = 0,
      this.networkEffect = 0,
      this.creditEffect = 0});

  @override
  final String id;
  @override
  final String label;
// Nút bấm hiển thị (VD: "Đi nhậu xả láng")
// Các tác động (Trade-offs) khi chọn option này
  @override
  @JsonKey()
  final double cashEffect;
  @override
  @JsonKey()
  final int stressEffect;
  @override
  @JsonKey()
  final int networkEffect;
  @override
  @JsonKey()
  final int creditEffect;

  @override
  String toString() {
    return 'EventOption(id: $id, label: $label, cashEffect: $cashEffect, stressEffect: $stressEffect, networkEffect: $networkEffect, creditEffect: $creditEffect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.cashEffect, cashEffect) ||
                other.cashEffect == cashEffect) &&
            (identical(other.stressEffect, stressEffect) ||
                other.stressEffect == stressEffect) &&
            (identical(other.networkEffect, networkEffect) ||
                other.networkEffect == networkEffect) &&
            (identical(other.creditEffect, creditEffect) ||
                other.creditEffect == creditEffect));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, label, cashEffect,
      stressEffect, networkEffect, creditEffect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventOptionImplCopyWith<_$EventOptionImpl> get copyWith =>
      __$$EventOptionImplCopyWithImpl<_$EventOptionImpl>(this, _$identity);
}

abstract class _EventOption implements EventOption {
  const factory _EventOption(
      {required final String id,
      required final String label,
      final double cashEffect,
      final int stressEffect,
      final int networkEffect,
      final int creditEffect}) = _$EventOptionImpl;

  @override
  String get id;
  @override
  String get label;
  @override // Nút bấm hiển thị (VD: "Đi nhậu xả láng")
// Các tác động (Trade-offs) khi chọn option này
  double get cashEffect;
  @override
  int get stressEffect;
  @override
  int get networkEffect;
  @override
  int get creditEffect;
  @override
  @JsonKey(ignore: true)
  _$$EventOptionImplCopyWith<_$EventOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
