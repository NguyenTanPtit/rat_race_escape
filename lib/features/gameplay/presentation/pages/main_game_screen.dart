import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/bottom_nav.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/end_turn_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/events/event_card.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/money_display.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/stat_bar.dart';
import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/l10n/app_localizations.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/dialogs/yearly_recap_dialog.dart';
import 'package:flutter/services.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/dialogs/insight_card_popup.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/dialogs/leisure_dialog.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/market/market_decision_dialog.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  YearlyRecap? _lastShownRecap;
  int _lastStressBannerLevel = 0; // To track 75 or 90
  bool _wasAutoAdvancing = false;
  int? _lastSalarySuspendedMonths; // null until the first state arrives
  double? _lastPendingProceeds;
  Set<String>? _lastCompletedCourseIds;

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

  void _showGoodNewsBanner(String message) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primaryDark,
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

          // Market stop dialog: clear FIRST so re-emits can't re-trigger it.
          if (!state.isAutoAdvancing && state.marketStopInfo != null) {
            final info = state.marketStopInfo!;
            final cubit = context.read<GameEngineCubit>();
            cubit.clearMarketStop();
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: MarketDecisionDialog(info: info),
              ),
            );
          }
          
          // Back to work: salary suspension just ended.
          final suspendedNow = state.gameState.salarySuspendedMonths;
          if (_lastSalarySuspendedMonths != null &&
              _lastSalarySuspendedMonths! > 0 && suspendedNow == 0) {
            _showGoodNewsBanner('🎉 Bạn đã đi làm trở lại — lương quay về từ tháng này!');
          }
          _lastSalarySuspendedMonths = suspendedNow;

          // Graduation: a course just moved into completedCourseIds.
          final completedNow = state.gameState.completedCourseIds;
          if (_lastCompletedCourseIds != null) {
            for (final id in completedNow.difference(_lastCompletedCourseIds!)) {
              for (final course in state.gameState.courses) {
                if (course.id != id) continue;
                final boost = (course.salaryBoostRate * 100).toStringAsFixed(0);
                _showGoodNewsBanner(
                    '🎓 Tốt nghiệp ${course.name} — lương +$boost% vĩnh viễn!');
              }
            }
          }
          _lastCompletedCourseIds = completedNow;

          // Sale proceeds settled into cash.
          final pendingNow = state.gameState.totalPendingProceeds;
          if (_lastPendingProceeds != null && pendingNow < _lastPendingProceeds! - 0.01) {
            final arrived = _lastPendingProceeds! - pendingNow;
            _showGoodNewsBanner('💰 Tiền bán tài sản đã về ví: +${MoneyFormat.format(arrived)}');
          }
          _lastPendingProceeds = pendingNow;

          // Milestone celebration: clear FIRST so re-emits can't re-trigger.
          if (!state.isAutoAdvancing && state.milestonePercent != null) {
            final percent = state.milestonePercent!;
            context.read<GameEngineCubit>().clearMilestone();
            HapticFeedback.mediumImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '🎉 Thu nhập thụ động đã gánh $percent% chi phí hàng tháng!',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.primaryDark,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                duration: const Duration(seconds: 4),
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

                // Money Display: the headline number is what the label says —
                // net worth. Spendable cash is the sub-line, because those two
                // diverge hugely once a portfolio exists.
                MoneyDisplay(
                  label: AppLocalizations.of(context)!.netWorth,
                  amount: gameState.netWorth,
                  cashflow: gameState.totalCashFlow,
                  subtitle: 'Tiền mặt: ${MoneyFormat.format(gameState.cash)}'
                      '${gameState.savingsBalance > 0 ? ' • Tiết kiệm: ${MoneyFormat.format(gameState.savingsBalance)}' : ''}'
                      '${gameState.totalPendingProceeds > 0 ? ' • Đang về: ${MoneyFormat.format(gameState.totalPendingProceeds)}' : ''}',
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
                  _CashflowItem(
                    label: gameState.salarySuspendedMonths > 0
                        ? '${AppLocalizations.of(context)!.expenseSalary} (mất việc, còn ${gameState.salarySuspendedMonths} tháng)'
                        : AppLocalizations.of(context)!.expenseSalary,
                    value: gameState.effectiveSalary,
                  ),
                  // The number that decides the game: passive income. Without
                  // it on screen the player cannot see the win condition move.
                  if (gameState.passiveIncome > 0)
                    _CashflowItem(
                      label: 'Thu nhập thụ động',
                      value: gameState.passiveIncome,
                    ),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseLiving, value: -gameState.monthlyExpenses),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseRent, value: -gameState.monthlyRent),
                  _CashflowItem(label: AppLocalizations.of(context)!.expenseFamily, value: -gameState.familySupportExpense),
                  if (gameState.hasHealthInsurance)
                    _CashflowItem(label: 'Bảo hiểm y tế', value: -gameState.healthInsurancePremiumMonthly),
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
            Text('${AppLocalizations.of(context)!.monthlySummaryCash}: '
                '${summary.cashDelta > 0 ? "+" : ""}${MoneyFormat.format(summary.cashDelta)}'),
            Text('${AppLocalizations.of(context)!.monthlySummaryStress}: '
                '${summary.stressDelta > 0 ? "+" : ""}${summary.stressDelta}'),
            Text('${AppLocalizations.of(context)!.monthlySummaryNetWorth}: '
                '${summary.netWorthDelta > 0 ? "+" : ""}${MoneyFormat.format(summary.netWorthDelta)}'),
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
            // MoneyFormat already carries the minus sign; only the plus is ours.
            '${value > 0 ? "+" : ""}${MoneyFormat.format(value)}',
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
