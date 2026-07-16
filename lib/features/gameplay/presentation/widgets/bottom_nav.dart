import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: AppColors.navFill,
        border: Border(
          top: BorderSide(color: AppColors.ink, width: AppTokens.borderWidth),
          left: BorderSide(color: AppColors.ink, width: AppTokens.borderWidth),
          right: BorderSide(color: AppColors.ink, width: AppTokens.borderWidth),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000), // Shadow always black for nav
            offset: AppTokens.shadowOffsetUp,
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(child: _NavItem(icon: Icons.account_balance_wallet, label: 'Tài sản', isLocked: true)),
            Expanded(child: _NavItem(icon: Icons.trending_up, label: 'Đầu tư', isLocked: true)),
            SizedBox(width: 96), // Space for EndTurnButton
            Expanded(child: _NavItem(icon: Icons.account_balance, label: 'Ngân hàng', isLocked: true)),
            Expanded(child: _NavItem(icon: Icons.upgrade, label: 'Nâng cấp', isLocked: true)),
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
