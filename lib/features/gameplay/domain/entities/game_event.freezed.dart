// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameEvent {

 String get id; String get title; String get description; List<EventOption> get options;
/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameEventCopyWith<GameEvent> get copyWith => _$GameEventCopyWithImpl<GameEvent>(this as GameEvent, _$identity);

  /// Serializes this GameEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'GameEvent(id: $id, title: $title, description: $description, options: $options)';
}


}

/// @nodoc
abstract mixin class $GameEventCopyWith<$Res>  {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) _then) = _$GameEventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, List<EventOption> options
});




}
/// @nodoc
class _$GameEventCopyWithImpl<$Res>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._self, this._then);

  final GameEvent _self;
  final $Res Function(GameEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? options = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<EventOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameEvent].
extension GameEventPatterns on GameEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameEvent value)  $default,){
final _that = this;
switch (_that) {
case _GameEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameEvent value)?  $default,){
final _that = this;
switch (_that) {
case _GameEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  List<EventOption> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameEvent() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  List<EventOption> options)  $default,) {final _that = this;
switch (_that) {
case _GameEvent():
return $default(_that.id,_that.title,_that.description,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  List<EventOption> options)?  $default,) {final _that = this;
switch (_that) {
case _GameEvent() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameEvent implements GameEvent {
  const _GameEvent({required this.id, required this.title, required this.description, final  List<EventOption> options = const []}): _options = options;
  factory _GameEvent.fromJson(Map<String, dynamic> json) => _$GameEventFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
 final  List<EventOption> _options;
@override@JsonKey() List<EventOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameEventCopyWith<_GameEvent> get copyWith => __$GameEventCopyWithImpl<_GameEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'GameEvent(id: $id, title: $title, description: $description, options: $options)';
}


}

/// @nodoc
abstract mixin class _$GameEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory _$GameEventCopyWith(_GameEvent value, $Res Function(_GameEvent) _then) = __$GameEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, List<EventOption> options
});




}
/// @nodoc
class __$GameEventCopyWithImpl<$Res>
    implements _$GameEventCopyWith<$Res> {
  __$GameEventCopyWithImpl(this._self, this._then);

  final _GameEvent _self;
  final $Res Function(_GameEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? options = null,}) {
  return _then(_GameEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<EventOption>,
  ));
}


}


/// @nodoc
mixin _$EventOption {

 String get id; String get label; EventEffect get effect;
/// Create a copy of EventOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOptionCopyWith<EventOption> get copyWith => _$EventOptionCopyWithImpl<EventOption>(this as EventOption, _$identity);

  /// Serializes this EventOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.effect, effect) || other.effect == effect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,effect);

@override
String toString() {
  return 'EventOption(id: $id, label: $label, effect: $effect)';
}


}

/// @nodoc
abstract mixin class $EventOptionCopyWith<$Res>  {
  factory $EventOptionCopyWith(EventOption value, $Res Function(EventOption) _then) = _$EventOptionCopyWithImpl;
@useResult
$Res call({
 String id, String label, EventEffect effect
});


$EventEffectCopyWith<$Res> get effect;

}
/// @nodoc
class _$EventOptionCopyWithImpl<$Res>
    implements $EventOptionCopyWith<$Res> {
  _$EventOptionCopyWithImpl(this._self, this._then);

  final EventOption _self;
  final $Res Function(EventOption) _then;

/// Create a copy of EventOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? effect = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as EventEffect,
  ));
}
/// Create a copy of EventOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEffectCopyWith<$Res> get effect {
  
  return $EventEffectCopyWith<$Res>(_self.effect, (value) {
    return _then(_self.copyWith(effect: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventOption].
extension EventOptionPatterns on EventOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOption value)  $default,){
final _that = this;
switch (_that) {
case _EventOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOption value)?  $default,){
final _that = this;
switch (_that) {
case _EventOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  EventEffect effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventOption() when $default != null:
return $default(_that.id,_that.label,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  EventEffect effect)  $default,) {final _that = this;
switch (_that) {
case _EventOption():
return $default(_that.id,_that.label,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  EventEffect effect)?  $default,) {final _that = this;
switch (_that) {
case _EventOption() when $default != null:
return $default(_that.id,_that.label,_that.effect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventOption implements EventOption {
  const _EventOption({required this.id, required this.label, this.effect = const EventEffect()});
  factory _EventOption.fromJson(Map<String, dynamic> json) => _$EventOptionFromJson(json);

@override final  String id;
@override final  String label;
@override@JsonKey() final  EventEffect effect;

/// Create a copy of EventOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOptionCopyWith<_EventOption> get copyWith => __$EventOptionCopyWithImpl<_EventOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.effect, effect) || other.effect == effect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,effect);

@override
String toString() {
  return 'EventOption(id: $id, label: $label, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$EventOptionCopyWith<$Res> implements $EventOptionCopyWith<$Res> {
  factory _$EventOptionCopyWith(_EventOption value, $Res Function(_EventOption) _then) = __$EventOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, EventEffect effect
});


@override $EventEffectCopyWith<$Res> get effect;

}
/// @nodoc
class __$EventOptionCopyWithImpl<$Res>
    implements _$EventOptionCopyWith<$Res> {
  __$EventOptionCopyWithImpl(this._self, this._then);

  final _EventOption _self;
  final $Res Function(_EventOption) _then;

/// Create a copy of EventOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? effect = null,}) {
  return _then(_EventOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as EventEffect,
  ));
}

/// Create a copy of EventOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEffectCopyWith<$Res> get effect {
  
  return $EventEffectCopyWith<$Res>(_self.effect, (value) {
    return _then(_self.copyWith(effect: value));
  });
}
}

// dart format on
