import 'package:freezed_annotation/freezed_annotation.dart';

part 'loan.freezed.dart';
part 'loan.g.dart';

@freezed
abstract class Loan with _$Loan {
  @Assert('interestRatePerYear >= 0 && interestRatePerYear < 100', 'Interest rate must be a percentage between 0 and 100')
  const factory Loan({
    required String id,
    required String name,
    required double principalAmount, // Dư nợ gốc còn lại
    required double interestRatePerYear, // Lãi suất % / năm
    required double minimumMonthlyPayment, // Số tiền phải trả tối thiểu mỗi tháng
    @Default(LoanType.creditCard) LoanType type,
  }) = _Loan;

  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);
}

enum LoanType { creditCard, personalLoan, mortgage, blackMarket }