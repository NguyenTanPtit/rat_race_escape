// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Asset {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get baseValue =>
      throw _privateConstructorUsedError; // Giá trị hiện tại của tài sản
  double get monthlyPassiveIncome =>
      throw _privateConstructorUsedError; // Dòng tiền thụ động sinh ra mỗi tháng
  AssetType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AssetCopyWith<Asset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res, Asset>;
  @useResult
  $Res call(
      {String id,
      String name,
      double baseValue,
      double monthlyPassiveIncome,
      AssetType type});
}

/// @nodoc
class _$AssetCopyWithImpl<$Res, $Val extends Asset>
    implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? baseValue = null,
    Object? monthlyPassiveIncome = null,
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
      baseValue: null == baseValue
          ? _value.baseValue
          : baseValue // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyPassiveIncome: null == monthlyPassiveIncome
          ? _value.monthlyPassiveIncome
          : monthlyPassiveIncome // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AssetType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssetImplCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$$AssetImplCopyWith(
          _$AssetImpl value, $Res Function(_$AssetImpl) then) =
      __$$AssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double baseValue,
      double monthlyPassiveIncome,
      AssetType type});
}

/// @nodoc
class __$$AssetImplCopyWithImpl<$Res>
    extends _$AssetCopyWithImpl<$Res, _$AssetImpl>
    implements _$$AssetImplCopyWith<$Res> {
  __$$AssetImplCopyWithImpl(
      _$AssetImpl _value, $Res Function(_$AssetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? baseValue = null,
    Object? monthlyPassiveIncome = null,
    Object? type = null,
  }) {
    return _then(_$AssetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      baseValue: null == baseValue
          ? _value.baseValue
          : baseValue // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyPassiveIncome: null == monthlyPassiveIncome
          ? _value.monthlyPassiveIncome
          : monthlyPassiveIncome // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AssetType,
    ));
  }
}

/// @nodoc

class _$AssetImpl implements _Asset {
  const _$AssetImpl(
      {required this.id,
      required this.name,
      required this.baseValue,
      this.monthlyPassiveIncome = 0.0,
      this.type = AssetType.stock});

  @override
  final String id;
  @override
  final String name;
  @override
  final double baseValue;
// Giá trị hiện tại của tài sản
  @override
  @JsonKey()
  final double monthlyPassiveIncome;
// Dòng tiền thụ động sinh ra mỗi tháng
  @override
  @JsonKey()
  final AssetType type;

  @override
  String toString() {
    return 'Asset(id: $id, name: $name, baseValue: $baseValue, monthlyPassiveIncome: $monthlyPassiveIncome, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.baseValue, baseValue) ||
                other.baseValue == baseValue) &&
            (identical(other.monthlyPassiveIncome, monthlyPassiveIncome) ||
                other.monthlyPassiveIncome == monthlyPassiveIncome) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, baseValue, monthlyPassiveIncome, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      __$$AssetImplCopyWithImpl<_$AssetImpl>(this, _$identity);
}

abstract class _Asset implements Asset {
  const factory _Asset(
      {required final String id,
      required final String name,
      required final double baseValue,
      final double monthlyPassiveIncome,
      final AssetType type}) = _$AssetImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get baseValue;
  @override // Giá trị hiện tại của tài sản
  double get monthlyPassiveIncome;
  @override // Dòng tiền thụ động sinh ra mỗi tháng
  AssetType get type;
  @override
  @JsonKey(ignore: true)
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
