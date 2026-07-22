import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

class InsightCardPopup extends StatelessWidget {
  final Set<String> newlyUnlockedInsightCardIds;

  const InsightCardPopup({
    super.key,
    required this.newlyUnlockedInsightCardIds,
  });

  static void showIfAny(BuildContext context, Set<String> ids) {
    if (ids.isNotEmpty) {
      // Future delay is needed if called during build
      Future.microtask(() {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (_) => InsightCardPopup(newlyUnlockedInsightCardIds: ids),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thẻ bài học mới!'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final id in newlyUnlockedInsightCardIds)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Đã mở khóa: $id', // TODO: Map ID to actual card name/content using repository
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.btnOk),
        ),
      ],
    );
  }
}
