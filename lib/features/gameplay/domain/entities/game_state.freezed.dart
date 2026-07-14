// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
// 0. Bối cảnh Quốc gia & Tiền tệ
  Country get country => throw _privateConstructorUsedError;
  Currency get currency => throw _privateConstructorUsedError; // 1. Time
  int get currentMonth => throw _privateConstructorUsedError;
  int get ageInMonths =>
      throw _privateConstructorUsedError; // Mặc định chung là 22 tuổi
// 2. Financials (Bắt buộc phải khởi tạo tùy bối cảnh)
  double get cash => throw _privateConstructorUsedError;
  double get passiveIncome => throw _privateConstructorUsedError;
  double get monthlyExpenses => throw _privateConstructorUsedError;
  double get baseSalary => throw _privateConstructorUsedError; // 3. Metrics
  int get stress => throw _privateConstructorUsedError;
  int get networkScore => throw _privateConstructorUsedError;
  int get creditScore => throw _privateConstructorUsedError; // 4. Visual States
  HousingLevel get housingLevel => throw _privateConstructorUsedError;
  List<String> get ownedItems =>
      throw _privateConstructorUsedError; // 5. Active Event
  String? get currentEventId =>
      throw _privateConstructorUsedError; // 6. Inventories
  List<Asset> get assets => throw _privateConstructorUsedError;
  List<Loan> get loans => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {Country country,
      Currency currency,
      int currentMonth,
      int ageInMonths,
      double cash,
      double passiveIncome,
      double monthlyExpenses,
      double baseSalary,
      int stress,
      int networkScore,
      int creditScore,
      HousingLevel housingLevel,
      List<String> ownedItems,
      String? currentEventId,
      List<Asset> assets,
      List<Loan> loans});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? currency = null,
    Object? currentMonth = null,
    Object? ageInMonths = null,
    Object? cash = null,
    Object? passiveIncome = null,
    Object? monthlyExpenses = null,
    Object? baseSalary = null,
    Object? stress = null,
    Object? networkScore = null,
    Object? creditScore = null,
    Object? housingLevel = null,
    Object? ownedItems = null,
    Object? currentEventId = freezed,
    Object? assets = null,
    Object? loans = null,
  }) {
    return _then(_value.copyWith(
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency,
      currentMonth: null == currentMonth
          ? _value.currentMonth
          : currentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      ageInMonths: null == ageInMonths
          ? _value.ageInMonths
          : ageInMonths // ignore: cast_nullable_to_non_nullable
              as int,
      cash: null == cash
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as double,
      passiveIncome: null == passiveIncome
          ? _value.passiveIncome
          : passiveIncome // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyExpenses: null == monthlyExpenses
          ? _value.monthlyExpenses
          : monthlyExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      baseSalary: null == baseSalary
          ? _value.baseSalary
          : baseSalary // ignore: cast_nullable_to_non_nullable
              as double,
      stress: null == stress
          ? _value.stress
          : stress // ignore: cast_nullable_to_non_nullable
              as int,
      networkScore: null == networkScore
          ? _value.networkScore
          : networkScore // ignore: cast_nullable_to_non_nullable
              as int,
      creditScore: null == creditScore
          ? _value.creditScore
          : creditScore // ignore: cast_nullable_to_non_nullable
              as int,
      housingLevel: null == housingLevel
          ? _value.housingLevel
          : housingLevel // ignore: cast_nullable_to_non_nullable
              as HousingLevel,
      ownedItems: null == ownedItems
          ? _value.ownedItems
          : ownedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentEventId: freezed == currentEventId
          ? _value.currentEventId
          : currentEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      assets: null == assets
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
      loans: null == loans
          ? _value.loans
          : loans // ignore: cast_nullable_to_non_nullable
              as List<Loan>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Country country,
      Currency currency,
      int currentMonth,
      int ageInMonths,
      double cash,
      double passiveIncome,
      double monthlyExpenses,
      double baseSalary,
      int stress,
      int networkScore,
      int creditScore,
      HousingLevel housingLevel,
      List<String> ownedItems,
      String? currentEventId,
      List<Asset> assets,
      List<Loan> loans});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? currency = null,
    Object? currentMonth = null,
    Object? ageInMonths = null,
    Object? cash = null,
    Object? passiveIncome = null,
    Object? monthlyExpenses = null,
    Object? baseSalary = null,
    Object? stress = null,
    Object? networkScore = null,
    Object? creditScore = null,
    Object? housingLevel = null,
    Object? ownedItems = null,
    Object? currentEventId = freezed,
    Object? assets = null,
    Object? loans = null,
  }) {
    return _then(_$GameStateImpl(
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency,
      currentMonth: null == currentMonth
          ? _value.currentMonth
          : currentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      ageInMonths: null == ageInMonths
          ? _value.ageInMonths
          : ageInMonths // ignore: cast_nullable_to_non_nullable
              as int,
      cash: null == cash
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as double,
      passiveIncome: null == passiveIncome
          ? _value.passiveIncome
          : passiveIncome // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyExpenses: null == monthlyExpenses
          ? _value.monthlyExpenses
          : monthlyExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      baseSalary: null == baseSalary
          ? _value.baseSalary
          : baseSalary // ignore: cast_nullable_to_non_nullable
              as double,
      stress: null == stress
          ? _value.stress
          : stress // ignore: cast_nullable_to_non_nullable
              as int,
      networkScore: null == networkScore
          ? _value.networkScore
          : networkScore // ignore: cast_nullable_to_non_nullable
              as int,
      creditScore: null == creditScore
          ? _value.creditScore
          : creditScore // ignore: cast_nullable_to_non_nullable
              as int,
      housingLevel: null == housingLevel
          ? _value.housingLevel
          : housingLevel // ignore: cast_nullable_to_non_nullable
              as HousingLevel,
      ownedItems: null == ownedItems
          ? _value._ownedItems
          : ownedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentEventId: freezed == currentEventId
          ? _value.currentEventId
          : currentEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      assets: null == assets
          ? _value._assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
      loans: null == loans
          ? _value._loans
          : loans // ignore: cast_nullable_to_non_nullable
              as List<Loan>,
    ));
  }
}

