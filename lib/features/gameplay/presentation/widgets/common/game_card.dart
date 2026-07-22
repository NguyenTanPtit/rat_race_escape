import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';

class GameCard extends StatelessWidget {
  final Widget child;
  final Color fill;
  final Color shadowColor;

  const GameCard({
    super.key,
    required this.child,
    this.fill = AppColors.cardFill,
    this.shadowColor = AppColors.shadowVariantInk,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: AppTokens.borderRadius,
        border: Border.all(
          color: AppColors.ink,
          width: AppTokens.borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: AppTokens.shadowOffset,
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
