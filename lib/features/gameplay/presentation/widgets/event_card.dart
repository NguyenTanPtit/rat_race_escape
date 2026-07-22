import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_event.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/game_card.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

class EventCard extends StatelessWidget {
  final GameEvent event;
  final GameState gameState;

  const EventCard({
    super.key,
    required this.event,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context) {
    return GameCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              event.title,
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              event.description,
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.l),
            ...event.options.map((option) {
              final breakdown = option.effect.calculateCashBreakdown(
                gameState.baseSalary,
                gameState.totalMonthlyOutflow,
              );
              
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<GameEngineCubit>().chooseEventOption(event.id, option.id);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(option.label, textAlign: TextAlign.center),
                      if (breakdown.hasAnyCash)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Builder(
                            builder: (context) {
                              final l10n = AppLocalizations.of(context)!;
                              final List<TextSpan> spans = [];
                              
                              if (breakdown.salaryCash > 0) {
                                spans.add(TextSpan(
                                  text: '${l10n.eventOptionBonus(MoneyFormat.format(breakdown.salaryCash))} ',
                                  style: const TextStyle(color: AppColors.primaryDark),
                                ));
                              }
                              
                              if (breakdown.outflowCash < 0 || breakdown.baseCash < 0) {
                                final totalExpense = (breakdown.outflowCash < 0 ? breakdown.outflowCash : 0.0) + (breakdown.baseCash < 0 ? breakdown.baseCash : 0.0);
                                if (spans.isNotEmpty) spans.add(const TextSpan(text: ', '));
                                spans.add(TextSpan(
                                  text: '${l10n.eventOptionExpense(MoneyFormat.format(totalExpense))} ',
                                  style: const TextStyle(color: AppColors.stressHigh),
                                ));
                              } else if (breakdown.baseCash > 0) {
                                if (spans.isNotEmpty) spans.add(const TextSpan(text: ', '));
                                spans.add(TextSpan(
                                  text: '${l10n.eventOptionStatic(MoneyFormat.format(breakdown.baseCash))} ',
                                  style: const TextStyle(color: AppColors.primaryDark),
                                ));
                              }

                              if (breakdown.salaryCash != 0 && (breakdown.outflowCash != 0 || breakdown.baseCash != 0)) {
                                spans.add(TextSpan(
                                  text: '→ ${l10n.eventOptionNet(MoneyFormat.format(breakdown.totalCash))}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.ink),
                                ));
                              }

                              return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: AppTextStyles.caption,
                                  children: spans,
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
