// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Loan {

 String get id; String get name; double get principalAmount;// Dư nợ gốc còn lại
 double get interestRatePerYear;// Lãi suất % / năm
 double get minimumMonthlyPayment;// Số tiền phải trả tối thiểu mỗi tháng
 LoanType get type;
/// Create a copy of Loan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoanCopyWith<Loan> get copyWith => _$LoanCopyWithImpl<Loan>(this as Loan, _$identity);

  /// Serializes this Loan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.principalAmount, principalAmount) || other.principalAmount == principalAmount)&&(identical(other.interestRatePerYear, interestRatePerYear) || other.interestRatePerYear == interestRatePerYear)&&(identical(other.minimumMonthlyPayment, minimumMonthlyPayment) || other.minimumMonthlyPayment == minimumMonthlyPayment)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,principalAmount,interestRatePerYear,minimumMonthlyPayment,type);

@override
String toString() {
  return 'Loan(id: $id, name: $name, principalAmount: $principalAmount, interestRatePerYear: $interestRatePerYear, minimumMonthlyPayment: $minimumMonthlyPayment, type: $type)';
}


}

/// @nodoc
abstract mixin class $LoanCopyWith<$Res>  {
  factory $LoanCopyWith(Loan value, $Res Function(Loan) _then) = _$LoanCopyWithImpl;
@useResult
$Res call({
 String id, String name, double principalAmount, double interestRatePerYear, double minimumMonthlyPayment, LoanType type
});




}
/// @nodoc
class _$LoanCopyWithImpl<$Res>
    implements $LoanCopyWith<$Res> {
  _$LoanCopyWithImpl(this._self, this._then);

  final Loan _self;
  final $Res Function(Loan) _then;

/// Create a copy of Loan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? principalAmount = null,Object? interestRatePerYear = null,Object? minimumMonthlyPayment = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,principalAmount: null == principalAmount ? _self.principalAmount : principalAmount // ignore: cast_nullable_to_non_nullable
as double,interestRatePerYear: null == interestRatePerYear ? _self.interestRatePerYear : interestRatePerYear // ignore: cast_nullable_to_non_nullable
as double,minimumMonthlyPayment: null == minimumMonthlyPayment ? _self.minimumMonthlyPayment : minimumMonthlyPayment // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LoanType,
  ));
}

}


/// Adds pattern-matching-related methods to [Loan].
extension LoanPatterns on Loan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Loan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Loan value)  $default,){
final _that = this;
switch (_that) {
case _Loan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Loan value)?  $default,){
final _that = this;
switch (_that) {
case _Loan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double principalAmount,  double interestRatePerYear,  double minimumMonthlyPayment,  LoanType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loan() when $default != null:
return $default(_that.id,_that.name,_that.principalAmount,_that.interestRatePerYear,_that.minimumMonthlyPayment,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double principalAmount,  double interestRatePerYear,  double minimumMonthlyPayment,  LoanType type)  $default,) {final _that = this;
switch (_that) {
case _Loan():
return $default(_that.id,_that.name,_that.principalAmount,_that.interestRatePerYear,_that.minimumMonthlyPayment,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double principalAmount,  double interestRatePerYear,  double minimumMonthlyPayment,  LoanType type)?  $default,) {final _that = this;
switch (_that) {
case _Loan() when $default != null:
return $default(_that.id,_that.name,_that.principalAmount,_that.interestRatePerYear,_that.minimumMonthlyPayment,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Loan implements Loan {
  const _Loan({required this.id, required this.name, required this.principalAmount, required this.interestRatePerYear, required this.minimumMonthlyPayment, this.type = LoanType.creditCard}): assert(interestRatePerYear >= 0 && interestRatePerYear < 100, 'Interest rate must be a percentage between 0 and 100');
  factory _Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

@override final  String id;
@override final  String name;
@override final  double principalAmount;
// Dư nợ gốc còn lại
@override final  double interestRatePerYear;
// Lãi suất % / năm
@override final  double minimumMonthlyPayment;
// Số tiền phải trả tối thiểu mỗi tháng
@override@JsonKey() final  LoanType type;

/// Create a copy of Loan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoanCopyWith<_Loan> get copyWith => __$LoanCopyWithImpl<_Loan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.principalAmount, principalAmount) || other.principalAmount == principalAmount)&&(identical(other.interestRatePerYear, interestRatePerYear) || other.interestRatePerYear == interestRatePerYear)&&(identical(other.minimumMonthlyPayment, minimumMonthlyPayment) || other.minimumMonthlyPayment == minimumMonthlyPayment)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,principalAmount,interestRatePerYear,minimumMonthlyPayment,type);

@override
String toString() {
  return 'Loan(id: $id, name: $name, principalAmount: $principalAmount, interestRatePerYear: $interestRatePerYear, minimumMonthlyPayment: $minimumMonthlyPayment, type: $type)';
}


}

/// @nodoc
abstract mixin class _$LoanCopyWith<$Res> implements $LoanCopyWith<$Res> {
  factory _$LoanCopyWith(_Loan value, $Res Function(_Loan) _then) = __$LoanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double principalAmount, double interestRatePerYear, double minimumMonthlyPayment, LoanType type
});




}
/// @nodoc
class __$LoanCopyWithImpl<$Res>
    implements _$LoanCopyWith<$Res> {
  __$LoanCopyWithImpl(this._self, this._then);

  final _Loan _self;
  final $Res Function(_Loan) _then;

/// Create a copy of Loan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? principalAmount = null,Object? interestRatePerYear = null,Object? minimumMonthlyPayment = null,Object? type = null,}) {
  return _then(_Loan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,principalAmount: null == principalAmount ? _self.principalAmount : principalAmount // ignore: cast_nullable_to_non_nullable
as double,interestRatePerYear: null == interestRatePerYear ? _self.interestRatePerYear : interestRatePerYear // ignore: cast_nullable_to_non_nullable
as double,minimumMonthlyPayment: null == minimumMonthlyPayment ? _self.minimumMonthlyPayment : minimumMonthlyPayment // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LoanType,
  ));
}


}

// dart format on
