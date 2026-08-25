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

 GameEvent get event; EventTrigger get trigger; double? get absoluteChance; double get weight;// Slice 5a: once fired, the event cannot fire again for this many months.
// 0 = no cooldown.
 int get cooldownMonths;
/// Create a copy of EventDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDefinitionCopyWith<EventDefinition> get copyWith => _$EventDefinitionCopyWithImpl<EventDefinition>(this as EventDefinition, _$identity);

  /// Serializes this EventDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDefinition&&(identical(other.event, event) || other.event == event)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.absoluteChance, absoluteChance) || other.absoluteChance == absoluteChance)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.cooldownMonths, cooldownMonths) || other.cooldownMonths == cooldownMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,trigger,absoluteChance,weight,cooldownMonths);

@override
String toString() {
  return 'EventDefinition(event: $event, trigger: $trigger, absoluteChance: $absoluteChance, weight: $weight, cooldownMonths: $cooldownMonths)';
}


}

/// @nodoc
abstract mixin class $EventDefinitionCopyWith<$Res>  {
  factory $EventDefinitionCopyWith(EventDefinition value, $Res Function(EventDefinition) _then) = _$EventDefinitionCopyWithImpl;
@useResult
$Res call({
 GameEvent event, EventTrigger trigger, double? absoluteChance, double weight, int cooldownMonths
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
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? trigger = null,Object? absoluteChance = freezed,Object? weight = null,Object? cooldownMonths = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as GameEvent,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as EventTrigger,absoluteChance: freezed == absoluteChance ? _self.absoluteChance : absoluteChance // ignore: cast_nullable_to_non_nullable
as double?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,cooldownMonths: null == cooldownMonths ? _self.cooldownMonths : cooldownMonths // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GameEvent event,  EventTrigger trigger,  double? absoluteChance,  double weight,  int cooldownMonths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDefinition() when $default != null:
return $default(_that.event,_that.trigger,_that.absoluteChance,_that.weight,_that.cooldownMonths);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GameEvent event,  EventTrigger trigger,  double? absoluteChance,  double weight,  int cooldownMonths)  $default,) {final _that = this;
switch (_that) {
case _EventDefinition():
return $default(_that.event,_that.trigger,_that.absoluteChance,_that.weight,_that.cooldownMonths);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GameEvent event,  EventTrigger trigger,  double? absoluteChance,  double weight,  int cooldownMonths)?  $default,) {final _that = this;
switch (_that) {
case _EventDefinition() when $default != null:
return $default(_that.event,_that.trigger,_that.absoluteChance,_that.weight,_that.cooldownMonths);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDefinition implements EventDefinition {
  const _EventDefinition({required this.event, required this.trigger, this.absoluteChance, this.weight = 1.0, this.cooldownMonths = 0});
  factory _EventDefinition.fromJson(Map<String, dynamic> json) => _$EventDefinitionFromJson(json);

@override final  GameEvent event;
@override final  EventTrigger trigger;
@override final  double? absoluteChance;
@override@JsonKey() final  double weight;
// Slice 5a: once fired, the event cannot fire again for this many months.
// 0 = no cooldown.
@override@JsonKey() final  int cooldownMonths;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDefinition&&(identical(other.event, event) || other.event == event)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.absoluteChance, absoluteChance) || other.absoluteChance == absoluteChance)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.cooldownMonths, cooldownMonths) || other.cooldownMonths == cooldownMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,trigger,absoluteChance,weight,cooldownMonths);

@override
String toString() {
  return 'EventDefinition(event: $event, trigger: $trigger, absoluteChance: $absoluteChance, weight: $weight, cooldownMonths: $cooldownMonths)';
}


}

