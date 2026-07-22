import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/format/thousands_input_formatter.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';

class LeisureDialog extends StatefulWidget {
  final int leisureReliefUsedThisMonth;
  final double currentCash;

  const LeisureDialog({
    super.key,
    required this.leisureReliefUsedThisMonth,
    required this.currentCash,
  });

  @override
  State<LeisureDialog> createState() => _LeisureDialogState();
}

class _LeisureDialogState extends State<LeisureDialog> {
  final TextEditingController _controller = TextEditingController();
  final int maxStressReliefPerMonth = 20;
  final double costPerStressPoint = 100000;
  
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
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

    if (amount > widget.currentCash) {
      setState(() => _errorText = 'Không đủ tiền mặt');
      return;
    }

    final int maxPointsLeft = maxStressReliefPerMonth - widget.leisureReliefUsedThisMonth;
    final double maxAmountAllowed = maxPointsLeft * costPerStressPoint;

    if (amount > maxAmountAllowed) {
      setState(() => _errorText = 'Tháng này chỉ có thể chi tối đa ${MoneyFormat.format(maxAmountAllowed)} để giảm stress');
      return;
    }

    context.read<GameEngineCubit>().spendOnLeisure(amount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final int maxPointsLeft = maxStressReliefPerMonth - widget.leisureReliefUsedThisMonth;

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
                'GIẢI TRÍ & XẢ STRESS',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '100.000đ = -1 Stress\nGiới hạn tháng này: còn giảm được tối đa $maxPointsLeft điểm',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  ThousandsSeparatorInputFormatter(),
                ],
                decoration: InputDecoration(
                  labelText: 'Số tiền muốn chi',
                  errorText: _errorText,
                  errorMaxLines: 2,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
                  ),
                ),
                onChanged: (_) {
                  if (_errorText != null) {
                    setState(() => _errorText = null);
                  }
                },
                onSubmitted: (_) => _validateAndSubmit(),
              ),
              const SizedBox(height: 12),
              Text(
                'Tiền mặt hiện tại: ${MoneyFormat.format(widget.currentCash)}',
                style: textTheme.bodySmall?.copyWith(color: AppColors.ink),
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
                          child: Text('Hủy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GameButton(
                      onPressed: _validateAndSubmit,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text('Xác nhận', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
  }
}
