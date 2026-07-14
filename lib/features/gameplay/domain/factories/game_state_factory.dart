import '../entities/game_state.dart';
import '../entities/loan.dart';

class GameStateFactory {
  /// Kịch bản: Sinh viên VN mới ra trường
  static GameState createVietnamStarter() {
    return const GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      cash: 10000000.0, // 10 triệu VNĐ
      baseSalary: 8000000.0, // Lương 8 triệu
      monthlyExpenses: 6000000.0, // Chi phí sinh hoạt 6 triệu
      housingLevel: HousingLevel.shabbyRoom, // Trọ bình dân
      loans: [], // Không có nợ
    );
  }

  /// Kịch bản: Sinh viên Mỹ mới ra trường
  static GameState createUSAStarter() {
    return const GameState(
      country: Country.usa,
      currency: Currency.usd,
      cash: 2000.0, // 2 ngàn đô
      baseSalary: 4500.0, // Lương 4.5 ngàn đô
      monthlyExpenses: 3000.0,
      creditScore: 500, // Điểm tín dụng bắt đầu thấp hơn
      loans: [
        // Gánh khoản nợ sinh viên ngay khi bắt đầu
        Loan(
          id: 'usa_student_loan',
          name: 'Student Loan',
          principalAmount: 30000.0, // Nợ 30 ngàn đô
          interestRatePerYear: 5.5,
          minimumMonthlyPayment: 300.0,
          type: LoanType.personalLoan,
        ),
      ],
    );
  }

  /// Kịch bản: Rich Kid Việt Nam (Có thể dùng làm IAP bán gói mở rộng)
  static GameState createVietnamRichKid() {
    return const GameState(
      country: Country.vietnam,
      currency: Currency.vnd,
      cash: 500000000.0, // 500 triệu bố mẹ cho
      baseSalary: 20000000.0, // Làm giám đốc chi nhánh
      monthlyExpenses: 15000000.0, // Tiêu xài hoang phí
      housingLevel: HousingLevel.luxuryCondo, // Ở chung cư cao cấp luôn
      creditScore: 750,
      loans: [],
    );
  }
}