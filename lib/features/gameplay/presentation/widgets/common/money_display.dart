import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';

class MoneyDisplay extends StatelessWidget {
  final String label;
  final double amount;
  final double? cashflow; // Hiển thị chip cashflow nếu có

  const MoneyDisplay({
    super.key,
    required this.label,
    required this.amount,
    this.cashflow,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = amount < 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              MoneyFormat.format(amount),
              style: AppTextStyles.moneyLarge.copyWith(
                color: isNegative ? AppColors.stressHigh : AppColors.ink,
              ),
            ),
            if (cashflow != null) ...[
              const SizedBox(width: AppSpacing.s),
              _CashflowChip(amount: cashflow!),
            ]
          ],
        ),
      ],
    );
  }
}

class _CashflowChip extends StatelessWidget {
  final double amount;

  const _CashflowChip({required this.amount});

  @override
  Widget build(BuildContext context) {
    if (amount == 0) return const SizedBox.shrink();

    final isPositive = amount > 0;
    final color = isPositive ? AppColors.primaryDark : AppColors.stressHigh;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    final sign = isPositive ? '+' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: AppSpacing.xs),
      margin: const EdgeInsets.only(bottom: 4), // Căn chỉnh so với chữ to
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        border: Border.all(color: AppColors.ink, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(2, 2),
            blurRadius: 0,
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 2),
          Text(
            '$sign${MoneyFormat.format(amount)}/tháng',
            style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
