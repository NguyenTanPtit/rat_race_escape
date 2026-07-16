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

class MainGameScreen extends StatelessWidget {
  const MainGameScreen({super.key});

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
          if (state.monthlySummary != null) {
            // Show monthly summary dialog
            _showMonthlySummary(context, state.monthlySummary!);
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
                  EventCard(event: state.currentEvent!),
                if (hasEvent) const SizedBox(height: AppSpacing.l),

                // Cashflows
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

                // Leisure Button
                ElevatedButton(
                  onPressed: () {
                    // Show leisure dialog
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
              onPressed: hasEvent ? null : () => context.read<GameEngineCubit>().nextMonth(),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const BottomNav(),
        );
      },
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
