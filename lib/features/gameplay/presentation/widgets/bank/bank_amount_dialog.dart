import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rat_race_escape/core/format/money_format.dart';
import 'package:rat_race_escape/core/format/thousands_input_formatter.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/features/gameplay/presentation/cubit/game_engine_cubit.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_button.dart';
import 'package:rat_race_escape/features/gameplay/presentation/widgets/common/game_card.dart';

enum BankAction { deposit, withdraw, takeLoan, repay }

/// One amount-input dialog for all four bank moves. [maxAmount] mirrors the
/// usecase's own validation so errors surface before submitting.
class BankAmountDialog extends StatefulWidget {
  final BankAction action;
  final double maxAmount;
  final String? loanId; // required for BankAction.repay

  const BankAmountDialog({
    super.key,
    required this.action,
    required this.maxAmount,
    this.loanId,
  });

  @override
  State<BankAmountDialog> createState() => _BankAmountDialogState();
}

class _BankAmountDialogState extends State<BankAmountDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  String get _title => switch (widget.action) {
        BankAction.deposit => 'GỬI TIẾT KIỆM',
        BankAction.withdraw => 'RÚT TIẾT KIỆM',
        BankAction.takeLoan => 'VAY THẾ CHẤP',
        BankAction.repay => 'TRẢ NỢ',
      };

  String get _maxLabel => switch (widget.action) {
        BankAction.deposit => 'Tiền mặt hiện có',
        BankAction.withdraw => 'Số dư tiết kiệm',
        BankAction.takeLoan => 'Hạn mức còn lại',
        BankAction.repay => 'Có thể trả tối đa',
      };

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
    if (amount > widget.maxAmount + 0.01) {
      setState(() => _errorText =
          'Vượt mức cho phép — tối đa ${MoneyFormat.format(widget.maxAmount)}');
      return;
    }

    final cubit = context.read<GameEngineCubit>();
    switch (widget.action) {
      case BankAction.deposit:
        cubit.depositSavings(amount);
      case BankAction.withdraw:
        cubit.withdrawSavings(amount);
      case BankAction.takeLoan:
        cubit.takeBankLoan(amount);
      case BankAction.repay:
        cubit.payDebt(widget.loanId!, amount);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                _title,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '$_maxLabel: ${MoneyFormat.format(widget.maxAmount)}',
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
                  labelText: 'Số tiền',
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
                onSubmitted: (_) => _validateAndSubmit(),
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
                      onPressed: _validateAndSubmit,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text('Xác nhận',
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
      ),
    );
  }
}
