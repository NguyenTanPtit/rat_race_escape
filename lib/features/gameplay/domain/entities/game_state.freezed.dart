// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameState {

// 0. Country & Currency Context
 Country get country; Currency get currency; String get scenarioId;// 1. Time
 int get currentMonth; int get ageInMonths;// Default is 22 years old
 int get startCalendarMonth;// Starting month of the year (1-12)
// 2. Financials (Must be initialized depending on context)
 double get cash; double get monthlyExpenses; double get monthlyRent; double get baseSalary;// 3. Metrics
 int get stress; int get networkScore; int get creditScore;// 4. Visual States
 HousingLevel get housingLevel; List<String> get ownedItems;// 5. Active Event & Flags
 String? get currentEventId;// Slice 5a: month each event id last fired (drives cooldownMonths in
// GenerateEvent). Per-run state, so it lives here — not session-only.
 Map<String, int> get eventLastFired; Set<String> get flags; Set<String> get unlockedInsightCardIds; double get familySupportExpense; double get baseEventChance; int get bankruptcyMonthsThreshold; double get leisureCostPerStressPoint; int get maxLeisureStressReliefPerMonth; int get leisureReliefUsedThisMonth; int get consecutiveMinimumCreditCardPayments; int get sideJobsWorkedThisMonth; double get sideJobIncome; int get sideJobStress; int get maxSideJobsPerMonth; double get assetSellFeeRate; int get salarySuspendedMonths;// job loss: months left without salary
 bool get hasHealthInsurance; double get healthInsurancePremiumMonthly;// 0 = not offered in scenario
// Inflation (applied every Tet). Cash is deliberately NOT indexed —
// money sitting still is money dying.
 double get inflationAnnualRate; double get salaryGrowthAnnualRate; double get inflationIndex;// Bank (Slice 3a). Savings compound monthly and are NOT indexed by
// inflation either — the interest is the compensation (real ~+1%/yr).
 double get savingsBalance; double get savingsAnnualRate;// decimal, e.g. 0.045; 0 = no bank
 double get bankLoanAnnualRate;// % per year (Loan convention); 0 = no lending
 int get bankLoanMinCredit; double get bankLoanMaxLtv;// bank debt cap vs portfolio market value
// Self-upgrade courses (Slice 3b). Course price at purchase time is
// baseCost × inflationIndex — studying early is cheaper. One course at a
// time, each course only once, salary boost is permanent on graduation.
 List<CourseConfig> get courses;// scenario config; empty = not offered
 Set<String> get completedCourseIds; String? get studyingCourseId; int get studyingMonthsLeft;// 6. Inventories
 List<Asset> get assets; List<Loan> get loans;// 7. Market (per asset class; empty for pre-market saves)
 Map<String, MarketClassState> get market;// Sale proceeds still settling (liquidity delay); cash arrives when due.
 List<PendingProceed> get pendingProceeds;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&(identical(other.country, country) || other.country == country)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.scenarioId, scenarioId) || other.scenarioId == scenarioId)&&(identical(other.currentMonth, currentMonth) || other.currentMonth == currentMonth)&&(identical(other.ageInMonths, ageInMonths) || other.ageInMonths == ageInMonths)&&(identical(other.startCalendarMonth, startCalendarMonth) || other.startCalendarMonth == startCalendarMonth)&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.networkScore, networkScore) || other.networkScore == networkScore)&&(identical(other.creditScore, creditScore) || other.creditScore == creditScore)&&(identical(other.housingLevel, housingLevel) || other.housingLevel == housingLevel)&&const DeepCollectionEquality().equals(other.ownedItems, ownedItems)&&(identical(other.currentEventId, currentEventId) || other.currentEventId == currentEventId)&&const DeepCollectionEquality().equals(other.eventLastFired, eventLastFired)&&const DeepCollectionEquality().equals(other.flags, flags)&&const DeepCollectionEquality().equals(other.unlockedInsightCardIds, unlockedInsightCardIds)&&(identical(other.familySupportExpense, familySupportExpense) || other.familySupportExpense == familySupportExpense)&&(identical(other.baseEventChance, baseEventChance) || other.baseEventChance == baseEventChance)&&(identical(other.bankruptcyMonthsThreshold, bankruptcyMonthsThreshold) || other.bankruptcyMonthsThreshold == bankruptcyMonthsThreshold)&&(identical(other.leisureCostPerStressPoint, leisureCostPerStressPoint) || other.leisureCostPerStressPoint == leisureCostPerStressPoint)&&(identical(other.maxLeisureStressReliefPerMonth, maxLeisureStressReliefPerMonth) || other.maxLeisureStressReliefPerMonth == maxLeisureStressReliefPerMonth)&&(identical(other.leisureReliefUsedThisMonth, leisureReliefUsedThisMonth) || other.leisureReliefUsedThisMonth == leisureReliefUsedThisMonth)&&(identical(other.consecutiveMinimumCreditCardPayments, consecutiveMinimumCreditCardPayments) || other.consecutiveMinimumCreditCardPayments == consecutiveMinimumCreditCardPayments)&&(identical(other.sideJobsWorkedThisMonth, sideJobsWorkedThisMonth) || other.sideJobsWorkedThisMonth == sideJobsWorkedThisMonth)&&(identical(other.sideJobIncome, sideJobIncome) || other.sideJobIncome == sideJobIncome)&&(identical(other.sideJobStress, sideJobStress) || other.sideJobStress == sideJobStress)&&(identical(other.maxSideJobsPerMonth, maxSideJobsPerMonth) || other.maxSideJobsPerMonth == maxSideJobsPerMonth)&&(identical(other.assetSellFeeRate, assetSellFeeRate) || other.assetSellFeeRate == assetSellFeeRate)&&(identical(other.salarySuspendedMonths, salarySuspendedMonths) || other.salarySuspendedMonths == salarySuspendedMonths)&&(identical(other.hasHealthInsurance, hasHealthInsurance) || other.hasHealthInsurance == hasHealthInsurance)&&(identical(other.healthInsurancePremiumMonthly, healthInsurancePremiumMonthly) || other.healthInsurancePremiumMonthly == healthInsurancePremiumMonthly)&&(identical(other.inflationAnnualRate, inflationAnnualRate) || other.inflationAnnualRate == inflationAnnualRate)&&(identical(other.salaryGrowthAnnualRate, salaryGrowthAnnualRate) || other.salaryGrowthAnnualRate == salaryGrowthAnnualRate)&&(identical(other.inflationIndex, inflationIndex) || other.inflationIndex == inflationIndex)&&(identical(other.savingsBalance, savingsBalance) || other.savingsBalance == savingsBalance)&&(identical(other.savingsAnnualRate, savingsAnnualRate) || other.savingsAnnualRate == savingsAnnualRate)&&(identical(other.bankLoanAnnualRate, bankLoanAnnualRate) || other.bankLoanAnnualRate == bankLoanAnnualRate)&&(identical(other.bankLoanMinCredit, bankLoanMinCredit) || other.bankLoanMinCredit == bankLoanMinCredit)&&(identical(other.bankLoanMaxLtv, bankLoanMaxLtv) || other.bankLoanMaxLtv == bankLoanMaxLtv)&&const DeepCollectionEquality().equals(other.courses, courses)&&const DeepCollectionEquality().equals(other.completedCourseIds, completedCourseIds)&&(identical(other.studyingCourseId, studyingCourseId) || other.studyingCourseId == studyingCourseId)&&(identical(other.studyingMonthsLeft, studyingMonthsLeft) || other.studyingMonthsLeft == studyingMonthsLeft)&&const DeepCollectionEquality().equals(other.assets, assets)&&const DeepCollectionEquality().equals(other.loans, loans)&&const DeepCollectionEquality().equals(other.market, market)&&const DeepCollectionEquality().equals(other.pendingProceeds, pendingProceeds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,country,currency,scenarioId,currentMonth,ageInMonths,startCalendarMonth,cash,monthlyExpenses,monthlyRent,baseSalary,stress,networkScore,creditScore,housingLevel,const DeepCollectionEquality().hash(ownedItems),currentEventId,const DeepCollectionEquality().hash(eventLastFired),const DeepCollectionEquality().hash(flags),const DeepCollectionEquality().hash(unlockedInsightCardIds),familySupportExpense,baseEventChance,bankruptcyMonthsThreshold,leisureCostPerStressPoint,maxLeisureStressReliefPerMonth,leisureReliefUsedThisMonth,consecutiveMinimumCreditCardPayments,sideJobsWorkedThisMonth,sideJobIncome,sideJobStress,maxSideJobsPerMonth,assetSellFeeRate,salarySuspendedMonths,hasHealthInsurance,healthInsurancePremiumMonthly,inflationAnnualRate,salaryGrowthAnnualRate,inflationIndex,savingsBalance,savingsAnnualRate,bankLoanAnnualRate,bankLoanMinCredit,bankLoanMaxLtv,const DeepCollectionEquality().hash(courses),const DeepCollectionEquality().hash(completedCourseIds),studyingCourseId,studyingMonthsLeft,const DeepCollectionEquality().hash(assets),const DeepCollectionEquality().hash(loans),const DeepCollectionEquality().hash(market),const DeepCollectionEquality().hash(pendingProceeds)]);

