import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardFill,
        border: Border(
          top: BorderSide(color: AppColors.ink, width: AppTokens.borderWidth),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _NavItem(icon: Icons.account_balance_wallet, label: 'Tài sản', isLocked: true),
            _NavItem(icon: Icons.trending_up, label: 'Đầu tư', isLocked: true),
            _NavItem(icon: Icons.account_balance, label: 'Ngân hàng', isLocked: true),
            _NavItem(icon: Icons.upgrade, label: 'Nâng cấp', isLocked: true),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLocked;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(
              icon,
              size: 28,
              color: isLocked ? AppColors.disabledInk : AppColors.ink,
            ),
            if (isLocked)
              const Positioned(
                right: -4,
                top: -4,
                child: Icon(
                  Icons.lock,
                  size: 14,
                  color: AppColors.ink,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isLocked ? AppColors.disabledInk : AppColors.ink,
          ),
        ),
      ],
    );
  }
}
