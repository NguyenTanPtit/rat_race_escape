import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/dialogs/insight_card_popup.dart';
import 'package:rat_race_escape/features/gameplay/domain/repositories/insight_card_repository.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/insight_card.dart';
import 'package:get_it/get_it.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';

class WinScreen extends StatefulWidget {
  final GameState finalState;
  final Set<String> newCards;
  const WinScreen({
    super.key,
    required this.finalState,
    required this.newCards,
  });

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late Future<List<InsightCard>> _insightCardsFuture;

  @override
  void initState() {
    super.initState();
    _insightCardsFuture = GetIt.I<InsightCardRepository>().loadInsightCards();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InsightCardPopup.showIfAny(context, widget.newCards);
    });
  }

  @override
  Widget build(BuildContext context) {
    final collectedCards = widget.finalState.unlockedInsightCardIds.length;
    final monthsPlayed = widget.finalState.currentMonth;

    return Scaffold(
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.winTitle,
                style: AppTextStyles.h1.copyWith(color: AppColors.primaryDark),
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
