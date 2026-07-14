// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Loan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get principalAmount =>
      throw _privateConstructorUsedError; // Dư nợ gốc còn lại
  double get interestRatePerYear =>
      throw _privateConstructorUsedError; // Lãi suất % / năm
  double get minimumMonthlyPayment =>
      throw _privateConstructorUsedError; // Số tiền phải trả tối thiểu mỗi tháng
  LoanType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoanCopyWith<Loan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanCopyWith<$Res> {
  factory $LoanCopyWith(Loan value, $Res Function(Loan) then) =
      _$LoanCopyWithImpl<$Res, Loan>;
  @useResult
  $Res call(
      {String id,
      String name,
      double principalAmount,
      double interestRatePerYear,
      double minimumMonthlyPayment,
      LoanType type});
}

/// @nodoc
class _$LoanCopyWithImpl<$Res, $Val extends Loan>
    implements $LoanCopyWith<$Res> {
  _$LoanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? principalAmount = null,
    Object? interestRatePerYear = null,
    Object? minimumMonthlyPayment = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      principalAmount: null == principalAmount
          ? _value.principalAmount
          : principalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      interestRatePerYear: null == interestRatePerYear
          ? _value.interestRatePerYear
          : interestRatePerYear // ignore: cast_nullable_to_non_nullable
              as double,
      minimumMonthlyPayment: null == minimumMonthlyPayment
          ? _value.minimumMonthlyPayment
          : minimumMonthlyPayment // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LoanType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoanImplCopyWith<$Res> implements $LoanCopyWith<$Res> {
  factory _$$LoanImplCopyWith(
          _$LoanImpl value, $Res Function(_$LoanImpl) then) =
      __$$LoanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double principalAmount,
      double interestRatePerYear,
      double minimumMonthlyPayment,
      LoanType type});
}

/// @nodoc
class __$$LoanImplCopyWithImpl<$Res>
    extends _$LoanCopyWithImpl<$Res, _$LoanImpl>
    implements _$$LoanImplCopyWith<$Res> {
  __$$LoanImplCopyWithImpl(_$LoanImpl _value, $Res Function(_$LoanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? principalAmount = null,
    Object? interestRatePerYear = null,
    Object? minimumMonthlyPayment = null,
    Object? type = null,
  }) {
    return _then(_$LoanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      principalAmount: null == principalAmount
          ? _value.principalAmount
          : principalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      interestRatePerYear: null == interestRatePerYear
          ? _value.interestRatePerYear
          : interestRatePerYear // ignore: cast_nullable_to_non_nullable
              as double,
      minimumMonthlyPayment: null == minimumMonthlyPayment
          ? _value.minimumMonthlyPayment
          : minimumMonthlyPayment // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LoanType,
    ));
  }
}

/// @nodoc

class _$LoanImpl implements _Loan {
  const _$LoanImpl(
      {required this.id,
      required this.name,
      required this.principalAmount,
      required this.interestRatePerYear,
      required this.minimumMonthlyPayment,
      this.type = LoanType.creditCard});

  @override
  final String id;
  @override
  final String name;
  @override
  final double principalAmount;
// Dư nợ gốc còn lại
  @override
  final double interestRatePerYear;
// Lãi suất % / năm
  @override
  final double minimumMonthlyPayment;
// Số tiền phải trả tối thiểu mỗi tháng
  @override
  @JsonKey()
  final LoanType type;

  @override
  String toString() {
    return 'Loan(id: $id, name: $name, principalAmount: $principalAmount, interestRatePerYear: $interestRatePerYear, minimumMonthlyPayment: $minimumMonthlyPayment, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.principalAmount, principalAmount) ||
                other.principalAmount == principalAmount) &&
            (identical(other.interestRatePerYear, interestRatePerYear) ||
                other.interestRatePerYear == interestRatePerYear) &&
            (identical(other.minimumMonthlyPayment, minimumMonthlyPayment) ||
                other.minimumMonthlyPayment == minimumMonthlyPayment) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, principalAmount,
      interestRatePerYear, minimumMonthlyPayment, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanImplCopyWith<_$LoanImpl> get copyWith =>
      __$$LoanImplCopyWithImpl<_$LoanImpl>(this, _$identity);
}

abstract class _Loan implements Loan {
  const factory _Loan(
      {required final String id,
      required final String name,
      required final double principalAmount,
      required final double interestRatePerYear,
      required final double minimumMonthlyPayment,
      final LoanType type}) = _$LoanImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get principalAmount;
  @override // Dư nợ gốc còn lại
  double get interestRatePerYear;
  @override // Lãi suất % / năm
  double get minimumMonthlyPayment;
  @override // Số tiền phải trả tối thiểu mỗi tháng
  LoanType get type;
  @override
  @JsonKey(ignore: true)
  _$$LoanImplCopyWith<_$LoanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
