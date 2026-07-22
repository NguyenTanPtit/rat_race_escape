// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_class_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketClassState {

 MarketClassConfig get config; double get price; double get peakPrice; double get trendPrice;// deterministic anchor, grows by monthlyDrift
 MarketRegime get regime; int get regimeMonthsLeft; List<double> get recentPrices;
/// Create a copy of MarketClassState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketClassStateCopyWith<MarketClassState> get copyWith => _$MarketClassStateCopyWithImpl<MarketClassState>(this as MarketClassState, _$identity);

  /// Serializes this MarketClassState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketClassState&&(identical(other.config, config) || other.config == config)&&(identical(other.price, price) || other.price == price)&&(identical(other.peakPrice, peakPrice) || other.peakPrice == peakPrice)&&(identical(other.trendPrice, trendPrice) || other.trendPrice == trendPrice)&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.regimeMonthsLeft, regimeMonthsLeft) || other.regimeMonthsLeft == regimeMonthsLeft)&&const DeepCollectionEquality().equals(other.recentPrices, recentPrices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,config,price,peakPrice,trendPrice,regime,regimeMonthsLeft,const DeepCollectionEquality().hash(recentPrices));

@override
String toString() {
  return 'MarketClassState(config: $config, price: $price, peakPrice: $peakPrice, trendPrice: $trendPrice, regime: $regime, regimeMonthsLeft: $regimeMonthsLeft, recentPrices: $recentPrices)';
}


}