@override
String toString() {
  return 'GameState(country: $country, currency: $currency, scenarioId: $scenarioId, currentMonth: $currentMonth, ageInMonths: $ageInMonths, startCalendarMonth: $startCalendarMonth, cash: $cash, monthlyExpenses: $monthlyExpenses, monthlyRent: $monthlyRent, baseSalary: $baseSalary, stress: $stress, networkScore: $networkScore, creditScore: $creditScore, housingLevel: $housingLevel, ownedItems: $ownedItems, currentEventId: $currentEventId, eventLastFired: $eventLastFired, flags: $flags, unlockedInsightCardIds: $unlockedInsightCardIds, familySupportExpense: $familySupportExpense, baseEventChance: $baseEventChance, bankruptcyMonthsThreshold: $bankruptcyMonthsThreshold, leisureCostPerStressPoint: $leisureCostPerStressPoint, maxLeisureStressReliefPerMonth: $maxLeisureStressReliefPerMonth, leisureReliefUsedThisMonth: $leisureReliefUsedThisMonth, consecutiveMinimumCreditCardPayments: $consecutiveMinimumCreditCardPayments, sideJobsWorkedThisMonth: $sideJobsWorkedThisMonth, sideJobIncome: $sideJobIncome, sideJobStress: $sideJobStress, maxSideJobsPerMonth: $maxSideJobsPerMonth, assetSellFeeRate: $assetSellFeeRate, salarySuspendedMonths: $salarySuspendedMonths, hasHealthInsurance: $hasHealthInsurance, healthInsurancePremiumMonthly: $healthInsurancePremiumMonthly, inflationAnnualRate: $inflationAnnualRate, salaryGrowthAnnualRate: $salaryGrowthAnnualRate, inflationIndex: $inflationIndex, savingsBalance: $savingsBalance, savingsAnnualRate: $savingsAnnualRate, bankLoanAnnualRate: $bankLoanAnnualRate, bankLoanMinCredit: $bankLoanMinCredit, bankLoanMaxLtv: $bankLoanMaxLtv, courses: $courses, completedCourseIds: $completedCourseIds, studyingCourseId: $studyingCourseId, studyingMonthsLeft: $studyingMonthsLeft, assets: $assets, loans: $loans, market: $market, pendingProceeds: $pendingProceeds)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 Country country, Currency currency, String scenarioId, int currentMonth, int ageInMonths, int startCalendarMonth, double cash, double monthlyExpenses, double monthlyRent, double baseSalary, int stress, int networkScore, int creditScore, HousingLevel housingLevel, List<String> ownedItems, String? currentEventId, Map<String, int> eventLastFired, Set<String> flags, Set<String> unlockedInsightCardIds, double familySupportExpense, double baseEventChance, int bankruptcyMonthsThreshold, double leisureCostPerStressPoint, int maxLeisureStressReliefPerMonth, int leisureReliefUsedThisMonth, int consecutiveMinimumCreditCardPayments, int sideJobsWorkedThisMonth, double sideJobIncome, int sideJobStress, int maxSideJobsPerMonth, double assetSellFeeRate, int salarySuspendedMonths, bool hasHealthInsurance, double healthInsurancePremiumMonthly, double inflationAnnualRate, double salaryGrowthAnnualRate, double inflationIndex, double savingsBalance, double savingsAnnualRate, double bankLoanAnnualRate, int bankLoanMinCredit, double bankLoanMaxLtv, List<CourseConfig> courses, Set<String> completedCourseIds, String? studyingCourseId, int studyingMonthsLeft, List<Asset> assets, List<Loan> loans, Map<String, MarketClassState> market, List<PendingProceed> pendingProceeds
});




}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? country = null,Object? currency = null,Object? scenarioId = null,Object? currentMonth = null,Object? ageInMonths = null,Object? startCalendarMonth = null,Object? cash = null,Object? monthlyExpenses = null,Object? monthlyRent = null,Object? baseSalary = null,Object? stress = null,Object? networkScore = null,Object? creditScore = null,Object? housingLevel = null,Object? ownedItems = null,Object? currentEventId = freezed,Object? eventLastFired = null,Object? flags = null,Object? unlockedInsightCardIds = null,Object? familySupportExpense = null,Object? baseEventChance = null,Object? bankruptcyMonthsThreshold = null,Object? leisureCostPerStressPoint = null,Object? maxLeisureStressReliefPerMonth = null,Object? leisureReliefUsedThisMonth = null,Object? consecutiveMinimumCreditCardPayments = null,Object? sideJobsWorkedThisMonth = null,Object? sideJobIncome = null,Object? sideJobStress = null,Object? maxSideJobsPerMonth = null,Object? assetSellFeeRate = null,Object? salarySuspendedMonths = null,Object? hasHealthInsurance = null,Object? healthInsurancePremiumMonthly = null,Object? inflationAnnualRate = null,Object? salaryGrowthAnnualRate = null,Object? inflationIndex = null,Object? savingsBalance = null,Object? savingsAnnualRate = null,Object? bankLoanAnnualRate = null,Object? bankLoanMinCredit = null,Object? bankLoanMaxLtv = null,Object? courses = null,Object? completedCourseIds = null,Object? studyingCourseId = freezed,Object? studyingMonthsLeft = null,Object? assets = null,Object? loans = null,Object? market = null,Object? pendingProceeds = null,}) {
  return _then(_self.copyWith(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,scenarioId: null == scenarioId ? _self.scenarioId : scenarioId // ignore: cast_nullable_to_non_nullable
as String,currentMonth: null == currentMonth ? _self.currentMonth : currentMonth // ignore: cast_nullable_to_non_nullable
as int,ageInMonths: null == ageInMonths ? _self.ageInMonths : ageInMonths // ignore: cast_nullable_to_non_nullable
as int,startCalendarMonth: null == startCalendarMonth ? _self.startCalendarMonth : startCalendarMonth // ignore: cast_nullable_to_non_nullable
as int,cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,networkScore: null == networkScore ? _self.networkScore : networkScore // ignore: cast_nullable_to_non_nullable
as int,creditScore: null == creditScore ? _self.creditScore : creditScore // ignore: cast_nullable_to_non_nullable
as int,housingLevel: null == housingLevel ? _self.housingLevel : housingLevel // ignore: cast_nullable_to_non_nullable
as HousingLevel,ownedItems: null == ownedItems ? _self.ownedItems : ownedItems // ignore: cast_nullable_to_non_nullable
as List<String>,currentEventId: freezed == currentEventId ? _self.currentEventId : currentEventId // ignore: cast_nullable_to_non_nullable
as String?,eventLastFired: null == eventLastFired ? _self.eventLastFired : eventLastFired // ignore: cast_nullable_to_non_nullable
as Map<String, int>,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as Set<String>,unlockedInsightCardIds: null == unlockedInsightCardIds ? _self.unlockedInsightCardIds : unlockedInsightCardIds // ignore: cast_nullable_to_non_nullable
as Set<String>,familySupportExpense: null == familySupportExpense ? _self.familySupportExpense : familySupportExpense // ignore: cast_nullable_to_non_nullable
as double,baseEventChance: null == baseEventChance ? _self.baseEventChance : baseEventChance // ignore: cast_nullable_to_non_nullable
as double,bankruptcyMonthsThreshold: null == bankruptcyMonthsThreshold ? _self.bankruptcyMonthsThreshold : bankruptcyMonthsThreshold // ignore: cast_nullable_to_non_nullable
as int,leisureCostPerStressPoint: null == leisureCostPerStressPoint ? _self.leisureCostPerStressPoint : leisureCostPerStressPoint // ignore: cast_nullable_to_non_nullable
as double,maxLeisureStressReliefPerMonth: null == maxLeisureStressReliefPerMonth ? _self.maxLeisureStressReliefPerMonth : maxLeisureStressReliefPerMonth // ignore: cast_nullable_to_non_nullable
as int,leisureReliefUsedThisMonth: null == leisureReliefUsedThisMonth ? _self.leisureReliefUsedThisMonth : leisureReliefUsedThisMonth // ignore: cast_nullable_to_non_nullable
as int,consecutiveMinimumCreditCardPayments: null == consecutiveMinimumCreditCardPayments ? _self.consecutiveMinimumCreditCardPayments : consecutiveMinimumCreditCardPayments // ignore: cast_nullable_to_non_nullable
as int,sideJobsWorkedThisMonth: null == sideJobsWorkedThisMonth ? _self.sideJobsWorkedThisMonth : sideJobsWorkedThisMonth // ignore: cast_nullable_to_non_nullable
as int,sideJobIncome: null == sideJobIncome ? _self.sideJobIncome : sideJobIncome // ignore: cast_nullable_to_non_nullable
as double,sideJobStress: null == sideJobStress ? _self.sideJobStress : sideJobStress // ignore: cast_nullable_to_non_nullable
as int,maxSideJobsPerMonth: null == maxSideJobsPerMonth ? _self.maxSideJobsPerMonth : maxSideJobsPerMonth // ignore: cast_nullable_to_non_nullable
as int,assetSellFeeRate: null == assetSellFeeRate ? _self.assetSellFeeRate : assetSellFeeRate // ignore: cast_nullable_to_non_nullable
as double,salarySuspendedMonths: null == salarySuspendedMonths ? _self.salarySuspendedMonths : salarySuspendedMonths // ignore: cast_nullable_to_non_nullable
as int,hasHealthInsurance: null == hasHealthInsurance ? _self.hasHealthInsurance : hasHealthInsurance // ignore: cast_nullable_to_non_nullable
as bool,healthInsurancePremiumMonthly: null == healthInsurancePremiumMonthly ? _self.healthInsurancePremiumMonthly : healthInsurancePremiumMonthly // ignore: cast_nullable_to_non_nullable
as double,inflationAnnualRate: null == inflationAnnualRate ? _self.inflationAnnualRate : inflationAnnualRate // ignore: cast_nullable_to_non_nullable
as double,salaryGrowthAnnualRate: null == salaryGrowthAnnualRate ? _self.salaryGrowthAnnualRate : salaryGrowthAnnualRate // ignore: cast_nullable_to_non_nullable
as double,inflationIndex: null == inflationIndex ? _self.inflationIndex : inflationIndex // ignore: cast_nullable_to_non_nullable
as double,savingsBalance: null == savingsBalance ? _self.savingsBalance : savingsBalance // ignore: cast_nullable_to_non_nullable
as double,savingsAnnualRate: null == savingsAnnualRate ? _self.savingsAnnualRate : savingsAnnualRate // ignore: cast_nullable_to_non_nullable
as double,bankLoanAnnualRate: null == bankLoanAnnualRate ? _self.bankLoanAnnualRate : bankLoanAnnualRate // ignore: cast_nullable_to_non_nullable
as double,bankLoanMinCredit: null == bankLoanMinCredit ? _self.bankLoanMinCredit : bankLoanMinCredit // ignore: cast_nullable_to_non_nullable
as int,bankLoanMaxLtv: null == bankLoanMaxLtv ? _self.bankLoanMaxLtv : bankLoanMaxLtv // ignore: cast_nullable_to_non_nullable
as double,courses: null == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseConfig>,completedCourseIds: null == completedCourseIds ? _self.completedCourseIds : completedCourseIds // ignore: cast_nullable_to_non_nullable
as Set<String>,studyingCourseId: freezed == studyingCourseId ? _self.studyingCourseId : studyingCourseId // ignore: cast_nullable_to_non_nullable
as String?,studyingMonthsLeft: null == studyingMonthsLeft ? _self.studyingMonthsLeft : studyingMonthsLeft // ignore: cast_nullable_to_non_nullable
as int,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<Asset>,loans: null == loans ? _self.loans : loans // ignore: cast_nullable_to_non_nullable
as List<Loan>,market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as Map<String, MarketClassState>,pendingProceeds: null == pendingProceeds ? _self.pendingProceeds : pendingProceeds // ignore: cast_nullable_to_non_nullable
as List<PendingProceed>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Country country,  Currency currency,  String scenarioId,  int currentMonth,  int ageInMonths,  int startCalendarMonth,  double cash,  double monthlyExpenses,  double monthlyRent,  double baseSalary,  int stress,  int networkScore,  int creditScore,  HousingLevel housingLevel,  List<String> ownedItems,  String? currentEventId,  Map<String, int> eventLastFired,  Set<String> flags,  Set<String> unlockedInsightCardIds,  double familySupportExpense,  double baseEventChance,  int bankruptcyMonthsThreshold,  double leisureCostPerStressPoint,  int maxLeisureStressReliefPerMonth,  int leisureReliefUsedThisMonth,  int consecutiveMinimumCreditCardPayments,  int sideJobsWorkedThisMonth,  double sideJobIncome,  int sideJobStress,  int maxSideJobsPerMonth,  double assetSellFeeRate,  int salarySuspendedMonths,  bool hasHealthInsurance,  double healthInsurancePremiumMonthly,  double inflationAnnualRate,  double salaryGrowthAnnualRate,  double inflationIndex,  double savingsBalance,  double savingsAnnualRate,  double bankLoanAnnualRate,  int bankLoanMinCredit,  double bankLoanMaxLtv,  List<CourseConfig> courses,  Set<String> completedCourseIds,  String? studyingCourseId,  int studyingMonthsLeft,  List<Asset> assets,  List<Loan> loans,  Map<String, MarketClassState> market,  List<PendingProceed> pendingProceeds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.country,_that.currency,_that.scenarioId,_that.currentMonth,_that.ageInMonths,_that.startCalendarMonth,_that.cash,_that.monthlyExpenses,_that.monthlyRent,_that.baseSalary,_that.stress,_that.networkScore,_that.creditScore,_that.housingLevel,_that.ownedItems,_that.currentEventId,_that.eventLastFired,_that.flags,_that.unlockedInsightCardIds,_that.familySupportExpense,_that.baseEventChance,_that.bankruptcyMonthsThreshold,_that.leisureCostPerStressPoint,_that.maxLeisureStressReliefPerMonth,_that.leisureReliefUsedThisMonth,_that.consecutiveMinimumCreditCardPayments,_that.sideJobsWorkedThisMonth,_that.sideJobIncome,_that.sideJobStress,_that.maxSideJobsPerMonth,_that.assetSellFeeRate,_that.salarySuspendedMonths,_that.hasHealthInsurance,_that.healthInsurancePremiumMonthly,_that.inflationAnnualRate,_that.salaryGrowthAnnualRate,_that.inflationIndex,_that.savingsBalance,_that.savingsAnnualRate,_that.bankLoanAnnualRate,_that.bankLoanMinCredit,_that.bankLoanMaxLtv,_that.courses,_that.completedCourseIds,_that.studyingCourseId,_that.studyingMonthsLeft,_that.assets,_that.loans,_that.market,_that.pendingProceeds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Country country,  Currency currency,  String scenarioId,  int currentMonth,  int ageInMonths,  int startCalendarMonth,  double cash,  double monthlyExpenses,  double monthlyRent,  double baseSalary,  int stress,  int networkScore,  int creditScore,  HousingLevel housingLevel,  List<String> ownedItems,  String? currentEventId,  Map<String, int> eventLastFired,  Set<String> flags,  Set<String> unlockedInsightCardIds,  double familySupportExpense,  double baseEventChance,  int bankruptcyMonthsThreshold,  double leisureCostPerStressPoint,  int maxLeisureStressReliefPerMonth,  int leisureReliefUsedThisMonth,  int consecutiveMinimumCreditCardPayments,  int sideJobsWorkedThisMonth,  double sideJobIncome,  int sideJobStress,  int maxSideJobsPerMonth,  double assetSellFeeRate,  int salarySuspendedMonths,  bool hasHealthInsurance,  double healthInsurancePremiumMonthly,  double inflationAnnualRate,  double salaryGrowthAnnualRate,  double inflationIndex,  double savingsBalance,  double savingsAnnualRate,  double bankLoanAnnualRate,  int bankLoanMinCredit,  double bankLoanMaxLtv,  List<CourseConfig> courses,  Set<String> completedCourseIds,  String? studyingCourseId,  int studyingMonthsLeft,  List<Asset> assets,  List<Loan> loans,  Map<String, MarketClassState> market,  List<PendingProceed> pendingProceeds)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.country,_that.currency,_that.scenarioId,_that.currentMonth,_that.ageInMonths,_that.startCalendarMonth,_that.cash,_that.monthlyExpenses,_that.monthlyRent,_that.baseSalary,_that.stress,_that.networkScore,_that.creditScore,_that.housingLevel,_that.ownedItems,_that.currentEventId,_that.eventLastFired,_that.flags,_that.unlockedInsightCardIds,_that.familySupportExpense,_that.baseEventChance,_that.bankruptcyMonthsThreshold,_that.leisureCostPerStressPoint,_that.maxLeisureStressReliefPerMonth,_that.leisureReliefUsedThisMonth,_that.consecutiveMinimumCreditCardPayments,_that.sideJobsWorkedThisMonth,_that.sideJobIncome,_that.sideJobStress,_that.maxSideJobsPerMonth,_that.assetSellFeeRate,_that.salarySuspendedMonths,_that.hasHealthInsurance,_that.healthInsurancePremiumMonthly,_that.inflationAnnualRate,_that.salaryGrowthAnnualRate,_that.inflationIndex,_that.savingsBalance,_that.savingsAnnualRate,_that.bankLoanAnnualRate,_that.bankLoanMinCredit,_that.bankLoanMaxLtv,_that.courses,_that.completedCourseIds,_that.studyingCourseId,_that.studyingMonthsLeft,_that.assets,_that.loans,_that.market,_that.pendingProceeds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Country country,  Currency currency,  String scenarioId,  int currentMonth,  int ageInMonths,  int startCalendarMonth,  double cash,  double monthlyExpenses,  double monthlyRent,  double baseSalary,  int stress,  int networkScore,  int creditScore,  HousingLevel housingLevel,  List<String> ownedItems,  String? currentEventId,  Map<String, int> eventLastFired,  Set<String> flags,  Set<String> unlockedInsightCardIds,  double familySupportExpense,  double baseEventChance,  int bankruptcyMonthsThreshold,  double leisureCostPerStressPoint,  int maxLeisureStressReliefPerMonth,  int leisureReliefUsedThisMonth,  int consecutiveMinimumCreditCardPayments,  int sideJobsWorkedThisMonth,  double sideJobIncome,  int sideJobStress,  int maxSideJobsPerMonth,  double assetSellFeeRate,  int salarySuspendedMonths,  bool hasHealthInsurance,  double healthInsurancePremiumMonthly,  double inflationAnnualRate,  double salaryGrowthAnnualRate,  double inflationIndex,  double savingsBalance,  double savingsAnnualRate,  double bankLoanAnnualRate,  int bankLoanMinCredit,  double bankLoanMaxLtv,  List<CourseConfig> courses,  Set<String> completedCourseIds,  String? studyingCourseId,  int studyingMonthsLeft,  List<Asset> assets,  List<Loan> loans,  Map<String, MarketClassState> market,  List<PendingProceed> pendingProceeds)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.country,_that.currency,_that.scenarioId,_that.currentMonth,_that.ageInMonths,_that.startCalendarMonth,_that.cash,_that.monthlyExpenses,_that.monthlyRent,_that.baseSalary,_that.stress,_that.networkScore,_that.creditScore,_that.housingLevel,_that.ownedItems,_that.currentEventId,_that.eventLastFired,_that.flags,_that.unlockedInsightCardIds,_that.familySupportExpense,_that.baseEventChance,_that.bankruptcyMonthsThreshold,_that.leisureCostPerStressPoint,_that.maxLeisureStressReliefPerMonth,_that.leisureReliefUsedThisMonth,_that.consecutiveMinimumCreditCardPayments,_that.sideJobsWorkedThisMonth,_that.sideJobIncome,_that.sideJobStress,_that.maxSideJobsPerMonth,_that.assetSellFeeRate,_that.salarySuspendedMonths,_that.hasHealthInsurance,_that.healthInsurancePremiumMonthly,_that.inflationAnnualRate,_that.salaryGrowthAnnualRate,_that.inflationIndex,_that.savingsBalance,_that.savingsAnnualRate,_that.bankLoanAnnualRate,_that.bankLoanMinCredit,_that.bankLoanMaxLtv,_that.courses,_that.completedCourseIds,_that.studyingCourseId,_that.studyingMonthsLeft,_that.assets,_that.loans,_that.market,_that.pendingProceeds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameState extends GameState {
  const _GameState({required this.country, required this.currency, required this.scenarioId, this.currentMonth = 1, this.ageInMonths = 264, this.startCalendarMonth = 1, required this.cash, required this.monthlyExpenses, required this.monthlyRent, required this.baseSalary, this.stress = 0, this.networkScore = 0, this.creditScore = 600, this.housingLevel = HousingLevel.shabbyRoom, final  List<String> ownedItems = const [], this.currentEventId, final  Map<String, int> eventLastFired = const {}, final  Set<String> flags = const {}, final  Set<String> unlockedInsightCardIds = const {}, this.familySupportExpense = 0.0, this.baseEventChance = 0.2, this.bankruptcyMonthsThreshold = 3, this.leisureCostPerStressPoint = 100000, this.maxLeisureStressReliefPerMonth = 20, this.leisureReliefUsedThisMonth = 0, this.consecutiveMinimumCreditCardPayments = 0, this.sideJobsWorkedThisMonth = 0, this.sideJobIncome = 2500000.0, this.sideJobStress = 8, this.maxSideJobsPerMonth = 2, this.assetSellFeeRate = 0.03, this.salarySuspendedMonths = 0, this.hasHealthInsurance = false, this.healthInsurancePremiumMonthly = 0.0, this.inflationAnnualRate = 0.0, this.salaryGrowthAnnualRate = 0.0, this.inflationIndex = 1.0, this.savingsBalance = 0.0, this.savingsAnnualRate = 0.0, this.bankLoanAnnualRate = 0.0, this.bankLoanMinCredit = 700, this.bankLoanMaxLtv = 0.5, final  List<CourseConfig> courses = const [], final  Set<String> completedCourseIds = const {}, this.studyingCourseId, this.studyingMonthsLeft = 0, final  List<Asset> assets = const [], final  List<Loan> loans = const [], final  Map<String, MarketClassState> market = const {}, final  List<PendingProceed> pendingProceeds = const []}): _ownedItems = ownedItems,_eventLastFired = eventLastFired,_flags = flags,_unlockedInsightCardIds = unlockedInsightCardIds,_courses = courses,_completedCourseIds = completedCourseIds,_assets = assets,_loans = loans,_market = market,_pendingProceeds = pendingProceeds,super._();
  factory _GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

// 0. Country & Currency Context
@override final  Country country;
@override final  Currency currency;
@override final  String scenarioId;
// 1. Time
@override@JsonKey() final  int currentMonth;
@override@JsonKey() final  int ageInMonths;
// Default is 22 years old
@override@JsonKey() final  int startCalendarMonth;
// Starting month of the year (1-12)
// 2. Financials (Must be initialized depending on context)
@override final  double cash;
@override final  double monthlyExpenses;
@override final  double monthlyRent;
@override final  double baseSalary;
// 3. Metrics
@override@JsonKey() final  int stress;
@override@JsonKey() final  int networkScore;
@override@JsonKey() final  int creditScore;
// 4. Visual States
@override@JsonKey() final  HousingLevel housingLevel;
 final  List<String> _ownedItems;
@override@JsonKey() List<String> get ownedItems {
  if (_ownedItems is EqualUnmodifiableListView) return _ownedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedItems);
}

// 5. Active Event & Flags
@override final  String? currentEventId;
// Slice 5a: month each event id last fired (drives cooldownMonths in
// GenerateEvent). Per-run state, so it lives here — not session-only.
 final  Map<String, int> _eventLastFired;
// Slice 5a: month each event id last fired (drives cooldownMonths in
// GenerateEvent). Per-run state, so it lives here — not session-only.
@override@JsonKey() Map<String, int> get eventLastFired {
  if (_eventLastFired is EqualUnmodifiableMapView) return _eventLastFired;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_eventLastFired);
}

 final  Set<String> _flags;
