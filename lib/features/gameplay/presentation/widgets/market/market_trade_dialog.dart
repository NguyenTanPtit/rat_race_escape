import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/format/thousands_input_formatter.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_state.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';

/// Buy/Sell dialog for a market asset class. Amounts are in đồng (market
/// value); validation mirrors the usecases so errors surface before submit.
class MarketTradeDialog extends StatefulWidget {
  final String classId;
  final String className;
  final bool isBuy;

  const MarketTradeDialog({
    super.key,
    required this.classId,
    required this.className,
    required this.isBuy,
  });

  @override
  State<MarketTradeDialog> createState() => _MarketTradeDialogState();
}

class _MarketTradeDialogState extends State<MarketTradeDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSubmit(double cash, double holdingValue, double sellFeeRate) {
    final text = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.isEmpty) {
      setState(() => _errorText = 'Vui lòng nhập số tiền');
      return;
    }
    final double amount = double.tryParse(text) ?? 0;
    if (amount <= 0) {
      setState(() => _errorText = 'Số tiền phải lớn hơn 0');
      return;
    }
    if (widget.isBuy && amount > cash) {
      setState(() => _errorText = 'Không đủ tiền mặt (đang có ${MoneyFormat.format(cash)})');
      return;
    }
    if (!widget.isBuy && amount > holdingValue + 0.01) {
      setState(() => _errorText = 'Bạn chỉ đang giữ ${MoneyFormat.format(holdingValue)}');
      return;
    }

    final cubit = context.read<GameEngineCubit>();
    if (widget.isBuy) {
      cubit.buyMarketAsset(widget.classId, amount);
    } else {
      cubit.sellMarketAsset(widget.classId, amount);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<GameEngineCubit, GameEngineState>(
      builder: (context, state) {
        if (state is! GameEnginePlaying) return const SizedBox.shrink();
        final gameState = state.gameState;
        final holding = gameState.assets
            .where((a) => a.marketClassId == widget.classId)
            .firstOrNull;
        final holdingValue = holding == null ? 0.0 : gameState.assetMarketValue(holding);
        final feePercent = (gameState.assetSellFeeRate * 100).toStringAsFixed(0);

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
                    widget.isBuy
                        ? 'MUA ${widget.className.toUpperCase()}'
                        : 'BÁN ${widget.className.toUpperCase()}',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: widget.isBuy ? AppColors.primary : AppColors.stressHigh,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.isBuy
                        ? 'Tiền mặt hiện tại: ${MoneyFormat.format(gameState.cash)}'
                        : 'Đang giữ: ${MoneyFormat.format(holdingValue)}\nPhí bán: $feePercent% giá trị bán',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    inputFormatters: [ThousandsSeparatorInputFormatter()],
                    decoration: InputDecoration(
                      labelText: widget.isBuy ? 'Số tiền muốn mua' : 'Giá trị muốn bán',
                      errorText: _errorText,
                      errorMaxLines: 2,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
                      ),
                    ),
                    onChanged: (_) {
                      if (_errorText != null) setState(() => _errorText = null);
                    },
                    onSubmitted: (_) => _validateAndSubmit(
                        gameState.cash, holdingValue, gameState.assetSellFeeRate),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: GameButton(
                          onPressed: () => Navigator.of(context).pop(),
                          fill: AppColors.disabledFill,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text('Hủy',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GameButton(
                          onPressed: () => _validateAndSubmit(
                              gameState.cash, holdingValue, gameState.assetSellFeeRate),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text(widget.isBuy ? 'Mua' : 'Bán',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
