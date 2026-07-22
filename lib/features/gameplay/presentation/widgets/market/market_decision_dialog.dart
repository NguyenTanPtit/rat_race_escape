import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/market/market_trade_dialog.dart';

/// Shown when auto-advance stops on a market move. Presents the situation
/// WITHOUT advice — hold / sell / buy are all the player's own call.
class MarketDecisionDialog extends StatelessWidget {
  final MarketStopInfo info;

  const MarketDecisionDialog({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isCrash = info.kind == MarketStopKind.crash;
    final pct = info.changePercent.toStringAsFixed(0);

    final title = isCrash
        ? '📉 ${info.className} sụt −$pct% từ đỉnh!'
        : '📈 ${info.className} tăng nóng +$pct% so với trung bình năm!';
    final body = isCrash
        ? 'Thị trường đang hoảng loạn, ai cũng bàn tán về việc bán tháo. Bạn làm gì?'
        : 'Ai cũng đang khoe lãi, báo chí gọi đây là "cơ hội đổi đời". Bạn làm gì?';

    void openTrade(bool isBuy) {
      final cubit = context.read<GameEngineCubit>();
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: MarketTradeDialog(
            classId: info.classId,
            className: info.className,
            isBuy: isBuy,
          ),
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: GameCard(
        fill: AppColors.cardFill,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: isCrash ? AppColors.stressHigh : AppColors.primaryDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(body, style: textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 28),
              GameButton(
                onPressed: () => openTrade(true),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text('Múc thêm 🤑',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GameButton(
                onPressed: () => openTrade(false),
                fill: AppColors.stressHigh,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text('Bán bớt 😱',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GameButton(
                onPressed: () => Navigator.of(context).pop(),
                fill: AppColors.disabledFill,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text('Gồng giữ 🧘',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