@override@JsonKey() Set<String> get flags {
  if (_flags is EqualUnmodifiableSetView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_flags);
}

 final  Set<String> _unlockedInsightCardIds;
@override@JsonKey() Set<String> get unlockedInsightCardIds {
  if (_unlockedInsightCardIds is EqualUnmodifiableSetView) return _unlockedInsightCardIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_unlockedInsightCardIds);
}

@override@JsonKey() final  double familySupportExpense;
@override@JsonKey() final  double baseEventChance;
@override@JsonKey() final  int bankruptcyMonthsThreshold;
@override@JsonKey() final  double leisureCostPerStressPoint;
@override@JsonKey() final  int maxLeisureStressReliefPerMonth;
@override@JsonKey() final  int leisureReliefUsedThisMonth;
@override@JsonKey() final  int consecutiveMinimumCreditCardPayments;
@override@JsonKey() final  int sideJobsWorkedThisMonth;
@override@JsonKey() final  double sideJobIncome;
@override@JsonKey() final  int sideJobStress;
@override@JsonKey() final  int maxSideJobsPerMonth;
@override@JsonKey() final  double assetSellFeeRate;
@override@JsonKey() final  int salarySuspendedMonths;
// job loss: months left without salary
@override@JsonKey() final  bool hasHealthInsurance;
@override@JsonKey() final  double healthInsurancePremiumMonthly;
// 0 = not offered in scenario
// Inflation (applied every Tet). Cash is deliberately NOT indexed —
// money sitting still is money dying.
@override@JsonKey() final  double inflationAnnualRate;
@override@JsonKey() final  double salaryGrowthAnnualRate;
@override@JsonKey() final  double inflationIndex;
// Bank (Slice 3a). Savings compound monthly and are NOT indexed by
// inflation either — the interest is the compensation (real ~+1%/yr).
@override@JsonKey() final  double savingsBalance;
@override@JsonKey() final  double savingsAnnualRate;
// decimal, e.g. 0.045; 0 = no bank
@override@JsonKey() final  double bankLoanAnnualRate;
// % per year (Loan convention); 0 = no lending
@override@JsonKey() final  int bankLoanMinCredit;
@override@JsonKey() final  double bankLoanMaxLtv;
// bank debt cap vs portfolio market value
// Self-upgrade courses (Slice 3b). Course price at purchase time is
// baseCost × inflationIndex — studying early is cheaper. One course at a
// time, each course only once, salary boost is permanent on graduation.
 final  List<CourseConfig> _courses;
