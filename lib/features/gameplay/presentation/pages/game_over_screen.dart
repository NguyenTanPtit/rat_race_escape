import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/turn_result.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/insight_card_popup.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/insight_card_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/insight_card.dart';
import 'package:get_it/get_it.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

class GameOverScreen extends StatefulWidget {
  final GameOverReason reason;
  final GameState finalState;
  final Set<String> newCards;
  const GameOverScreen({
    super.key,
    required this.reason,
    required this.finalState,
    required this.newCards,
  });

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  late Future<List<InsightCard>> _insightCardsFuture;

  @override
  void initState() {
    super.initState();
    _insightCardsFuture = GetIt.I<InsightCardRepository>().loadInsightCards();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InsightCardPopup.showIfAny(context, widget.newCards);
    });
  }

  String _getReasonText(BuildContext context, GameOverReason reason) {
    switch (reason) {
      case GameOverReason.burnout:
        return AppLocalizations.of(context)!.gameOverReasonBurnout;
      case GameOverReason.bankruptcy:
        return AppLocalizations.of(context)!.gameOverReasonBankruptcy;
      case GameOverReason.debtSpiral:
        return AppLocalizations.of(context)!.gameOverReasonDebtSpiral;
      case GameOverReason.poorAtRetirement:
        return AppLocalizations.of(context)!.gameOverReasonPoorAtRetirement;
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthsPlayed = widget.finalState.currentMonth;
    final collectedCards = widget.finalState.unlockedInsightCardIds.length;

    return Scaffold(
      backgroundColor: AppColors.stressHigh.withValues(alpha: 0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.gameOverTitle,
                style: AppTextStyles.h1.copyWith(color: AppColors.stressHigh),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.l),
              Text(
                _getReasonText(context, widget.reason),
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                AppLocalizations.of(context)!.lifetimeStats,
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: AppSpacing.m),
              Text('Net Worth: ${widget.finalState.netWorth}'),
              Text('Tuổi: ${widget.finalState.age}'),
              Text(AppLocalizations.of(context)!.statMonthsPlayed(monthsPlayed)),
              Text(AppLocalizations.of(context)!.statFinalCredit(widget.finalState.creditScore)),
              FutureBuilder<List<InsightCard>>(
                future: _insightCardsFuture,
                builder: (context, snapshot) {
                  final total = snapshot.data?.length ?? 0;
                  return Text(AppLocalizations.of(context)!.statLessonsCollected(collectedCards, total));
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: Text(AppLocalizations.of(context)!.btnNewGame),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
