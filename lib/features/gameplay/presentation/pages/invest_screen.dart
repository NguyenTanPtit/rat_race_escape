import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/format/money_format.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/market_class_state.dart';
import '../cubit/game_engine_cubit.dart';
import '../cubit/game_engine_state.dart';
import '../widgets/common/game_button.dart';
import '../widgets/common/game_card.dart';
import '../widgets/market/market_sparkline.dart';
import '../widgets/market/market_trade_dialog.dart';

/// Investment screen: one card per market asset class with price, drawdown,
/// sparkline, current holding and buy/sell actions. Prices are the ONLY
/// market information shown — regimes stay hidden.
class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEngineCubit, GameEngineState>(
      builder: (context, state) {
        if (state is! GameEnginePlaying) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final gameState = state.gameState;
        final classes = gameState.market.values.toList();

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
                      Text('ĐẦU TƯ', style: AppTextStyles.h2),
                      const SizedBox(width: AppSpacing.s),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            MoneyFormat.format(gameState.cash),
                            style: AppTextStyles.h3.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: classes.isEmpty
                      ? const Center(
                          child: Text(
                            'Thị trường chưa mở ở kịch bản này',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                              AppSpacing.l, 0, AppSpacing.l, AppSpacing.xl),
                          itemCount: classes.length,
                          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.l),
                          itemBuilder: (context, index) => _MarketClassCard(
                            cls: classes[index],
                            gameState: gameState,
                            tradingEnabled: !state.isAutoAdvancing,
                          ),
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

class _MarketClassCard extends StatelessWidget {
  final MarketClassState cls;
  final GameState gameState;
  final bool tradingEnabled;

  const _MarketClassCard({
    required this.cls,
    required this.gameState,
    required this.tradingEnabled,
  });

  void _openTrade(BuildContext context, {required bool isBuy}) {
    final cubit = context.read<GameEngineCubit>();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: MarketTradeDialog(
          classId: cls.classId,
          className: cls.name,
          isBuy: isBuy,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final holding =
        gameState.assets.where((a) => a.marketClassId == cls.classId).firstOrNull;
    final holdingValue = holding == null ? 0.0 : gameState.assetMarketValue(holding);
    final profitPercent = (holding == null || holding.baseValue <= 0)
        ? 0.0
        : (holdingValue / holding.baseValue - 1) * 100;

    // Monthly move: current price vs previous entry in the trailing window.
    double? monthlyChangePercent;
    if (cls.recentPrices.length >= 2) {
      final prev = cls.recentPrices[cls.recentPrices.length - 2];
      if (prev > 0) monthlyChangePercent = (cls.price / prev - 1) * 100;
    }

    // Yield-on-price: what a buy at the CURRENT price earns per year.
    final effectiveYield = cls.config.annualYieldRate / cls.price;

    final drawdownPercent = cls.drawdown * 100;

    return GameCard(
      fill: AppColors.cardFill,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(cls.name, style: AppTextStyles.h3)),
                if (drawdownPercent >= 10)
                  _Badge(
                    text: '−${drawdownPercent.toStringAsFixed(0)}% từ đỉnh',
                    color: AppColors.stressHigh,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Giá: ${(cls.price * 100).toStringAsFixed(0)}% so với đầu kỳ',
                    style: AppTextStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (monthlyChangePercent != null)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.s),
                    child: Text(
                      '${monthlyChangePercent >= 0 ? "▲ +" : "▼ "}${monthlyChangePercent.toStringAsFixed(1)}%/tháng',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: monthlyChangePercent >= 0
                            ? AppColors.primaryDark
                            : AppColors.stressHigh,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            MarketSparkline(prices: cls.recentPrices),
            const SizedBox(height: AppSpacing.s),
            Text(
              'Thu nhập ~${cls.config.annualYieldRate.toStringAsFixed(1)}%/năm trên mệnh giá'
              ' • mua lúc này: ~${effectiveYield.toStringAsFixed(1)}%/năm',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.disabledInk),
            ),
            const Divider(height: AppSpacing.xl),
            if (holding != null) ...[
              Text(
                'Đang giữ: ${MoneyFormat.format(holdingValue)}'
                ' (vốn ${MoneyFormat.format(holding.baseValue)},'
                ' ${profitPercent >= 0 ? "+" : ""}${profitPercent.toStringAsFixed(1)}%)',
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                'Thu nhập thụ động: +${MoneyFormat.format(holding.monthlyPassiveIncome)}/tháng',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryDark),
              ),
            ] else
              Text(
                'Chưa sở hữu',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.disabledInk,
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: AppSpacing.m),
            Row(
              children: [
                Expanded(
                  child: GameButton(
                    onPressed: tradingEnabled ? () => _openTrade(context, isBuy: true) : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text('Mua',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: GameButton(
                    onPressed: (tradingEnabled && holding != null)
                        ? () => _openTrade(context, isBuy: false)
                        : null,
                    fill: AppColors.stressHigh,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text('Bán',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
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

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ink, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}