// bank debt cap vs portfolio market value
// Self-upgrade courses (Slice 3b). Course price at purchase time is
// baseCost × inflationIndex — studying early is cheaper. One course at a
// time, each course only once, salary boost is permanent on graduation.
@override@JsonKey() List<CourseConfig> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

// scenario config; empty = not offered
 final  Set<String> _completedCourseIds;
// scenario config; empty = not offered
@override@JsonKey() Set<String> get completedCourseIds {
  if (_completedCourseIds is EqualUnmodifiableSetView) return _completedCourseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_completedCourseIds);
}

@override final  String? studyingCourseId;
@override@JsonKey() final  int studyingMonthsLeft;
// 6. Inventories
 final  List<Asset> _assets;
// 6. Inventories
@override@JsonKey() List<Asset> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<Loan> _loans;
@override@JsonKey() List<Loan> get loans {
  if (_loans is EqualUnmodifiableListView) return _loans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_loans);
}

// 7. Market (per asset class; empty for pre-market saves)
 final  Map<String, MarketClassState> _market;
// 7. Market (per asset class; empty for pre-market saves)
@override@JsonKey() Map<String, MarketClassState> get market {
  if (_market is EqualUnmodifiableMapView) return _market;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_market);
}

// Sale proceeds still settling (liquidity delay); cash arrives when due.
 final  List<PendingProceed> _pendingProceeds;
