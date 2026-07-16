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

  @override
  String get monthlySummaryTitle => 'Tổng kết tháng';

  @override
  String get monthlySummaryCash => 'Tiền mặt';

  @override
  String get monthlySummaryStress => 'Mức độ Stress';

  @override
  String get monthlySummaryNetWorth => 'Tài sản ròng';

  @override
  String get btnOk => 'Đồng ý';

  @override
  String get gameOverReasonBurnout =>
      'Bạn đã gục ngã vì kiệt sức (Stress đạt 100%). Hãy chú ý nghỉ ngơi!';

  @override
  String get gameOverReasonBankruptcy =>
      'Bạn đã vỡ nợ (Tiền mặt âm quá sâu và không còn khả năng vay mượn).';

  @override
  String get gameOverReasonDebtSpiral =>
      'Bạn đã rơi vào vòng xoáy nợ nần không lối thoát.';

  @override
  String get gameOverReasonPoorAtRetirement =>
      'Bạn đã đến tuổi nghỉ hưu nhưng vẫn chưa đạt được tự do tài chính.';

  @override
  String get winTitle => 'Chiến thắng!';

  @override
  String get gameOverTitle => 'Thất bại!';

  @override
  String get lifetimeStats => 'Thống kê cả đời';

  @override
  String statMonthsPlayed(int months) {
    return 'Số tháng đã chơi: $months';
  }

  @override
  String statFinalCredit(int score) {
    return 'Tín dụng cuối: $score';
  }

  @override
  String statLessonsCollected(int collected, int total) {
    return 'Bài học thu thập: $collected/$total';
  }

  @override
  String get btnContinueGame => 'Chơi tiếp';

  @override
  String get btnNewGame => 'Trò chơi mới';

  @override
  String get selectCountry => 'Chọn Quốc gia';

  @override
  String get selectContext => 'Chọn Bối cảnh';

  @override
  String get expenseSalary => 'Lương';

  @override
  String get expenseLiving => 'Sinh hoạt';

  @override
  String get expenseRent => 'Thuê trọ';

  @override
  String get expenseFamily => 'Gửi về quê';

  @override
  String expenseLoan(String total, String interest) {
    return 'Trả nợ: $total (lãi $interest)';
  }

  @override
  String get insightCardsLibrary => 'Góc nhìn Chuyên gia';
}
