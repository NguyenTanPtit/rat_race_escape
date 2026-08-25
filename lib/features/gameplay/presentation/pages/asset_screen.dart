import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_spacing.dart';
import 'package:rat_race_escape/core/theme/app_text_styles.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/asset.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/game_state.dart';
import 'package:rat_race_escape/features/gameplay/domain/entities/loan.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';

/// Asset dashboard: where the player finally SEES the way out of the rat
/// race — progress toward the win, what the net worth is made of, this
/// month's cashflow, and the early warnings for every scripted death.
/// Read-only by design: actions stay on their own screens (Đầu tư/Ngân hàng).
class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEngineCubit, GameEngineState>(
      builder: (context, state) {
        if (state is! GameEnginePlaying) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final gameState = state.gameState;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Row(
                    children: [
                      GameButton(
                        onPressed: () => context.pop(),
                        fill: AppColors.cardFill,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back, color: AppColors.ink),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Text('TÀI SẢN', style: AppTextStyles.h2),
                      const SizedBox(width: AppSpacing.s),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            MoneyFormat.format(gameState.netWorth),
                            style: AppTextStyles.h3.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.l, 0, AppSpacing.l, AppSpacing.xl),
                    children: [
                      _ProgressCard(gameState: gameState),
                      const SizedBox(height: AppSpacing.l),
                      _NetWorthCard(gameState: gameState),
                      const SizedBox(height: AppSpacing.l),
                      _CashflowCard(gameState: gameState),
                      const SizedBox(height: AppSpacing.l),
                      _HealthCard(gameState: gameState),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Khối 1: tiến trình thoát vòng chuột đua
// ---------------------------------------------------------------------------

class _ProgressCard extends StatelessWidget {
  final GameState gameState;

  const _ProgressCard({required this.gameState});

  @override
  Widget build(BuildContext context) {
    final progress = gameState.passiveProgress;
    final percent = (progress * 100).clamp(0, 999).toStringAsFixed(0);
    final shortfall = gameState.totalMonthlyOutflow - gameState.passiveIncome;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🎯 Thoát vòng chuột đua', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.m),
            _MilestoneBar(progress: progress),
            const SizedBox(height: AppSpacing.m),
            Text(
              'Thu nhập thụ động ${MoneyFormat.format(gameState.passiveIncome)}'
              ' / chi phí ${MoneyFormat.format(gameState.totalMonthlyOutflow)}'
              ' — $percent%',
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            if (shortfall > 0)
              Text(
                'Còn thiếu ${MoneyFormat.format(shortfall)}/tháng để thắng.',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
              ),
            const SizedBox(height: 2),
            Text(
              'Khi cột này đầy, bạn thoát vòng chuột đua.',
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.disabledInk, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

/// Progress bar with tick marks at the 25/50/75 milestones the game already
/// celebrates via snackbars — here they become places on a visible road.
class _MilestoneBar extends StatelessWidget {
  final double progress;

  const _MilestoneBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return SizedBox(
      height: 22,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.navFill,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: AppColors.ink, width: 2),
                ),
              ),
              if (clamped > 0)
                Container(
                  width: (width * clamped).clamp(14.0, width),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: AppColors.ink, width: 2),
                  ),
                ),
              for (final m in const [0.25, 0.5, 0.75])
                Positioned(
                  left: width * m - 1,
                  top: 3,
                  bottom: 3,
                  child: Container(width: 2, color: AppColors.ink.withValues(alpha: 0.35)),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Khối 2: tài sản ròng gồm những gì
// ---------------------------------------------------------------------------

class _NetWorthCard extends StatelessWidget {
  final GameState gameState;

  const _NetWorthCard({required this.gameState});

  @override
  Widget build(BuildContext context) {
    final bankDebt = gameState.totalBankDebt;
    final otherDebt = gameState.loans
        .where((l) => l.type != LoanType.mortgage)
        .fold(0.0, (sum, l) => sum + l.principalAmount);
    final monthlyInterest =
        gameState.savingsBalance * gameState.savingsAnnualRate / 12;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('💰 Tài sản ròng', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            _MoneyRow(label: 'Tiền mặt', amount: gameState.cash),
            if (gameState.savingsBalance > 0)
              _MoneyRow(
                label: 'Tiết kiệm',
                amount: gameState.savingsBalance,
                note: monthlyInterest >= 1000
                    ? 'lãi ~+${MoneyFormat.format(monthlyInterest)}/tháng'
                    : null,
              ),
            for (final asset in gameState.assets) _HoldingRow(gameState: gameState, asset: asset),
            for (final p in gameState.pendingProceeds)
              _MoneyRow(
                label: 'Tiền bán đang về',
                amount: p.amount,
                note: 'còn ${p.monthsLeft} tháng — KHÔNG tiêu được',
              ),
            if (bankDebt > 0)
              _MoneyRow(label: 'Nợ ngân hàng', amount: -bankDebt),
            if (otherDebt > 0)
              _MoneyRow(label: 'Nợ khác (vay nóng, thẻ...)', amount: -otherDebt),
            const Divider(height: AppSpacing.l),
            Row(
              children: [
                Expanded(
                  child: Text('= Tài sản ròng',
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w900)),
                ),
                Text(
                  MoneyFormat.format(gameState.netWorth),
                  style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w900, color: AppColors.primaryDark),
                ),
              ],
            ),
            if (gameState.inflationIndex > 1.0) ...[
              const SizedBox(height: 2),
              Text(
                'Sức mua theo giá năm đầu: ${MoneyFormat.format(gameState.realNetWorth)}',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HoldingRow extends StatelessWidget {
  final GameState gameState;
  final Asset asset;

  const _HoldingRow({required this.gameState, required this.asset});

  @override
  Widget build(BuildContext context) {
    final value = gameState.assetMarketValue(asset);
    final gain = gameState.unrealizedGainRate(asset);
    final classState =
        asset.marketClassId == null ? null : gameState.market[asset.marketClassId];
    final settlement = classState?.config.settlementMonths ?? 0;

    final notes = <String>[
      if (asset.monthlyPassiveIncome > 0)
        '+${MoneyFormat.format(asset.monthlyPassiveIncome)}/tháng',
      if (classState != null)
        settlement == 0 ? 'bán là có tiền ngay' : 'bán xong T+$settlement tháng mới có tiền',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(child: Text(asset.name, style: AppTextStyles.bodyMedium)),
                    if (gain != null) ...[
                      const SizedBox(width: AppSpacing.s),
                      Text(
                        '${gain >= 0 ? '▲' : '▼'}${(gain.abs() * 100).toStringAsFixed(0)}%',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: gain >= 0 ? AppColors.primaryDark : AppColors.stressHigh,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                MoneyFormat.format(value),
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (notes.isNotEmpty)
            Text(
              notes.join(' • '),
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
            ),
        ],
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  final String label;
  final double amount;
  final String? note;

  const _MoneyRow({required this.label, required this.amount, this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
              const SizedBox(width: AppSpacing.s),
              Text(
                MoneyFormat.format(amount),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: amount < 0 ? AppColors.stressHigh : AppColors.ink,
                ),
              ),
            ],
          ),
          if (note != null)
            Text(note!,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Khối 3: dòng tiền tháng này (đúng công thức engine, không tính lại)
// ---------------------------------------------------------------------------

class _CashflowCard extends StatelessWidget {
  final GameState gameState;

  const _CashflowCard({required this.gameState});

  @override
  Widget build(BuildContext context) {
    final due = gameState.totalDueLoanPayment;
    final surplus = gameState.totalCashFlow - due;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📊 Dòng tiền tháng này', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            _MoneyRow(
              label: gameState.salarySuspendedMonths > 0
                  ? 'Lương (mất việc, còn ${gameState.salarySuspendedMonths} tháng)'
                  : 'Lương',
              amount: gameState.effectiveSalary,
            ),
            if (gameState.passiveIncome > 0)
              _MoneyRow(label: 'Thu nhập thụ động', amount: gameState.passiveIncome),
            _MoneyRow(label: 'Chi phí sống (đủ khoản)', amount: -gameState.totalMonthlyOutflow),
            if (due > 0)
              _MoneyRow(
                label: 'Trả nợ tối thiểu',
                amount: -due,
                note: 'trong đó lãi ${MoneyFormat.format(gameState.totalLoanInterest)}',
              ),
            const Divider(height: AppSpacing.l),
            Row(
              children: [
                Expanded(
                  child: Text(surplus >= 0 ? '= Thặng dư' : '= Thâm hụt',
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w900)),
                ),
                Text(
                  '${surplus > 0 ? '+' : ''}${MoneyFormat.format(surplus)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: surplus >= 0 ? AppColors.primaryDark : AppColors.stressHigh,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Khối 4: cảnh báo sức khỏe tài chính — chỉ hiện khi có chuyện
// ---------------------------------------------------------------------------

class _HealthCard extends StatelessWidget {
  final GameState gameState;

  const _HealthCard({required this.gameState});

  List<String> _warnings() {
    final warnings = <String>[];

    final months = gameState.emergencyFundMonths;
    if (months < 3) {
      warnings.add('Quỹ khẩn cấp: ${months.toStringAsFixed(1)} tháng'
          ' — một cú sốc y tế là phải bán tháo đáy.');
    }

    // Same condition as the engine's debt-crush bankruptcy — shown BEFORE it kills.
    if (gameState.totalDueLoanPayment > 0 &&
        gameState.totalDueLoanPayment > gameState.structuralSurplus) {
      warnings.add('Tiền trả nợ VƯỢT thặng dư hàng tháng — nợ chỉ có thể phình.'
          ' Đây là đường dẫn tới vỡ nợ.');
    }

    final cap = gameState.totalPortfolioValue * gameState.bankLoanMaxLtv;
    if (gameState.totalBankDebt > 0 && cap > 0 && gameState.totalBankDebt >= cap * 0.9) {
      final usedPercent = (gameState.totalBankDebt / cap * 100).toStringAsFixed(0);
      warnings.add('Đã dùng $usedPercent% hạn mức thế chấp'
          ' — giá tài sản giảm là ngân hàng siết.');
    }

    if (gameState.inflationAnnualRate > 0 &&
        gameState.cash > gameState.totalMonthlyOutflow * 3) {
      final yearlyLoss = gameState.cash *
          (gameState.inflationAnnualRate / (1 + gameState.inflationAnnualRate));
      warnings.add('${MoneyFormat.format(gameState.cash)} tiền mặt nằm im'
          ' — mỗi năm mất ~${MoneyFormat.format(yearlyLoss)} sức mua.');
    }

    return warnings;
  }

  @override
  Widget build(BuildContext context) {
    final warnings = _warnings();
    // No lecture when everything is fine — the mechanics teach, not the text.
    if (warnings.isEmpty) return const SizedBox.shrink();

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🚨 Sức khỏe tài chính', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.s),
            for (final w in warnings)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  '• $w',
                  style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.stressHigh, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