// Sale proceeds still settling (liquidity delay); cash arrives when due.
@override@JsonKey() List<PendingProceed> get pendingProceeds {
  if (_pendingProceeds is EqualUnmodifiableListView) return _pendingProceeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingProceeds);
}


/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&(identical(other.country, country) || other.country == country)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.scenarioId, scenarioId) || other.scenarioId == scenarioId)&&(identical(other.currentMonth, currentMonth) || other.currentMonth == currentMonth)&&(identical(other.ageInMonths, ageInMonths) || other.ageInMonths == ageInMonths)&&(identical(other.startCalendarMonth, startCalendarMonth) || other.startCalendarMonth == startCalendarMonth)&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&(identical(other.baseSalary, baseSalary) || other.baseSalary == baseSalary)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.networkScore, networkScore) || other.networkScore == networkScore)&&(identical(other.creditScore, creditScore) || other.creditScore == creditScore)&&(identical(other.housingLevel, housingLevel) || other.housingLevel == housingLevel)&&const DeepCollectionEquality().equals(other._ownedItems, _ownedItems)&&(identical(other.currentEventId, currentEventId) || other.currentEventId == currentEventId)&&const DeepCollectionEquality().equals(other._eventLastFired, _eventLastFired)&&const DeepCollectionEquality().equals(other._flags, _flags)&&const DeepCollectionEquality().equals(other._unlockedInsightCardIds, _unlockedInsightCardIds)&&(identical(other.familySupportExpense, familySupportExpense) || other.familySupportExpense == familySupportExpense)&&(identical(other.baseEventChance, baseEventChance) || other.baseEventChance == baseEventChance)&&(identical(other.bankruptcyMonthsThreshold, bankruptcyMonthsThreshold) || other.bankruptcyMonthsThreshold == bankruptcyMonthsThreshold)&&(identical(other.leisureCostPerStressPoint, leisureCostPerStressPoint) || other.leisureCostPerStressPoint == leisureCostPerStressPoint)&&(identical(other.maxLeisureStressReliefPerMonth, maxLeisureStressReliefPerMonth) || other.maxLeisureStressReliefPerMonth == maxLeisureStressReliefPerMonth)&&(identical(other.leisureReliefUsedThisMonth, leisureReliefUsedThisMonth) || other.leisureReliefUsedThisMonth == leisureReliefUsedThisMonth)&&(identical(other.consecutiveMinimumCreditCardPayments, consecutiveMinimumCreditCardPayments) || other.consecutiveMinimumCreditCardPayments == consecutiveMinimumCreditCardPayments)&&(identical(other.sideJobsWorkedThisMonth, sideJobsWorkedThisMonth) || other.sideJobsWorkedThisMonth == sideJobsWorkedThisMonth)&&(identical(other.sideJobIncome, sideJobIncome) || other.sideJobIncome == sideJobIncome)&&(identical(other.sideJobStress, sideJobStress) || other.sideJobStress == sideJobStress)&&(identical(other.maxSideJobsPerMonth, maxSideJobsPerMonth) || other.maxSideJobsPerMonth == maxSideJobsPerMonth)&&(identical(other.assetSellFeeRate, assetSellFeeRate) || other.assetSellFeeRate == assetSellFeeRate)&&(identical(other.salarySuspendedMonths, salarySuspendedMonths) || other.salarySuspendedMonths == salarySuspendedMonths)&&(identical(other.hasHealthInsurance, hasHealthInsurance) || other.hasHealthInsurance == hasHealthInsurance)&&(identical(other.healthInsurancePremiumMonthly, healthInsurancePremiumMonthly) || other.healthInsurancePremiumMonthly == healthInsurancePremiumMonthly)&&(identical(other.inflationAnnualRate, inflationAnnualRate) || other.inflationAnnualRate == inflationAnnualRate)&&(identical(other.salaryGrowthAnnualRate, salaryGrowthAnnualRate) || other.salaryGrowthAnnualRate == salaryGrowthAnnualRate)&&(identical(other.inflationIndex, inflationIndex) || other.inflationIndex == inflationIndex)&&(identical(other.savingsBalance, savingsBalance) || other.savingsBalance == savingsBalance)&&(identical(other.savingsAnnualRate, savingsAnnualRate) || other.savingsAnnualRate == savingsAnnualRate)&&(identical(other.bankLoanAnnualRate, bankLoanAnnualRate) || other.bankLoanAnnualRate == bankLoanAnnualRate)&&(identical(other.bankLoanMinCredit, bankLoanMinCredit) || other.bankLoanMinCredit == bankLoanMinCredit)&&(identical(other.bankLoanMaxLtv, bankLoanMaxLtv) || other.bankLoanMaxLtv == bankLoanMaxLtv)&&const DeepCollectionEquality().equals(other._courses, _courses)&&const DeepCollectionEquality().equals(other._completedCourseIds, _completedCourseIds)&&(identical(other.studyingCourseId, studyingCourseId) || other.studyingCourseId == studyingCourseId)&&(identical(other.studyingMonthsLeft, studyingMonthsLeft) || other.studyingMonthsLeft == studyingMonthsLeft)&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._loans, _loans)&&const DeepCollectionEquality().equals(other._market, _market)&&const DeepCollectionEquality().equals(other._pendingProceeds, _pendingProceeds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,country,currency,scenarioId,currentMonth,ageInMonths,startCalendarMonth,cash,monthlyExpenses,monthlyRent,baseSalary,stress,networkScore,creditScore,housingLevel,const DeepCollectionEquality().hash(_ownedItems),currentEventId,const DeepCollectionEquality().hash(_eventLastFired),const DeepCollectionEquality().hash(_flags),const DeepCollectionEquality().hash(_unlockedInsightCardIds),familySupportExpense,baseEventChance,bankruptcyMonthsThreshold,leisureCostPerStressPoint,maxLeisureStressReliefPerMonth,leisureReliefUsedThisMonth,consecutiveMinimumCreditCardPayments,sideJobsWorkedThisMonth,sideJobIncome,sideJobStress,maxSideJobsPerMonth,assetSellFeeRate,salarySuspendedMonths,hasHealthInsurance,healthInsurancePremiumMonthly,inflationAnnualRate,salaryGrowthAnnualRate,inflationIndex,savingsBalance,savingsAnnualRate,bankLoanAnnualRate,bankLoanMinCredit,bankLoanMaxLtv,const DeepCollectionEquality().hash(_courses),const DeepCollectionEquality().hash(_completedCourseIds),studyingCourseId,studyingMonthsLeft,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_loans),const DeepCollectionEquality().hash(_market),const DeepCollectionEquality().hash(_pendingProceeds)]);

