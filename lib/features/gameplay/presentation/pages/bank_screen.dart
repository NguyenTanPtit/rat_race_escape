import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/bank/bank_amount_dialog.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';

/// Bank screen: savings (where the emergency fund belongs) and
/// collateral-backed lending (good debt — for those who earned it).
class BankScreen extends StatelessWidget {
  const BankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEngineCubit, GameEngineState>(
      builder: (context, state) {
        if (state is! GameEnginePlaying) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final gameState = state.gameState;
        final enabled = !state.isAutoAdvancing;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Row(
                    children: [
                      GameButton(
                        onPressed: () => context.pop(),
                        fill: AppColors.cardFill,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back, color: AppColors.ink),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Text('NGÂN HÀNG', style: AppTextStyles.h2),
                      const SizedBox(width: AppSpacing.s),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            MoneyFormat.format(gameState.cash),
                            style: AppTextStyles.h3.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.l, 0, AppSpacing.l, AppSpacing.xl),
                    children: [
                      if (gameState.savingsAnnualRate > 0) ...[
                        _SavingsCard(gameState: gameState, enabled: enabled),
                        const SizedBox(height: AppSpacing.l),
                      ],
                      if (gameState.bankLoanAnnualRate > 0) ...[
                        _LoanCard(gameState: gameState, enabled: enabled),
                        const SizedBox(height: AppSpacing.l),
                      ],
                      if (gameState.loans.isNotEmpty)
                        _DebtsCard(gameState: gameState, enabled: enabled),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _openAmountDialog(BuildContext context, BankAction action, double maxAmount,
    {String? loanId}) {
  final cubit = context.read<GameEngineCubit>();
  showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: BankAmountDialog(action: action, maxAmount: maxAmount, loanId: loanId),
    ),
  );
}

class _SavingsCard extends StatelessWidget {
  final GameState gameState;
  final bool enabled;

  const _SavingsCard({required this.gameState, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final ratePercent = (gameState.savingsAnnualRate * 100).toStringAsFixed(1);
    final monthlyInterest = gameState.savingsBalance * gameState.savingsAnnualRate / 12;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🏦 Tiết kiệm', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Số dư: ${MoneyFormat.format(gameState.savingsBalance)}',
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              'Lãi $ratePercent%/năm, cộng mỗi tháng'
              '${gameState.savingsBalance > 0 ? ' • tháng tới ~+${MoneyFormat.format(monthlyInterest)}' : ''}',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
            ),
            const SizedBox(height: 2),
            Text(
              'Nơi an toàn cho quỹ khẩn cấp — nhưng lãi không đuổi kịp đầu tư.',
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.disabledInk, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: AppSpacing.m),
            Row(
              children: [
                Expanded(
                  child: GameButton(
                    onPressed: (enabled && gameState.cash > 0)
                        ? () => _openAmountDialog(
                            context, BankAction.deposit, gameState.cash)
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text('Gửi',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: GameButton(
                    onPressed: (enabled && gameState.savingsBalance > 0)
                        ? () => _openAmountDialog(
                            context, BankAction.withdraw, gameState.savingsBalance)
                        : null,
                    fill: AppColors.navFill,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text('Rút',
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.ink)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LoanCard extends StatelessWidget {
  final GameState gameState;
  final bool enabled;

  const _LoanCard({required this.gameState, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final creditOk = gameState.creditScore >= gameState.bankLoanMinCredit;
    final headroom = gameState.bankLoanHeadroom;
    final ltvPercent = (gameState.bankLoanMaxLtv * 100).toStringAsFixed(0);

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🤝 Vay thế chấp', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Lãi ${gameState.bankLoanAnnualRate.toStringAsFixed(1)}%/năm'
              ' • hạn mức $ltvPercent% giá trị danh mục'
              ' • cần điểm tín dụng ≥ ${gameState.bankLoanMinCredit}',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
            ),
            const SizedBox(height: AppSpacing.s),
            if (!creditOk)
              Text(
                '🔒 Điểm tín dụng của bạn: ${gameState.creditScore}/${gameState.bankLoanMinCredit}'
                ' — ngân hàng chưa tin bạn.',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.stressHigh, fontWeight: FontWeight.bold),
              )
            else if (headroom <= 0)
              Text(
                'Hết hạn mức — cần thêm tài sản thế chấp hoặc trả bớt nợ.',
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              )
            else
              Text(
                'Có thể vay thêm: ${MoneyFormat.format(headroom)}',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryDark, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: AppSpacing.m),
            GameButton(
              onPressed: (enabled && creditOk && headroom > 0)
                  ? () => _openAmountDialog(context, BankAction.takeLoan, headroom)
                  : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text('Vay',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebtsCard extends StatelessWidget {
  final GameState gameState;
  final bool enabled;

  const _DebtsCard({required this.gameState, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📋 Khoản nợ đang có', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            ...gameState.loans.map((loan) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loan.name,
                                style: AppTextStyles.bodyMedium
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Text(
                              'Dư nợ ${MoneyFormat.format(loan.principalAmount)}'
                              ' • lãi ${loan.interestRatePerYear.toStringAsFixed(1)}%/năm'
                              ' • trả tối thiểu ${MoneyFormat.format(loan.minimumMonthlyPayment)}/tháng',
                              style: AppTextStyles.bodySmall
                                  .copyWith(color: AppColors.disabledInk),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s),
                      GameButton(
                        onPressed: (enabled && gameState.cash > 0)
                            ? () => _openAmountDialog(
                                  context,
                                  BankAction.repay,
                                  loan.principalAmount < gameState.cash
                                      ? loan.principalAmount
                                      : gameState.cash,
                                  loanId: loan.id,
                                )
                            : null,
                        fill: _isBank(loan) ? AppColors.primary : AppColors.stressHigh,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          child: Text('Trả',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  bool _isBank(Loan loan) => loan.type == LoanType.mortgage;
}
