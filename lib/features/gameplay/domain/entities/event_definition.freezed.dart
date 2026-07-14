// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventDefinition {

 GameEvent get event; EventTrigger get trigger; double? get absoluteChance; double get weight;
/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDefinitionCopyWith<EventDefinition> get copyWith => _$EventDefinitionCopyWithImpl<EventDefinition>(this as EventDefinition, _$identity);

  /// Serializes this EventDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDefinition&&(identical(other.event, event) || other.event == event)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.absoluteChance, absoluteChance) || other.absoluteChance == absoluteChance)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,trigger,absoluteChance,weight);

@override
String toString() {
  return 'EventDefinition(event: $event, trigger: $trigger, absoluteChance: $absoluteChance, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $EventDefinitionCopyWith<$Res>  {
  factory $EventDefinitionCopyWith(EventDefinition value, $Res Function(EventDefinition) _then) = _$EventDefinitionCopyWithImpl;
@useResult
$Res call({
 GameEvent event, EventTrigger trigger, double? absoluteChance, double weight
});


$GameEventCopyWith<$Res> get event;$EventTriggerCopyWith<$Res> get trigger;

}
/// @nodoc
class _$EventDefinitionCopyWithImpl<$Res>
    implements $EventDefinitionCopyWith<$Res> {
  _$EventDefinitionCopyWithImpl(this._self, this._then);

  final EventDefinition _self;
  final $Res Function(EventDefinition) _then;

/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? trigger = null,Object? absoluteChance = freezed,Object? weight = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as GameEvent,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as EventTrigger,absoluteChance: freezed == absoluteChance ? _self.absoluteChance : absoluteChance // ignore: cast_nullable_to_non_nullable
as double?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameEventCopyWith<$Res> get event {
  
  return $GameEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTriggerCopyWith<$Res> get trigger {
  
  return $EventTriggerCopyWith<$Res>(_self.trigger, (value) {
    return _then(_self.copyWith(trigger: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDefinition].
extension EventDefinitionPatterns on EventDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDefinition value)  $default,){
final _that = this;
switch (_that) {
case _EventDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _EventDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GameEvent event,  EventTrigger trigger,  double? absoluteChance,  double weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDefinition() when $default != null:
return $default(_that.event,_that.trigger,_that.absoluteChance,_that.weight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GameEvent event,  EventTrigger trigger,  double? absoluteChance,  double weight)  $default,) {final _that = this;
switch (_that) {
case _EventDefinition():
return $default(_that.event,_that.trigger,_that.absoluteChance,_that.weight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GameEvent event,  EventTrigger trigger,  double? absoluteChance,  double weight)?  $default,) {final _that = this;
switch (_that) {
case _EventDefinition() when $default != null:
return $default(_that.event,_that.trigger,_that.absoluteChance,_that.weight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDefinition implements EventDefinition {
  const _EventDefinition({required this.event, required this.trigger, this.absoluteChance, this.weight = 1.0});
  factory _EventDefinition.fromJson(Map<String, dynamic> json) => _$EventDefinitionFromJson(json);

@override final  GameEvent event;
@override final  EventTrigger trigger;
@override final  double? absoluteChance;
@override@JsonKey() final  double weight;

/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDefinitionCopyWith<_EventDefinition> get copyWith => __$EventDefinitionCopyWithImpl<_EventDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDefinition&&(identical(other.event, event) || other.event == event)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.absoluteChance, absoluteChance) || other.absoluteChance == absoluteChance)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,trigger,absoluteChance,weight);

@override
String toString() {
  return 'EventDefinition(event: $event, trigger: $trigger, absoluteChance: $absoluteChance, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$EventDefinitionCopyWith<$Res> implements $EventDefinitionCopyWith<$Res> {
  factory _$EventDefinitionCopyWith(_EventDefinition value, $Res Function(_EventDefinition) _then) = __$EventDefinitionCopyWithImpl;
@override @useResult
$Res call({
 GameEvent event, EventTrigger trigger, double? absoluteChance, double weight
});


@override $GameEventCopyWith<$Res> get event;@override $EventTriggerCopyWith<$Res> get trigger;

}
/// @nodoc
class __$EventDefinitionCopyWithImpl<$Res>
    implements _$EventDefinitionCopyWith<$Res> {
  __$EventDefinitionCopyWithImpl(this._self, this._then);

  final _EventDefinition _self;
  final $Res Function(_EventDefinition) _then;

/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? trigger = null,Object? absoluteChance = freezed,Object? weight = null,}) {
  return _then(_EventDefinition(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as GameEvent,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as EventTrigger,absoluteChance: freezed == absoluteChance ? _self.absoluteChance : absoluteChance // ignore: cast_nullable_to_non_nullable
as double?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameEventCopyWith<$Res> get event {
  
  return $GameEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTriggerCopyWith<$Res> get trigger {
  
  return $EventTriggerCopyWith<$Res>(_self.trigger, (value) {
    return _then(_self.copyWith(trigger: value));
  });
}
}


/// @nodoc
mixin _$EventTrigger {

 int? get minAgeInMonths; int? get maxAgeInMonths; int? get minStress; int? get maxStress; List<int> get targetCalendarMonths; Set<String> get requiredFlags; Set<String> get excludedFlags;
/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTriggerCopyWith<EventTrigger> get copyWith => _$EventTriggerCopyWithImpl<EventTrigger>(this as EventTrigger, _$identity);

  /// Serializes this EventTrigger to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTrigger&&(identical(other.minAgeInMonths, minAgeInMonths) || other.minAgeInMonths == minAgeInMonths)&&(identical(other.maxAgeInMonths, maxAgeInMonths) || other.maxAgeInMonths == maxAgeInMonths)&&(identical(other.minStress, minStress) || other.minStress == minStress)&&(identical(other.maxStress, maxStress) || other.maxStress == maxStress)&&const DeepCollectionEquality().equals(other.targetCalendarMonths, targetCalendarMonths)&&const DeepCollectionEquality().equals(other.requiredFlags, requiredFlags)&&const DeepCollectionEquality().equals(other.excludedFlags, excludedFlags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minAgeInMonths,maxAgeInMonths,minStress,maxStress,const DeepCollectionEquality().hash(targetCalendarMonths),const DeepCollectionEquality().hash(requiredFlags),const DeepCollectionEquality().hash(excludedFlags));

@override
String toString() {
  return 'EventTrigger(minAgeInMonths: $minAgeInMonths, maxAgeInMonths: $maxAgeInMonths, minStress: $minStress, maxStress: $maxStress, targetCalendarMonths: $targetCalendarMonths, requiredFlags: $requiredFlags, excludedFlags: $excludedFlags)';
}


}

/// @nodoc
abstract mixin class $EventTriggerCopyWith<$Res>  {
  factory $EventTriggerCopyWith(EventTrigger value, $Res Function(EventTrigger) _then) = _$EventTriggerCopyWithImpl;
@useResult
$Res call({
 int? minAgeInMonths, int? maxAgeInMonths, int? minStress, int? maxStress, List<int> targetCalendarMonths, Set<String> requiredFlags, Set<String> excludedFlags
});




}
/// @nodoc
class _$EventTriggerCopyWithImpl<$Res>
    implements $EventTriggerCopyWith<$Res> {
  _$EventTriggerCopyWithImpl(this._self, this._then);

  final EventTrigger _self;
  final $Res Function(EventTrigger) _then;

/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minAgeInMonths = freezed,Object? maxAgeInMonths = freezed,Object? minStress = freezed,Object? maxStress = freezed,Object? targetCalendarMonths = null,Object? requiredFlags = null,Object? excludedFlags = null,}) {
  return _then(_self.copyWith(
minAgeInMonths: freezed == minAgeInMonths ? _self.minAgeInMonths : minAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,maxAgeInMonths: freezed == maxAgeInMonths ? _self.maxAgeInMonths : maxAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,minStress: freezed == minStress ? _self.minStress : minStress // ignore: cast_nullable_to_non_nullable
as int?,maxStress: freezed == maxStress ? _self.maxStress : maxStress // ignore: cast_nullable_to_non_nullable
as int?,targetCalendarMonths: null == targetCalendarMonths ? _self.targetCalendarMonths : targetCalendarMonths // ignore: cast_nullable_to_non_nullable
as List<int>,requiredFlags: null == requiredFlags ? _self.requiredFlags : requiredFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,excludedFlags: null == excludedFlags ? _self.excludedFlags : excludedFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventTrigger].
extension EventTriggerPatterns on EventTrigger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventTrigger value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventTrigger() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventTrigger value)  $default,){
final _that = this;
switch (_that) {
case _EventTrigger():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventTrigger value)?  $default,){
final _that = this;
switch (_that) {
case _EventTrigger() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? minAgeInMonths,  int? maxAgeInMonths,  int? minStress,  int? maxStress,  List<int> targetCalendarMonths,  Set<String> requiredFlags,  Set<String> excludedFlags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventTrigger() when $default != null:
return $default(_that.minAgeInMonths,_that.maxAgeInMonths,_that.minStress,_that.maxStress,_that.targetCalendarMonths,_that.requiredFlags,_that.excludedFlags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? minAgeInMonths,  int? maxAgeInMonths,  int? minStress,  int? maxStress,  List<int> targetCalendarMonths,  Set<String> requiredFlags,  Set<String> excludedFlags)  $default,) {final _that = this;
switch (_that) {
case _EventTrigger():
return $default(_that.minAgeInMonths,_that.maxAgeInMonths,_that.minStress,_that.maxStress,_that.targetCalendarMonths,_that.requiredFlags,_that.excludedFlags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? minAgeInMonths,  int? maxAgeInMonths,  int? minStress,  int? maxStress,  List<int> targetCalendarMonths,  Set<String> requiredFlags,  Set<String> excludedFlags)?  $default,) {final _that = this;
switch (_that) {
case _EventTrigger() when $default != null:
return $default(_that.minAgeInMonths,_that.maxAgeInMonths,_that.minStress,_that.maxStress,_that.targetCalendarMonths,_that.requiredFlags,_that.excludedFlags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventTrigger implements EventTrigger {
  const _EventTrigger({this.minAgeInMonths, this.maxAgeInMonths, this.minStress, this.maxStress, final  List<int> targetCalendarMonths = const [], final  Set<String> requiredFlags = const {}, final  Set<String> excludedFlags = const {}}): _targetCalendarMonths = targetCalendarMonths,_requiredFlags = requiredFlags,_excludedFlags = excludedFlags;
  factory _EventTrigger.fromJson(Map<String, dynamic> json) => _$EventTriggerFromJson(json);

@override final  int? minAgeInMonths;
@override final  int? maxAgeInMonths;
@override final  int? minStress;
@override final  int? maxStress;
 final  List<int> _targetCalendarMonths;
@override@JsonKey() List<int> get targetCalendarMonths {
  if (_targetCalendarMonths is EqualUnmodifiableListView) return _targetCalendarMonths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetCalendarMonths);
}

 final  Set<String> _requiredFlags;
@override@JsonKey() Set<String> get requiredFlags {
  if (_requiredFlags is EqualUnmodifiableSetView) return _requiredFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_requiredFlags);
}

 final  Set<String> _excludedFlags;
@override@JsonKey() Set<String> get excludedFlags {
  if (_excludedFlags is EqualUnmodifiableSetView) return _excludedFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_excludedFlags);
}


/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTriggerCopyWith<_EventTrigger> get copyWith => __$EventTriggerCopyWithImpl<_EventTrigger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventTriggerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTrigger&&(identical(other.minAgeInMonths, minAgeInMonths) || other.minAgeInMonths == minAgeInMonths)&&(identical(other.maxAgeInMonths, maxAgeInMonths) || other.maxAgeInMonths == maxAgeInMonths)&&(identical(other.minStress, minStress) || other.minStress == minStress)&&(identical(other.maxStress, maxStress) || other.maxStress == maxStress)&&const DeepCollectionEquality().equals(other._targetCalendarMonths, _targetCalendarMonths)&&const DeepCollectionEquality().equals(other._requiredFlags, _requiredFlags)&&const DeepCollectionEquality().equals(other._excludedFlags, _excludedFlags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minAgeInMonths,maxAgeInMonths,minStress,maxStress,const DeepCollectionEquality().hash(_targetCalendarMonths),const DeepCollectionEquality().hash(_requiredFlags),const DeepCollectionEquality().hash(_excludedFlags));

@override
String toString() {
  return 'EventTrigger(minAgeInMonths: $minAgeInMonths, maxAgeInMonths: $maxAgeInMonths, minStress: $minStress, maxStress: $maxStress, targetCalendarMonths: $targetCalendarMonths, requiredFlags: $requiredFlags, excludedFlags: $excludedFlags)';
}


}

/// @nodoc
abstract mixin class _$EventTriggerCopyWith<$Res> implements $EventTriggerCopyWith<$Res> {
  factory _$EventTriggerCopyWith(_EventTrigger value, $Res Function(_EventTrigger) _then) = __$EventTriggerCopyWithImpl;
@override @useResult
$Res call({
 int? minAgeInMonths, int? maxAgeInMonths, int? minStress, int? maxStress, List<int> targetCalendarMonths, Set<String> requiredFlags, Set<String> excludedFlags
});




}
/// @nodoc
class __$EventTriggerCopyWithImpl<$Res>
    implements _$EventTriggerCopyWith<$Res> {
  __$EventTriggerCopyWithImpl(this._self, this._then);

  final _EventTrigger _self;
  final $Res Function(_EventTrigger) _then;

/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minAgeInMonths = freezed,Object? maxAgeInMonths = freezed,Object? minStress = freezed,Object? maxStress = freezed,Object? targetCalendarMonths = null,Object? requiredFlags = null,Object? excludedFlags = null,}) {
  return _then(_EventTrigger(
minAgeInMonths: freezed == minAgeInMonths ? _self.minAgeInMonths : minAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,maxAgeInMonths: freezed == maxAgeInMonths ? _self.maxAgeInMonths : maxAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,minStress: freezed == minStress ? _self.minStress : minStress // ignore: cast_nullable_to_non_nullable
as int?,maxStress: freezed == maxStress ? _self.maxStress : maxStress // ignore: cast_nullable_to_non_nullable
as int?,targetCalendarMonths: null == targetCalendarMonths ? _self._targetCalendarMonths : targetCalendarMonths // ignore: cast_nullable_to_non_nullable
as List<int>,requiredFlags: null == requiredFlags ? _self._requiredFlags : requiredFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,excludedFlags: null == excludedFlags ? _self._excludedFlags : excludedFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