/// @nodoc

class _$GameStateImpl extends _GameState {
  const _$GameStateImpl(
      {required this.country,
      required this.currency,
      this.currentMonth = 1,
      this.ageInMonths = 264,
      required this.cash,
      this.passiveIncome = 0.0,
      required this.monthlyExpenses,
      required this.baseSalary,
      this.stress = 0,
      this.networkScore = 0,
      this.creditScore = 600,
      this.housingLevel = HousingLevel.shabbyRoom,
      final List<String> ownedItems = const [],
      this.currentEventId,
      final List<Asset> assets = const [],
      final List<Loan> loans = const []})
      : _ownedItems = ownedItems,
        _assets = assets,
        _loans = loans,
        super._();

// 0. Bối cảnh Quốc gia & Tiền tệ
  @override
  final Country country;
  @override
  final Currency currency;
// 1. Time
  @override
  @JsonKey()
  final int currentMonth;
  @override
  @JsonKey()
  final int ageInMonths;
// Mặc định chung là 22 tuổi
// 2. Financials (Bắt buộc phải khởi tạo tùy bối cảnh)
  @override
  final double cash;
  @override
  @JsonKey()
  final double passiveIncome;
  @override
  final double monthlyExpenses;
  @override
  final double baseSalary;
// 3. Metrics
  @override
  @JsonKey()
  final int stress;
  @override
  @JsonKey()
  final int networkScore;
  @override
  @JsonKey()
  final int creditScore;
// 4. Visual States
  @override
  @JsonKey()
  final HousingLevel housingLevel;
  final List<String> _ownedItems;
  @override
  @JsonKey()
  List<String> get ownedItems {
    if (_ownedItems is EqualUnmodifiableListView) return _ownedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ownedItems);
  }

