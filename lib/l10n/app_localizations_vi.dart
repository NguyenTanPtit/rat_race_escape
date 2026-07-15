// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Rat Race Escape';

  @override
  String get componentGallery => 'Component Gallery';

  @override
  String month(int month) {
    return 'Tháng $month';
  }

  @override
  String age(int age) {
    return 'Tuổi $age';
  }

  @override
  String get netWorth => 'Tài sản ròng';

  @override
  String get cashflow => 'Dòng tiền';

  @override
  String get stress => 'Stress';

  @override
  String get network => 'Quan hệ';

  @override
  String get creditScore => 'Tín dụng';

  @override
  String get navAssets => 'Tài sản';

  @override
  String get navInvest => 'Đầu tư';

  @override
  String get navBank => 'Ngân hàng';

  @override
  String get navUpgrades => 'Nâng cấp';

  @override
  String get btnEndTurn => 'Tiếp tục (Qua tháng)';

  @override
  String get btnRelieveStress => 'Giải trí xả stress';

  @override
  String get statLow => 'Thấp';

  @override
  String get statMedium => 'Vừa';

  @override
  String get statHigh => 'Cao';

  @override
  String get galleryCards => 'Game Cards';

  @override
  String get galleryButtons => 'Game Buttons';

  @override
  String get galleryStats => 'Stats & Displays';

  @override
  String get galleryNav => 'Bottom Navigation';
}
