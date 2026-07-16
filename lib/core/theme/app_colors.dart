import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF22C55E); // Green
  static const Color primaryDark = Color(0xFF16A34A);
  static const Color ink = Color(0xFF161D16); // Dark border/text color
  static const Color cardFill = Color(0xFFFFFFFF); // White
  static const Color background = Color(0xFFFDFBF7); // Cream/mint base

  static const Color disabledFill = Color(0xFFE5E7EB);
  static const Color disabledInk = Color(0xFF9CA3AF);

  // Status Colors
  static const Color stressLow = primary; // Green
  static const Color stressMedium = Color(0xFFF59E0B); // Amber
  static const Color stressHigh = Color(0xFFEF4444); // Red
  
  static const Color networkColor = Color(0xFF8B5CF6); // Purple
  
  static const Color navFill = Color(0xFFF3FCEF);
  static const Color shadowOnPrimary = Color(0xFF004B1E);
  
  static const Color shadowVariantDark = Color(0xFF000000);
  static const Color shadowVariantInk = ink;
}
