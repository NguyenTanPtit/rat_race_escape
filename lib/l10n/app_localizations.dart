import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('vi')];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'Rat Race Escape'**
  String get appTitle;

  /// No description provided for @componentGallery.
  ///
  /// In vi, this message translates to:
  /// **'Component Gallery'**
  String get componentGallery;

  /// No description provided for @month.
  ///
  /// In vi, this message translates to:
  /// **'Tháng {month}'**
  String month(int month);

  /// No description provided for @age.
  ///
  /// In vi, this message translates to:
  /// **'Tuổi {age}'**
  String age(int age);

  /// No description provided for @netWorth.
  ///
  /// In vi, this message translates to:
  /// **'Tài sản ròng'**
  String get netWorth;

  /// No description provided for @cashflow.
  ///
  /// In vi, this message translates to:
  /// **'Dòng tiền'**
  String get cashflow;

  /// No description provided for @stress.
  ///
  /// In vi, this message translates to:
  /// **'Stress'**
  String get stress;

  /// No description provided for @network.
  ///
  /// In vi, this message translates to:
  /// **'Quan hệ'**
  String get network;

  /// No description provided for @creditScore.
  ///
  /// In vi, this message translates to:
  /// **'Tín dụng'**
  String get creditScore;

  /// No description provided for @navAssets.
  ///
  /// In vi, this message translates to:
  /// **'Tài sản'**
  String get navAssets;

  /// No description provided for @navInvest.
  ///
  /// In vi, this message translates to:
  /// **'Đầu tư'**
  String get navInvest;

  /// No description provided for @navBank.
  ///
  /// In vi, this message translates to:
  /// **'Ngân hàng'**
  String get navBank;

  /// No description provided for @navUpgrades.
  ///
  /// In vi, this message translates to:
  /// **'Nâng cấp'**
  String get navUpgrades;

  /// No description provided for @btnEndTurn.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục (Qua tháng)'**
  String get btnEndTurn;

  /// No description provided for @btnRelieveStress.
  ///
  /// In vi, this message translates to:
  /// **'Giải trí xả stress'**
  String get btnRelieveStress;

  /// No description provided for @statLow.
  ///
  /// In vi, this message translates to:
  /// **'Thấp'**
  String get statLow;

  /// No description provided for @statMedium.
  ///
  /// In vi, this message translates to:
  /// **'Vừa'**
  String get statMedium;

  /// No description provided for @statHigh.
  ///
  /// In vi, this message translates to:
  /// **'Cao'**
  String get statHigh;

  /// No description provided for @galleryCards.
  ///
  /// In vi, this message translates to:
  /// **'Game Cards'**
  String get galleryCards;

  /// No description provided for @galleryButtons.
  ///
  /// In vi, this message translates to:
  /// **'Game Buttons'**
  String get galleryButtons;

  /// No description provided for @galleryStats.
  ///
  /// In vi, this message translates to:
  /// **'Stats & Displays'**
  String get galleryStats;

  /// No description provided for @galleryNav.
  ///
  /// In vi, this message translates to:
  /// **'Bottom Navigation'**
  String get galleryNav;

  /// No description provided for @monthlySummaryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tổng kết tháng'**
  String get monthlySummaryTitle;

  /// No description provided for @monthlySummaryCash.
  ///
  /// In vi, this message translates to:
  /// **'Tiền mặt'**
  String get monthlySummaryCash;

  /// No description provided for @monthlySummaryStress.
  ///
  /// In vi, this message translates to:
  /// **'Mức độ Stress'**
  String get monthlySummaryStress;

  /// No description provided for @monthlySummaryNetWorth.
  ///
  /// In vi, this message translates to:
  /// **'Tài sản ròng'**
  String get monthlySummaryNetWorth;

  /// No description provided for @btnOk.
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get btnOk;

  /// No description provided for @gameOverReasonBurnout.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã gục ngã vì kiệt sức (Stress đạt 100%). Hãy chú ý nghỉ ngơi!'**
  String get gameOverReasonBurnout;

  /// No description provided for @gameOverReasonBankruptcy.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã vỡ nợ (Tiền mặt âm quá sâu và không còn khả năng vay mượn).'**
  String get gameOverReasonBankruptcy;

  /// No description provided for @gameOverReasonDebtSpiral.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã rơi vào vòng xoáy nợ nần không lối thoát.'**
  String get gameOverReasonDebtSpiral;

  /// No description provided for @gameOverReasonPoorAtRetirement.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã đến tuổi nghỉ hưu nhưng vẫn chưa đạt được tự do tài chính.'**
  String get gameOverReasonPoorAtRetirement;

  /// No description provided for @winTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chiến thắng!'**
  String get winTitle;

  /// No description provided for @gameOverTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thất bại!'**
  String get gameOverTitle;

  /// No description provided for @lifetimeStats.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê cả đời'**
  String get lifetimeStats;

  /// No description provided for @statMonthsPlayed.
  ///
  /// In vi, this message translates to:
  /// **'Số tháng đã chơi: {months}'**
  String statMonthsPlayed(int months);

  /// No description provided for @statFinalCredit.
  ///
  /// In vi, this message translates to:
  /// **'Tín dụng cuối: {score}'**
  String statFinalCredit(int score);

  /// No description provided for @statLessonsCollected.
  ///
  /// In vi, this message translates to:
  /// **'Bài học thu thập: {collected}/{total}'**
  String statLessonsCollected(int collected, int total);

  /// No description provided for @btnContinueGame.
  ///
  /// In vi, this message translates to:
  /// **'Chơi tiếp'**
  String get btnContinueGame;

  /// No description provided for @btnNewGame.
  ///
  /// In vi, this message translates to:
  /// **'Trò chơi mới'**
  String get btnNewGame;

  /// No description provided for @selectCountry.
  ///
  /// In vi, this message translates to:
  /// **'Chọn Quốc gia'**
  String get selectCountry;

  /// No description provided for @selectContext.
  ///
  /// In vi, this message translates to:
  /// **'Chọn Bối cảnh'**
  String get selectContext;

  /// No description provided for @expenseSalary.
  ///
  /// In vi, this message translates to:
  /// **'Lương'**
  String get expenseSalary;

  /// No description provided for @expenseLiving.
  ///
  /// In vi, this message translates to:
  /// **'Sinh hoạt'**
  String get expenseLiving;

  /// No description provided for @expenseRent.
  ///
  /// In vi, this message translates to:
  /// **'Thuê trọ'**
  String get expenseRent;

  /// No description provided for @expenseFamily.
  ///
  /// In vi, this message translates to:
  /// **'Gửi về quê'**
  String get expenseFamily;

  /// No description provided for @expenseLoan.
  ///
  /// In vi, this message translates to:
  /// **'Trả nợ: {total} (lãi {interest})'**
  String expenseLoan(String total, String interest);

  /// No description provided for @insightCardsLibrary.
  ///
  /// In vi, this message translates to:
  /// **'Góc nhìn Chuyên gia'**
  String get insightCardsLibrary;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
