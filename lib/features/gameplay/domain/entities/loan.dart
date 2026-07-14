import 'package:freezed_annotation/freezed_annotation.dart';

part 'loan.freezed.dart';

@freezed
class Loan with _$Loan {
  const factory Loan({
    required String id,
    required String name,
    required double principalAmount, // Dư nợ gốc còn lại
    required double interestRatePerYear, // Lãi suất % / năm
    required double minimumMonthlyPayment, // Số tiền phải trả tối thiểu mỗi tháng
    @Default(LoanType.creditCard) LoanType type,
  }) = _Loan;
}

enum LoanType { creditCard, personalLoan, mortgage, blackMarket }