@override
String toString() {
  return 'GameState(country: $country, currency: $currency, scenarioId: $scenarioId, currentMonth: $currentMonth, ageInMonths: $ageInMonths, startCalendarMonth: $startCalendarMonth, cash: $cash, monthlyExpenses: $monthlyExpenses, monthlyRent: $monthlyRent, baseSalary: $baseSalary, stress: $stress, networkScore: $networkScore, creditScore: $creditScore, housingLevel: $housingLevel, ownedItems: $ownedItems, currentEventId: $currentEventId, eventLastFired: $eventLastFired, flags: $flags, unlockedInsightCardIds: $unlockedInsightCardIds, familySupportExpense: $familySupportExpense, baseEventChance: $baseEventChance, bankruptcyMonthsThreshold: $bankruptcyMonthsThreshold, leisureCostPerStressPoint: $leisureCostPerStressPoint, maxLeisureStressReliefPerMonth: $maxLeisureStressReliefPerMonth, leisureReliefUsedThisMonth: $leisureReliefUsedThisMonth, consecutiveMinimumCreditCardPayments: $consecutiveMinimumCreditCardPayments, sideJobsWorkedThisMonth: $sideJobsWorkedThisMonth, sideJobIncome: $sideJobIncome, sideJobStress: $sideJobStress, maxSideJobsPerMonth: $maxSideJobsPerMonth, assetSellFeeRate: $assetSellFeeRate, salarySuspendedMonths: $salarySuspendedMonths, hasHealthInsurance: $hasHealthInsurance, healthInsurancePremiumMonthly: $healthInsurancePremiumMonthly, inflationAnnualRate: $inflationAnnualRate, salaryGrowthAnnualRate: $salaryGrowthAnnualRate, inflationIndex: $inflationIndex, savingsBalance: $savingsBalance, savingsAnnualRate: $savingsAnnualRate, bankLoanAnnualRate: $bankLoanAnnualRate, bankLoanMinCredit: $bankLoanMinCredit, bankLoanMaxLtv: $bankLoanMaxLtv, courses: $courses, completedCourseIds: $completedCourseIds, studyingCourseId: $studyingCourseId, studyingMonthsLeft: $studyingMonthsLeft, assets: $assets, loans: $loans, market: $market, pendingProceeds: $pendingProceeds)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 Country country, Currency currency, String scenarioId, int currentMonth, int ageInMonths, int startCalendarMonth, double cash, double monthlyExpenses, double monthlyRent, double baseSalary, int stress, int networkScore, int creditScore, HousingLevel housingLevel, List<String> ownedItems, String? currentEventId, Map<String, int> eventLastFired, Set<String> flags, Set<String> unlockedInsightCardIds, double familySupportExpense, double baseEventChance, int bankruptcyMonthsThreshold, double leisureCostPerStressPoint, int maxLeisureStressReliefPerMonth, int leisureReliefUsedThisMonth, int consecutiveMinimumCreditCardPayments, int sideJobsWorkedThisMonth, double sideJobIncome, int sideJobStress, int maxSideJobsPerMonth, double assetSellFeeRate, int salarySuspendedMonths, bool hasHealthInsurance, double healthInsurancePremiumMonthly, double inflationAnnualRate, double salaryGrowthAnnualRate, double inflationIndex, double savingsBalance, double savingsAnnualRate, double bankLoanAnnualRate, int bankLoanMinCredit, double bankLoanMaxLtv, List<CourseConfig> courses, Set<String> completedCourseIds, String? studyingCourseId, int studyingMonthsLeft, List<Asset> assets, List<Loan> loans, Map<String, MarketClassState> market, List<PendingProceed> pendingProceeds
});




}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? country = null,Object? currency = null,Object? scenarioId = null,Object? currentMonth = null,Object? ageInMonths = null,Object? startCalendarMonth = null,Object? cash = null,Object? monthlyExpenses = null,Object? monthlyRent = null,Object? baseSalary = null,Object? stress = null,Object? networkScore = null,Object? creditScore = null,Object? housingLevel = null,Object? ownedItems = null,Object? currentEventId = freezed,Object? eventLastFired = null,Object? flags = null,Object? unlockedInsightCardIds = null,Object? familySupportExpense = null,Object? baseEventChance = null,Object? bankruptcyMonthsThreshold = null,Object? leisureCostPerStressPoint = null,Object? maxLeisureStressReliefPerMonth = null,Object? leisureReliefUsedThisMonth = null,Object? consecutiveMinimumCreditCardPayments = null,Object? sideJobsWorkedThisMonth = null,Object? sideJobIncome = null,Object? sideJobStress = null,Object? maxSideJobsPerMonth = null,Object? assetSellFeeRate = null,Object? salarySuspendedMonths = null,Object? hasHealthInsurance = null,Object? healthInsurancePremiumMonthly = null,Object? inflationAnnualRate = null,Object? salaryGrowthAnnualRate = null,Object? inflationIndex = null,Object? savingsBalance = null,Object? savingsAnnualRate = null,Object? bankLoanAnnualRate = null,Object? bankLoanMinCredit = null,Object? bankLoanMaxLtv = null,Object? courses = null,Object? completedCourseIds = null,Object? studyingCourseId = freezed,Object? studyingMonthsLeft = null,Object? assets = null,Object? loans = null,Object? market = null,Object? pendingProceeds = null,}) {
  return _then(_GameState(
country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,scenarioId: null == scenarioId ? _self.scenarioId : scenarioId // ignore: cast_nullable_to_non_nullable
as String,currentMonth: null == currentMonth ? _self.currentMonth : currentMonth // ignore: cast_nullable_to_non_nullable
as int,ageInMonths: null == ageInMonths ? _self.ageInMonths : ageInMonths // ignore: cast_nullable_to_non_nullable
as int,startCalendarMonth: null == startCalendarMonth ? _self.startCalendarMonth : startCalendarMonth // ignore: cast_nullable_to_non_nullable
as int,cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,baseSalary: null == baseSalary ? _self.baseSalary : baseSalary // ignore: cast_nullable_to_non_nullable
as double,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,networkScore: null == networkScore ? _self.networkScore : networkScore // ignore: cast_nullable_to_non_nullable
as int,creditScore: null == creditScore ? _self.creditScore : creditScore // ignore: cast_nullable_to_non_nullable
as int,housingLevel: null == housingLevel ? _self.housingLevel : housingLevel // ignore: cast_nullable_to_non_nullable
as HousingLevel,ownedItems: null == ownedItems ? _self._ownedItems : ownedItems // ignore: cast_nullable_to_non_nullable
as List<String>,currentEventId: freezed == currentEventId ? _self.currentEventId : currentEventId // ignore: cast_nullable_to_non_nullable
as String?,eventLastFired: null == eventLastFired ? _self._eventLastFired : eventLastFired // ignore: cast_nullable_to_non_nullable
as Map<String, int>,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as Set<String>,unlockedInsightCardIds: null == unlockedInsightCardIds ? _self._unlockedInsightCardIds : unlockedInsightCardIds // ignore: cast_nullable_to_non_nullable
as Set<String>,familySupportExpense: null == familySupportExpense ? _self.familySupportExpense : familySupportExpense // ignore: cast_nullable_to_non_nullable
as double,baseEventChance: null == baseEventChance ? _self.baseEventChance : baseEventChance // ignore: cast_nullable_to_non_nullable
as double,bankruptcyMonthsThreshold: null == bankruptcyMonthsThreshold ? _self.bankruptcyMonthsThreshold : bankruptcyMonthsThreshold // ignore: cast_nullable_to_non_nullable
as int,leisureCostPerStressPoint: null == leisureCostPerStressPoint ? _self.leisureCostPerStressPoint : leisureCostPerStressPoint // ignore: cast_nullable_to_non_nullable
as double,maxLeisureStressReliefPerMonth: null == maxLeisureStressReliefPerMonth ? _self.maxLeisureStressReliefPerMonth : maxLeisureStressReliefPerMonth // ignore: cast_nullable_to_non_nullable
as int,leisureReliefUsedThisMonth: null == leisureReliefUsedThisMonth ? _self.leisureReliefUsedThisMonth : leisureReliefUsedThisMonth // ignore: cast_nullable_to_non_nullable
as int,consecutiveMinimumCreditCardPayments: null == consecutiveMinimumCreditCardPayments ? _self.consecutiveMinimumCreditCardPayments : consecutiveMinimumCreditCardPayments // ignore: cast_nullable_to_non_nullable
as int,sideJobsWorkedThisMonth: null == sideJobsWorkedThisMonth ? _self.sideJobsWorkedThisMonth : sideJobsWorkedThisMonth // ignore: cast_nullable_to_non_nullable
as int,sideJobIncome: null == sideJobIncome ? _self.sideJobIncome : sideJobIncome // ignore: cast_nullable_to_non_nullable
as double,sideJobStress: null == sideJobStress ? _self.sideJobStress : sideJobStress // ignore: cast_nullable_to_non_nullable
as int,maxSideJobsPerMonth: null == maxSideJobsPerMonth ? _self.maxSideJobsPerMonth : maxSideJobsPerMonth // ignore: cast_nullable_to_non_nullable
as int,assetSellFeeRate: null == assetSellFeeRate ? _self.assetSellFeeRate : assetSellFeeRate // ignore: cast_nullable_to_non_nullable
as double,salarySuspendedMonths: null == salarySuspendedMonths ? _self.salarySuspendedMonths : salarySuspendedMonths // ignore: cast_nullable_to_non_nullable
as int,hasHealthInsurance: null == hasHealthInsurance ? _self.hasHealthInsurance : hasHealthInsurance // ignore: cast_nullable_to_non_nullable
as bool,healthInsurancePremiumMonthly: null == healthInsurancePremiumMonthly ? _self.healthInsurancePremiumMonthly : healthInsurancePremiumMonthly // ignore: cast_nullable_to_non_nullable
as double,inflationAnnualRate: null == inflationAnnualRate ? _self.inflationAnnualRate : inflationAnnualRate // ignore: cast_nullable_to_non_nullable
as double,salaryGrowthAnnualRate: null == salaryGrowthAnnualRate ? _self.salaryGrowthAnnualRate : salaryGrowthAnnualRate // ignore: cast_nullable_to_non_nullable
as double,inflationIndex: null == inflationIndex ? _self.inflationIndex : inflationIndex // ignore: cast_nullable_to_non_nullable
as double,savingsBalance: null == savingsBalance ? _self.savingsBalance : savingsBalance // ignore: cast_nullable_to_non_nullable
as double,savingsAnnualRate: null == savingsAnnualRate ? _self.savingsAnnualRate : savingsAnnualRate // ignore: cast_nullable_to_non_nullable
as double,bankLoanAnnualRate: null == bankLoanAnnualRate ? _self.bankLoanAnnualRate : bankLoanAnnualRate // ignore: cast_nullable_to_non_nullable
as double,bankLoanMinCredit: null == bankLoanMinCredit ? _self.bankLoanMinCredit : bankLoanMinCredit // ignore: cast_nullable_to_non_nullable
as int,bankLoanMaxLtv: null == bankLoanMaxLtv ? _self.bankLoanMaxLtv : bankLoanMaxLtv // ignore: cast_nullable_to_non_nullable
as double,courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseConfig>,completedCourseIds: null == completedCourseIds ? _self._completedCourseIds : completedCourseIds // ignore: cast_nullable_to_non_nullable
as Set<String>,studyingCourseId: freezed == studyingCourseId ? _self.studyingCourseId : studyingCourseId // ignore: cast_nullable_to_non_nullable
as String?,studyingMonthsLeft: null == studyingMonthsLeft ? _self.studyingMonthsLeft : studyingMonthsLeft // ignore: cast_nullable_to_non_nullable
as int,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<Asset>,loans: null == loans ? _self._loans : loans // ignore: cast_nullable_to_non_nullable
as List<Loan>,market: null == market ? _self._market : market // ignore: cast_nullable_to_non_nullable
as Map<String, MarketClassState>,pendingProceeds: null == pendingProceeds ? _self._pendingProceeds : pendingProceeds // ignore: cast_nullable_to_non_nullable
as List<PendingProceed>,
  ));
}


}

// dart format on
