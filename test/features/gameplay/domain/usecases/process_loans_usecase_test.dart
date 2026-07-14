import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/domain/usecases/process_loans_usecase.dart';

void main() {
  late ProcessLoansUseCase usecase;

  setUp(() {
    usecase = ProcessLoansUseCase();
  });

  group('ProcessLoansUseCase', () {
    test('should calculate interest correctly based on percentage (Task 0.1)', () {
      // Test tính tay: nợ gốc 30,000, lãi 5.5%/năm, trả tối thiểu 300/tháng
      // Tháng 1:
      // Lãi = 30000 * (5.5 / 100 / 12) = 137.5
      // Dư nợ mới = 30000 + 137.5 - 300 = 29837.5
      //
      // Chạy tiếp 12 tháng, assert dư nợ cuối ≈ 27,972 (sai số < 1).
      
      var state = GameState(
        country: Country.usa,
        currency: Currency.usd,
        cash: 5000,
        monthlyExpenses: 0,
        baseSalary: 0,
        loans: [
          const Loan(
            id: 'l1',
            name: 'Student Loan',
            principalAmount: 30000,
            interestRatePerYear: 5.5,
            minimumMonthlyPayment: 300,
            type: LoanType.personalLoan,
          )
        ],
      );

      // Tháng 1
      state = usecase(state);
      expect(state.loans.first.principalAmount, closeTo(29837.5, 0.1));
      
      // Chạy thêm 11 tháng (tổng 12 tháng)
      for (int i = 0; i < 11; i++) {
        state = usecase(state);
      }
      
      // Lãi suất thực tế sau 12 tháng (kép) theo công thức của ProcessLoansUseCase:
      // Dư nợ cuối cùng sẽ là khoảng 28000.08 (chứ không phải 27972)
      expect(state.loans.first.principalAmount, closeTo(28000.08, 1.0));
    });

    test('should handle ghost loan bug and remove fully paid loans (Task 0.2)', () {
      // Test: loan dư nợ 250, lãi 12%/năm, min payment 300 
      // Tháng đó chỉ bị trừ 250 + 2.50 = 252.50, tháng sau list loans rỗng và cash không đổi.
      // Lãi = 250 * (12 / 100 / 12) = 2.50
      // Tổng nợ = 252.50
      // Min payment = 300 -> thanh toán 252.50
      
      var state = GameState(
        country: Country.vietnam,
        currency: Currency.vnd,
        cash: 1000,
        monthlyExpenses: 0,
        baseSalary: 0,
        loans: [
          const Loan(
            id: 'l2',
            name: 'Credit Card',
            principalAmount: 250,
            interestRatePerYear: 12.0,
            minimumMonthlyPayment: 300,
            type: LoanType.creditCard,
          )
        ],
      );

      state = usecase(state);
      
      // Cash bị trừ đúng bằng số tiền nợ cuối cùng (252.5) chứ không phải 300
      expect(state.cash, 1000 - 252.5);
      
      // Loan list phải rỗng
      expect(state.loans.isEmpty, true);
    });
  });
}
