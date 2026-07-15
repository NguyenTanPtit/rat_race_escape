import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';

enum StatType { stress, network }

class StatBar extends StatelessWidget {
  final String label;
  final String emoji;
  final int value;
  final int maxValue;
  final StatType type;

  const StatBar({
    super.key,
    required this.label,
    required this.emoji,
    required this.value,
    this.maxValue = 100,
    required this.type,
  });

  Color _getColor(double ratio) {
    if (type == StatType.stress) {
      if (ratio < 0.4) return AppColors.stressLow;
      if (ratio < 0.7) return AppColors.stressMedium;
      return AppColors.stressHigh;
    } else {
      return AppColors.networkColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double ratio = (value / maxValue).clamp(0.0, 1.0);
    final Color barColor = _getColor(ratio);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$emoji $label',
              style: AppTextStyles.bodyMedium,
            ),
            Text(
              '$value/$maxValue',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.cardFill,
            border: Border.all(color: AppColors.ink, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(2), // Inset for the fill
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxFillWidth = constraints.maxWidth;
              final double fillHeight = constraints.maxHeight;
              
              double fillWidth = maxFillWidth * ratio;
              if (value > 0 && fillWidth < fillHeight) {
                fillWidth = fillHeight; // Minimum width = height to show a dot
              }
              
              if (value <= 0) {
                fillWidth = 0;
              }

              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: fillWidth,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(6), // Rounded to match track
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