/// @nodoc
abstract mixin class _$EventDefinitionCopyWith<$Res> implements $EventDefinitionCopyWith<$Res> {
  factory _$EventDefinitionCopyWith(_EventDefinition value, $Res Function(_EventDefinition) _then) = __$EventDefinitionCopyWithImpl;
@override @useResult
$Res call({
 GameEvent event, EventTrigger trigger, double? absoluteChance, double weight, int cooldownMonths
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
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? trigger = null,Object? absoluteChance = freezed,Object? weight = null,Object? cooldownMonths = null,}) {
  return _then(_EventDefinition(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as GameEvent,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as EventTrigger,absoluteChance: freezed == absoluteChance ? _self.absoluteChance : absoluteChance // ignore: cast_nullable_to_non_nullable
as double?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,cooldownMonths: null == cooldownMonths ? _self.cooldownMonths : cooldownMonths // ignore: cast_nullable_to_non_nullable
as int,
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
mixin _$MarketCondition {

 String get classId; double get value;
/// Create a copy of MarketCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketConditionCopyWith<MarketCondition> get copyWith => _$MarketConditionCopyWithImpl<MarketCondition>(this as MarketCondition, _$identity);

  /// Serializes this MarketCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketCondition&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,value);

@override
String toString() {
  return 'MarketCondition(classId: $classId, value: $value)';
}


}

/// @nodoc
abstract mixin class $MarketConditionCopyWith<$Res>  {
  factory $MarketConditionCopyWith(MarketCondition value, $Res Function(MarketCondition) _then) = _$MarketConditionCopyWithImpl;
@useResult
$Res call({
 String classId, double value
});




}
/// @nodoc
class _$MarketConditionCopyWithImpl<$Res>
    implements $MarketConditionCopyWith<$Res> {
  _$MarketConditionCopyWithImpl(this._self, this._then);

  final MarketCondition _self;
  final $Res Function(MarketCondition) _then;

/// Create a copy of MarketCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? value = null,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketCondition].
extension MarketConditionPatterns on MarketCondition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketCondition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketCondition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketCondition value)  $default,){
final _that = this;
switch (_that) {
case _MarketCondition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketCondition value)?  $default,){
final _that = this;
switch (_that) {
case _MarketCondition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classId,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketCondition() when $default != null:
return $default(_that.classId,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classId,  double value)  $default,) {final _that = this;
switch (_that) {
case _MarketCondition():
return $default(_that.classId,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classId,  double value)?  $default,) {final _that = this;
switch (_that) {
case _MarketCondition() when $default != null:
return $default(_that.classId,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketCondition implements MarketCondition {
  const _MarketCondition({required this.classId, required this.value});
  factory _MarketCondition.fromJson(Map<String, dynamic> json) => _$MarketConditionFromJson(json);

@override final  String classId;
@override final  double value;

/// Create a copy of MarketCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketConditionCopyWith<_MarketCondition> get copyWith => __$MarketConditionCopyWithImpl<_MarketCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketCondition&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,value);

@override
String toString() {
  return 'MarketCondition(classId: $classId, value: $value)';
}


}

/// @nodoc
abstract mixin class _$MarketConditionCopyWith<$Res> implements $MarketConditionCopyWith<$Res> {
  factory _$MarketConditionCopyWith(_MarketCondition value, $Res Function(_MarketCondition) _then) = __$MarketConditionCopyWithImpl;
@override @useResult
$Res call({
 String classId, double value
});




}
/// @nodoc
class __$MarketConditionCopyWithImpl<$Res>
    implements _$MarketConditionCopyWith<$Res> {
  __$MarketConditionCopyWithImpl(this._self, this._then);

  final _MarketCondition _self;
  final $Res Function(_MarketCondition) _then;

/// Create a copy of MarketCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? value = null,}) {
  return _then(_MarketCondition(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EventTrigger {

 int? get minAgeInMonths; int? get maxAgeInMonths; int? get minStress; int? get maxStress; List<int> get targetCalendarMonths; Set<String> get requiredFlags; Set<String> get excludedFlags;// 6.2b: shock & market-aware triggers
 double? get maxCash;// fires while state.cash < maxCash (e.g. 0 = broke)
 MarketCondition? get minMarketDrawdown;// class drawdown >= value
 MarketCondition? get minMarketTrailingRatio;
/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTriggerCopyWith<EventTrigger> get copyWith => _$EventTriggerCopyWithImpl<EventTrigger>(this as EventTrigger, _$identity);

  /// Serializes this EventTrigger to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTrigger&&(identical(other.minAgeInMonths, minAgeInMonths) || other.minAgeInMonths == minAgeInMonths)&&(identical(other.maxAgeInMonths, maxAgeInMonths) || other.maxAgeInMonths == maxAgeInMonths)&&(identical(other.minStress, minStress) || other.minStress == minStress)&&(identical(other.maxStress, maxStress) || other.maxStress == maxStress)&&const DeepCollectionEquality().equals(other.targetCalendarMonths, targetCalendarMonths)&&const DeepCollectionEquality().equals(other.requiredFlags, requiredFlags)&&const DeepCollectionEquality().equals(other.excludedFlags, excludedFlags)&&(identical(other.maxCash, maxCash) || other.maxCash == maxCash)&&(identical(other.minMarketDrawdown, minMarketDrawdown) || other.minMarketDrawdown == minMarketDrawdown)&&(identical(other.minMarketTrailingRatio, minMarketTrailingRatio) || other.minMarketTrailingRatio == minMarketTrailingRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minAgeInMonths,maxAgeInMonths,minStress,maxStress,const DeepCollectionEquality().hash(targetCalendarMonths),const DeepCollectionEquality().hash(requiredFlags),const DeepCollectionEquality().hash(excludedFlags),maxCash,minMarketDrawdown,minMarketTrailingRatio);

@override
String toString() {
  return 'EventTrigger(minAgeInMonths: $minAgeInMonths, maxAgeInMonths: $maxAgeInMonths, minStress: $minStress, maxStress: $maxStress, targetCalendarMonths: $targetCalendarMonths, requiredFlags: $requiredFlags, excludedFlags: $excludedFlags, maxCash: $maxCash, minMarketDrawdown: $minMarketDrawdown, minMarketTrailingRatio: $minMarketTrailingRatio)';
}


}

/// @nodoc
abstract mixin class $EventTriggerCopyWith<$Res>  {
  factory $EventTriggerCopyWith(EventTrigger value, $Res Function(EventTrigger) _then) = _$EventTriggerCopyWithImpl;
@useResult
$Res call({
 int? minAgeInMonths, int? maxAgeInMonths, int? minStress, int? maxStress, List<int> targetCalendarMonths, Set<String> requiredFlags, Set<String> excludedFlags, double? maxCash, MarketCondition? minMarketDrawdown, MarketCondition? minMarketTrailingRatio
});


$MarketConditionCopyWith<$Res>? get minMarketDrawdown;$MarketConditionCopyWith<$Res>? get minMarketTrailingRatio;

}
/// @nodoc
class _$EventTriggerCopyWithImpl<$Res>
    implements $EventTriggerCopyWith<$Res> {
  _$EventTriggerCopyWithImpl(this._self, this._then);

  final EventTrigger _self;
  final $Res Function(EventTrigger) _then;

/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minAgeInMonths = freezed,Object? maxAgeInMonths = freezed,Object? minStress = freezed,Object? maxStress = freezed,Object? targetCalendarMonths = null,Object? requiredFlags = null,Object? excludedFlags = null,Object? maxCash = freezed,Object? minMarketDrawdown = freezed,Object? minMarketTrailingRatio = freezed,}) {
  return _then(_self.copyWith(
minAgeInMonths: freezed == minAgeInMonths ? _self.minAgeInMonths : minAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,maxAgeInMonths: freezed == maxAgeInMonths ? _self.maxAgeInMonths : maxAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,minStress: freezed == minStress ? _self.minStress : minStress // ignore: cast_nullable_to_non_nullable
as int?,maxStress: freezed == maxStress ? _self.maxStress : maxStress // ignore: cast_nullable_to_non_nullable
as int?,targetCalendarMonths: null == targetCalendarMonths ? _self.targetCalendarMonths : targetCalendarMonths // ignore: cast_nullable_to_non_nullable
as List<int>,requiredFlags: null == requiredFlags ? _self.requiredFlags : requiredFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,excludedFlags: null == excludedFlags ? _self.excludedFlags : excludedFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,maxCash: freezed == maxCash ? _self.maxCash : maxCash // ignore: cast_nullable_to_non_nullable
as double?,minMarketDrawdown: freezed == minMarketDrawdown ? _self.minMarketDrawdown : minMarketDrawdown // ignore: cast_nullable_to_non_nullable
as MarketCondition?,minMarketTrailingRatio: freezed == minMarketTrailingRatio ? _self.minMarketTrailingRatio : minMarketTrailingRatio // ignore: cast_nullable_to_non_nullable
as MarketCondition?,
  ));
}
/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketConditionCopyWith<$Res>? get minMarketDrawdown {
    if (_self.minMarketDrawdown == null) {
    return null;
  }

  return $MarketConditionCopyWith<$Res>(_self.minMarketDrawdown!, (value) {
    return _then(_self.copyWith(minMarketDrawdown: value));
  });
}/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketConditionCopyWith<$Res>? get minMarketTrailingRatio {
    if (_self.minMarketTrailingRatio == null) {
    return null;
  }

  return $MarketConditionCopyWith<$Res>(_self.minMarketTrailingRatio!, (value) {
    return _then(_self.copyWith(minMarketTrailingRatio: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? minAgeInMonths,  int? maxAgeInMonths,  int? minStress,  int? maxStress,  List<int> targetCalendarMonths,  Set<String> requiredFlags,  Set<String> excludedFlags,  double? maxCash,  MarketCondition? minMarketDrawdown,  MarketCondition? minMarketTrailingRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventTrigger() when $default != null:
return $default(_that.minAgeInMonths,_that.maxAgeInMonths,_that.minStress,_that.maxStress,_that.targetCalendarMonths,_that.requiredFlags,_that.excludedFlags,_that.maxCash,_that.minMarketDrawdown,_that.minMarketTrailingRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? minAgeInMonths,  int? maxAgeInMonths,  int? minStress,  int? maxStress,  List<int> targetCalendarMonths,  Set<String> requiredFlags,  Set<String> excludedFlags,  double? maxCash,  MarketCondition? minMarketDrawdown,  MarketCondition? minMarketTrailingRatio)  $default,) {final _that = this;
switch (_that) {
case _EventTrigger():
return $default(_that.minAgeInMonths,_that.maxAgeInMonths,_that.minStress,_that.maxStress,_that.targetCalendarMonths,_that.requiredFlags,_that.excludedFlags,_that.maxCash,_that.minMarketDrawdown,_that.minMarketTrailingRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? minAgeInMonths,  int? maxAgeInMonths,  int? minStress,  int? maxStress,  List<int> targetCalendarMonths,  Set<String> requiredFlags,  Set<String> excludedFlags,  double? maxCash,  MarketCondition? minMarketDrawdown,  MarketCondition? minMarketTrailingRatio)?  $default,) {final _that = this;
switch (_that) {
case _EventTrigger() when $default != null:
return $default(_that.minAgeInMonths,_that.maxAgeInMonths,_that.minStress,_that.maxStress,_that.targetCalendarMonths,_that.requiredFlags,_that.excludedFlags,_that.maxCash,_that.minMarketDrawdown,_that.minMarketTrailingRatio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventTrigger implements EventTrigger {
  const _EventTrigger({this.minAgeInMonths, this.maxAgeInMonths, this.minStress, this.maxStress, final  List<int> targetCalendarMonths = const [], final  Set<String> requiredFlags = const {}, final  Set<String> excludedFlags = const {}, this.maxCash, this.minMarketDrawdown, this.minMarketTrailingRatio}): _targetCalendarMonths = targetCalendarMonths,_requiredFlags = requiredFlags,_excludedFlags = excludedFlags;
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

// 6.2b: shock & market-aware triggers
@override final  double? maxCash;
// fires while state.cash < maxCash (e.g. 0 = broke)
@override final  MarketCondition? minMarketDrawdown;
// class drawdown >= value
@override final  MarketCondition? minMarketTrailingRatio;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTrigger&&(identical(other.minAgeInMonths, minAgeInMonths) || other.minAgeInMonths == minAgeInMonths)&&(identical(other.maxAgeInMonths, maxAgeInMonths) || other.maxAgeInMonths == maxAgeInMonths)&&(identical(other.minStress, minStress) || other.minStress == minStress)&&(identical(other.maxStress, maxStress) || other.maxStress == maxStress)&&const DeepCollectionEquality().equals(other._targetCalendarMonths, _targetCalendarMonths)&&const DeepCollectionEquality().equals(other._requiredFlags, _requiredFlags)&&const DeepCollectionEquality().equals(other._excludedFlags, _excludedFlags)&&(identical(other.maxCash, maxCash) || other.maxCash == maxCash)&&(identical(other.minMarketDrawdown, minMarketDrawdown) || other.minMarketDrawdown == minMarketDrawdown)&&(identical(other.minMarketTrailingRatio, minMarketTrailingRatio) || other.minMarketTrailingRatio == minMarketTrailingRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minAgeInMonths,maxAgeInMonths,minStress,maxStress,const DeepCollectionEquality().hash(_targetCalendarMonths),const DeepCollectionEquality().hash(_requiredFlags),const DeepCollectionEquality().hash(_excludedFlags),maxCash,minMarketDrawdown,minMarketTrailingRatio);

@override
String toString() {
  return 'EventTrigger(minAgeInMonths: $minAgeInMonths, maxAgeInMonths: $maxAgeInMonths, minStress: $minStress, maxStress: $maxStress, targetCalendarMonths: $targetCalendarMonths, requiredFlags: $requiredFlags, excludedFlags: $excludedFlags, maxCash: $maxCash, minMarketDrawdown: $minMarketDrawdown, minMarketTrailingRatio: $minMarketTrailingRatio)';
}


}

/// @nodoc
abstract mixin class _$EventTriggerCopyWith<$Res> implements $EventTriggerCopyWith<$Res> {
  factory _$EventTriggerCopyWith(_EventTrigger value, $Res Function(_EventTrigger) _then) = __$EventTriggerCopyWithImpl;
@override @useResult
$Res call({
 int? minAgeInMonths, int? maxAgeInMonths, int? minStress, int? maxStress, List<int> targetCalendarMonths, Set<String> requiredFlags, Set<String> excludedFlags, double? maxCash, MarketCondition? minMarketDrawdown, MarketCondition? minMarketTrailingRatio
});


@override $MarketConditionCopyWith<$Res>? get minMarketDrawdown;@override $MarketConditionCopyWith<$Res>? get minMarketTrailingRatio;

}
/// @nodoc
class __$EventTriggerCopyWithImpl<$Res>
    implements _$EventTriggerCopyWith<$Res> {
  __$EventTriggerCopyWithImpl(this._self, this._then);

  final _EventTrigger _self;
  final $Res Function(_EventTrigger) _then;

/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minAgeInMonths = freezed,Object? maxAgeInMonths = freezed,Object? minStress = freezed,Object? maxStress = freezed,Object? targetCalendarMonths = null,Object? requiredFlags = null,Object? excludedFlags = null,Object? maxCash = freezed,Object? minMarketDrawdown = freezed,Object? minMarketTrailingRatio = freezed,}) {
  return _then(_EventTrigger(
minAgeInMonths: freezed == minAgeInMonths ? _self.minAgeInMonths : minAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,maxAgeInMonths: freezed == maxAgeInMonths ? _self.maxAgeInMonths : maxAgeInMonths // ignore: cast_nullable_to_non_nullable
as int?,minStress: freezed == minStress ? _self.minStress : minStress // ignore: cast_nullable_to_non_nullable
as int?,maxStress: freezed == maxStress ? _self.maxStress : maxStress // ignore: cast_nullable_to_non_nullable
as int?,targetCalendarMonths: null == targetCalendarMonths ? _self._targetCalendarMonths : targetCalendarMonths // ignore: cast_nullable_to_non_nullable
as List<int>,requiredFlags: null == requiredFlags ? _self._requiredFlags : requiredFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,excludedFlags: null == excludedFlags ? _self._excludedFlags : excludedFlags // ignore: cast_nullable_to_non_nullable
as Set<String>,maxCash: freezed == maxCash ? _self.maxCash : maxCash // ignore: cast_nullable_to_non_nullable
as double?,minMarketDrawdown: freezed == minMarketDrawdown ? _self.minMarketDrawdown : minMarketDrawdown // ignore: cast_nullable_to_non_nullable
as MarketCondition?,minMarketTrailingRatio: freezed == minMarketTrailingRatio ? _self.minMarketTrailingRatio : minMarketTrailingRatio // ignore: cast_nullable_to_non_nullable
as MarketCondition?,
  ));
}

/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketConditionCopyWith<$Res>? get minMarketDrawdown {
    if (_self.minMarketDrawdown == null) {
    return null;
  }

  return $MarketConditionCopyWith<$Res>(_self.minMarketDrawdown!, (value) {
    return _then(_self.copyWith(minMarketDrawdown: value));
  });
}/// Create a copy of EventTrigger
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketConditionCopyWith<$Res>? get minMarketTrailingRatio {
    if (_self.minMarketTrailingRatio == null) {
    return null;
  }

  return $MarketConditionCopyWith<$Res>(_self.minMarketTrailingRatio!, (value) {
    return _then(_self.copyWith(minMarketTrailingRatio: value));
  });
}
}

// dart format on