// 5. Active Event
  @override
  final String? currentEventId;
// 6. Inventories
  final List<Asset> _assets;
// 6. Inventories
  @override
  @JsonKey()
  List<Asset> get assets {
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assets);
  }

  final List<Loan> _loans;
  @override
  @JsonKey()
  List<Loan> get loans {
    if (_loans is EqualUnmodifiableListView) return _loans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loans);
  }

  @override
  String toString() {
    return 'GameState(country: $country, currency: $currency, currentMonth: $currentMonth, ageInMonths: $ageInMonths, cash: $cash, passiveIncome: $passiveIncome, monthlyExpenses: $monthlyExpenses, baseSalary: $baseSalary, stress: $stress, networkScore: $networkScore, creditScore: $creditScore, housingLevel: $housingLevel, ownedItems: $ownedItems, currentEventId: $currentEventId, assets: $assets, loans: $loans)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.currentMonth, currentMonth) ||
                other.currentMonth == currentMonth) &&
            (identical(other.ageInMonths, ageInMonths) ||
                other.ageInMonths == ageInMonths) &&
            (identical(other.cash, cash) || other.cash == cash) &&
            (identical(other.passiveIncome, passiveIncome) ||
                other.passiveIncome == passiveIncome) &&
            (identical(other.monthlyExpenses, monthlyExpenses) ||
                other.monthlyExpenses == monthlyExpenses) &&
            (identical(other.baseSalary, baseSalary) ||
                other.baseSalary == baseSalary) &&
            (identical(other.stress, stress) || other.stress == stress) &&
            (identical(other.networkScore, networkScore) ||
                other.networkScore == networkScore) &&
            (identical(other.creditScore, creditScore) ||
                other.creditScore == creditScore) &&
            (identical(other.housingLevel, housingLevel) ||
                other.housingLevel == housingLevel) &&
            const DeepCollectionEquality()
                .equals(other._ownedItems, _ownedItems) &&
            (identical(other.currentEventId, currentEventId) ||
                other.currentEventId == currentEventId) &&
            const DeepCollectionEquality().equals(other._assets, _assets) &&
            const DeepCollectionEquality().equals(other._loans, _loans));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      country,
      currency,
      currentMonth,
      ageInMonths,
      cash,
      passiveIncome,
      monthlyExpenses,
      baseSalary,
      stress,
      networkScore,
      creditScore,
      housingLevel,
      const DeepCollectionEquality().hash(_ownedItems),
      currentEventId,
      const DeepCollectionEquality().hash(_assets),
      const DeepCollectionEquality().hash(_loans));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {required final Country country,
      required final Currency currency,
      final int currentMonth,
      final int ageInMonths,
      required final double cash,
      final double passiveIncome,
      required final double monthlyExpenses,
      required final double baseSalary,
      final int stress,
      final int networkScore,
      final int creditScore,
      final HousingLevel housingLevel,
      final List<String> ownedItems,
      final String? currentEventId,
      final List<Asset> assets,
      final List<Loan> loans}) = _$GameStateImpl;
  const _GameState._() : super._();

  @override // 0. Bối cảnh Quốc gia & Tiền tệ
  Country get country;
  @override
  Currency get currency;
  @override // 1. Time
  int get currentMonth;
  @override
  int get ageInMonths;
  @override // Mặc định chung là 22 tuổi
// 2. Financials (Bắt buộc phải khởi tạo tùy bối cảnh)
  double get cash;
  @override
  double get passiveIncome;
  @override
  double get monthlyExpenses;
  @override
  double get baseSalary;
  @override // 3. Metrics
  int get stress;
  @override
  int get networkScore;
  @override
  int get creditScore;
  @override // 4. Visual States
  HousingLevel get housingLevel;
  @override
  List<String> get ownedItems;
  @override // 5. Active Event
  String? get currentEventId;
  @override // 6. Inventories
  List<Asset> get assets;
  @override
  List<Loan> get loans;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
