import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/bottom_nav.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/end_turn_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/event_card.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/money_display.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/stat_bar.dart';
import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/yearly_recap_dialog.dart';
import 'package:flutter/services.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/insight_card_popup.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/leisure_dialog.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  YearlyRecap? _lastShownRecap;
  int _lastStressBannerLevel = 0; // To track 75 or 90
  bool _wasAutoAdvancing = false;

  void _showWarningBanner(String message) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.stressHigh,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameEngineCubit, GameEngineState>(
      listener: (context, state) {
        if (state is GameEngineWon) {
          context.go('/win');
        } else if (state is GameEngineGameOver) {
          context.go('/gameOver');
        }

        if (state is GameEnginePlaying) {
          final justStoppedAutoAdvance = _wasAutoAdvancing && !state.isAutoAdvancing;
          final manualAction = !_wasAutoAdvancing && !state.isAutoAdvancing;
          if ((justStoppedAutoAdvance || manualAction) && state.newlyUnlockedInsightCardIds.isNotEmpty) {
            InsightCardPopup.showIfAny(context, state.newlyUnlockedInsightCardIds);
            context.read<GameEngineCubit>().clearNewlyUnlockedCards();
          }
          _wasAutoAdvancing = state.isAutoAdvancing;

          if (!state.isAutoAdvancing && state.monthlySummary != null) {
            // Only show monthly summary dialog if NOT auto advancing
            _showMonthlySummary(context, state.monthlySummary!);
          }
          
          if (state.yearlyRecap != null && state.yearlyRecap != _lastShownRecap) {
            _lastShownRecap = state.yearlyRecap;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => YearlyRecapDialog(
                recap: state.yearlyRecap!,
              ),
            );
          }
          
          // Stress Warning Banner logic
          if (state.gameState.stress >= 90 && _lastStressBannerLevel < 90) {
            _lastStressBannerLevel = 90;
            _showWarningBanner("Cơ thể bạn đang cạn kiệt năng lượng (Stress ≥ 90)!");
          } else if (state.gameState.stress >= 75 && _lastStressBannerLevel < 75) {
            _lastStressBannerLevel = 75;
            _showWarningBanner("Cơ thể bạn đang lên tiếng (Stress ≥ 75)!");
          } else if (state.gameState.stress < 75) {
            _lastStressBannerLevel = 0; // Reset
          }
        }
      },
      builder: (context, state) {
        if (state is! GameEnginePlaying) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final gameState = state.gameState;
        final hasEvent = gameState.currentEventId != null;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.month(gameState.calendarMonth),
                      style: AppTextStyles.h2,
                    ),
                    Text(
                      AppLocalizations.of(context)!.age(gameState.age),
                      style: AppTextStyles.h2,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.l),

                // Money Display
                MoneyDisplay(
                  label: AppLocalizations.of(context)!.netWorth, // Or AppLocalizations.of(context)!.cash
                  amount: gameState.cash,
                  cashflow: gameState.totalCashFlow,
                ),
                const SizedBox(height: AppSpacing.l),

                // Stats
                StatBar(
                  label: AppLocalizations.of(context)!.stress,
                  emoji: '🤯',
                  value: gameState.stress,
                  type: StatType.stress,
                ),
                const SizedBox(height: AppSpacing.s),
                StatBar(
                  label: AppLocalizations.of(context)!.network,
                  emoji: '🤝',
                  value: gameState.networkScore,
                  type: StatType.network,
                ),
                const SizedBox(height: AppSpacing.s),
                StatBar(
                  label: AppLocalizations.of(context)!.creditScore,
                  emoji: '💳',
                  value: gameState.creditScore,
                  type: StatType.credit,
                  maxValue: 850,
                ),
                const SizedBox(height: AppSpacing.l),

                // Event Area
                if (hasEvent && state.currentEvent != null)
                  EventCard(event: state.currentEvent!, gameState: state.gameState)
                else if (state.isAutoAdvancing)
                  _buildAutoAdvancePlaceholder(state.monthlySummary?.cashDelta ?? 0.0),
                if (hasEvent || state.isAutoAdvancing) const SizedBox(height: AppSpacing.l),

                // Cashflows
                if (!state.isAutoAdvancing) ...[
                  Text('Chi tiết dòng tiền:', style: AppTextStyles.h3),
                  const SizedBox(height: AppSpacing.s),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseSalary, value: gameState.baseSalary),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseLiving, value: -gameState.monthlyExpenses),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseRent, value: -gameState.monthlyRent),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseFamily, value: -gameState.familySupportExpense),
                  if (gameState.loans.isNotEmpty)
                    _CashflowItem(
                      label: AppLocalizations.of(context)!.expenseLoan(
                        MoneyFormat.format(gameState.totalLoanPayment),
                        MoneyFormat.format(gameState.totalLoanInterest),
                      ),
                      value: -gameState.totalLoanPayment,
                    ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // Leisure Button
                ElevatedButton(
                  onPressed: state.isAutoAdvancing ? null : () {
                    showDialog(
                      context: context,
                      builder: (_) => LeisureDialog(
                        leisureReliefUsedThisMonth: gameState.leisureReliefUsedThisMonth,
                        currentCash: gameState.cash,
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.btnRelieveStress),
                ),
                const SizedBox(height: 100), // Space for bottom nav and fab
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            width: 80,
            height: 80,
            child: EndTurnButton(
              isAutoAdvancing: state.isAutoAdvancing,
              onPressed: hasEvent ? null : () => context.read<GameEngineCubit>().nextMonth(),
              onLongPress: hasEvent ? null : () => context.read<GameEngineCubit>().autoAdvance(),
              onLongPressUp: () => context.read<GameEngineCubit>().stopAutoAdvance(),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
  
  Widget _buildAutoAdvancePlaceholder(double cashDelta) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.ink.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ink.withValues(alpha: 0.2), width: 2, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Mọi thứ đang bình yên...',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          // Simple floating text simulation
          TweenAnimationBuilder<double>(
            key: ValueKey(cashDelta),
            duration: const Duration(milliseconds: 200),
            tween: Tween(begin: 10.0, end: 0.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: Opacity(
                  opacity: 1.0 - (value / 10),
                  child: Text(
                    '${cashDelta >= 0 ? "+" : ""}${MoneyFormat.format(cashDelta)}',
                    style: AppTextStyles.h2.copyWith(
                      color: cashDelta >= 0 ? AppColors.primary : Colors.red,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showMonthlySummary(BuildContext context, MonthlySummaryDelta summary) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.monthlySummaryTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppLocalizations.of(context)!.monthlySummaryCash}: ${summary.cashDelta > 0 ? "+" : ""}${summary.cashDelta}'),
            Text('${AppLocalizations.of(context)!.monthlySummaryStress}: ${summary.stressDelta > 0 ? "+" : ""}${summary.stressDelta}'),
            Text('${AppLocalizations.of(context)!.monthlySummaryNetWorth}: ${summary.netWorthDelta > 0 ? "+" : ""}${summary.netWorthDelta}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text(AppLocalizations.of(context)!.btnOk),
          ),
        ],
      ),
    );
  }
}

class _CashflowItem extends StatelessWidget {
  final String label;
  final double value;

  const _CashflowItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            '${value > 0 ? "+" : ""}$value', 
            style: AppTextStyles.bodyMedium.copyWith(
              color: value > 0 ? AppColors.primaryDark : AppColors.stressHigh,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
