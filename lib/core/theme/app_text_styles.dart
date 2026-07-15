import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle _base = TextStyle(
    fontFamily: 'NunitoSans',
    color: AppColors.ink,
    fontWeight: FontWeight.w700, // Brutalism usually uses bold weights
  );

  static final TextStyle h1 = _base.copyWith(
    fontSize: 32,
    height: 1.2,
  );

  static final TextStyle h2 = _base.copyWith(
    fontSize: 24,
    height: 1.2,
  );

  static final TextStyle h3 = _base.copyWith(
    fontSize: 20,
    height: 1.2,
  );

  static final TextStyle bodyLarge = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final TextStyle bodyMedium = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final TextStyle bodySmall = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final TextStyle caption = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  
  static final TextStyle moneyLarge = _base.copyWith(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    height: 1.0,
  );
}