/// @nodoc
abstract mixin class $MarketClassStateCopyWith<$Res>  {
  factory $MarketClassStateCopyWith(MarketClassState value, $Res Function(MarketClassState) _then) = _$MarketClassStateCopyWithImpl;
@useResult
$Res call({
 MarketClassConfig config, double price, double peakPrice, double trendPrice, MarketRegime regime, int regimeMonthsLeft, List<double> recentPrices
});


$MarketClassConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$MarketClassStateCopyWithImpl<$Res>
    implements $MarketClassStateCopyWith<$Res> {
  _$MarketClassStateCopyWithImpl(this._self, this._then);

  final MarketClassState _self;
  final $Res Function(MarketClassState) _then;

/// Create a copy of MarketClassState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? config = null,Object? price = null,Object? peakPrice = null,Object? trendPrice = null,Object? regime = null,Object? regimeMonthsLeft = null,Object? recentPrices = null,}) {
  return _then(_self.copyWith(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as MarketClassConfig,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,peakPrice: null == peakPrice ? _self.peakPrice : peakPrice // ignore: cast_nullable_to_non_nullable
as double,trendPrice: null == trendPrice ? _self.trendPrice : trendPrice // ignore: cast_nullable_to_non_nullable
as double,regime: null == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as MarketRegime,regimeMonthsLeft: null == regimeMonthsLeft ? _self.regimeMonthsLeft : regimeMonthsLeft // ignore: cast_nullable_to_non_nullable
as int,recentPrices: null == recentPrices ? _self.recentPrices : recentPrices // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}
/// Create a copy of MarketClassState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketClassConfigCopyWith<$Res> get config {
  
  return $MarketClassConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [MarketClassState].
extension MarketClassStatePatterns on MarketClassState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketClassState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketClassState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketClassState value)  $default,){
final _that = this;
switch (_that) {
case _MarketClassState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketClassState value)?  $default,){
final _that = this;
switch (_that) {
case _MarketClassState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MarketClassConfig config,  double price,  double peakPrice,  double trendPrice,  MarketRegime regime,  int regimeMonthsLeft,  List<double> recentPrices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketClassState() when $default != null:
return $default(_that.config,_that.price,_that.peakPrice,_that.trendPrice,_that.regime,_that.regimeMonthsLeft,_that.recentPrices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MarketClassConfig config,  double price,  double peakPrice,  double trendPrice,  MarketRegime regime,  int regimeMonthsLeft,  List<double> recentPrices)  $default,) {final _that = this;
switch (_that) {
case _MarketClassState():
return $default(_that.config,_that.price,_that.peakPrice,_that.trendPrice,_that.regime,_that.regimeMonthsLeft,_that.recentPrices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MarketClassConfig config,  double price,  double peakPrice,  double trendPrice,  MarketRegime regime,  int regimeMonthsLeft,  List<double> recentPrices)?  $default,) {final _that = this;
switch (_that) {
case _MarketClassState() when $default != null:
return $default(_that.config,_that.price,_that.peakPrice,_that.trendPrice,_that.regime,_that.regimeMonthsLeft,_that.recentPrices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketClassState extends MarketClassState {
  const _MarketClassState({required this.config, this.price = 1.0, this.peakPrice = 1.0, this.trendPrice = 1.0, this.regime = MarketRegime.normal, this.regimeMonthsLeft = 0, final  List<double> recentPrices = const []}): _recentPrices = recentPrices,super._();
  factory _MarketClassState.fromJson(Map<String, dynamic> json) => _$MarketClassStateFromJson(json);

@override final  MarketClassConfig config;
@override@JsonKey() final  double price;
@override@JsonKey() final  double peakPrice;
@override@JsonKey() final  double trendPrice;
// deterministic anchor, grows by monthlyDrift
@override@JsonKey() final  MarketRegime regime;
@override@JsonKey() final  int regimeMonthsLeft;
 final  List<double> _recentPrices;
@override@JsonKey() List<double> get recentPrices {
  if (_recentPrices is EqualUnmodifiableListView) return _recentPrices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentPrices);
}


/// Create a copy of MarketClassState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketClassStateCopyWith<_MarketClassState> get copyWith => __$MarketClassStateCopyWithImpl<_MarketClassState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketClassStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketClassState&&(identical(other.config, config) || other.config == config)&&(identical(other.price, price) || other.price == price)&&(identical(other.peakPrice, peakPrice) || other.peakPrice == peakPrice)&&(identical(other.trendPrice, trendPrice) || other.trendPrice == trendPrice)&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.regimeMonthsLeft, regimeMonthsLeft) || other.regimeMonthsLeft == regimeMonthsLeft)&&const DeepCollectionEquality().equals(other._recentPrices, _recentPrices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,config,price,peakPrice,trendPrice,regime,regimeMonthsLeft,const DeepCollectionEquality().hash(_recentPrices));

@override
String toString() {
  return 'MarketClassState(config: $config, price: $price, peakPrice: $peakPrice, trendPrice: $trendPrice, regime: $regime, regimeMonthsLeft: $regimeMonthsLeft, recentPrices: $recentPrices)';
}


}

/// @nodoc
abstract mixin class _$MarketClassStateCopyWith<$Res> implements $MarketClassStateCopyWith<$Res> {
  factory _$MarketClassStateCopyWith(_MarketClassState value, $Res Function(_MarketClassState) _then) = __$MarketClassStateCopyWithImpl;
@override @useResult
$Res call({
 MarketClassConfig config, double price, double peakPrice, double trendPrice, MarketRegime regime, int regimeMonthsLeft, List<double> recentPrices
});


@override $MarketClassConfigCopyWith<$Res> get config;

}
/// @nodoc
class __$MarketClassStateCopyWithImpl<$Res>
    implements _$MarketClassStateCopyWith<$Res> {
  __$MarketClassStateCopyWithImpl(this._self, this._then);

  final _MarketClassState _self;
  final $Res Function(_MarketClassState) _then;

/// Create a copy of MarketClassState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? config = null,Object? price = null,Object? peakPrice = null,Object? trendPrice = null,Object? regime = null,Object? regimeMonthsLeft = null,Object? recentPrices = null,}) {
  return _then(_MarketClassState(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as MarketClassConfig,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,peakPrice: null == peakPrice ? _self.peakPrice : peakPrice // ignore: cast_nullable_to_non_nullable
as double,trendPrice: null == trendPrice ? _self.trendPrice : trendPrice // ignore: cast_nullable_to_non_nullable
as double,regime: null == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as MarketRegime,regimeMonthsLeft: null == regimeMonthsLeft ? _self.regimeMonthsLeft : regimeMonthsLeft // ignore: cast_nullable_to_non_nullable
as int,recentPrices: null == recentPrices ? _self._recentPrices : recentPrices // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

/// Create a copy of MarketClassState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketClassConfigCopyWith<$Res> get config {
  
  return $MarketClassConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
