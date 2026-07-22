import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/format/money_format.dart';
import '../cubit/game_engine_state.dart';
import 'game_card.dart';
import 'game_button.dart';

class YearlyRecapDialog extends StatelessWidget {
  final YearlyRecap recap;
  const YearlyRecapDialog({
    super.key,
    required this.recap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: GameCard(
        fill: AppColors.cardFill,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'TỔNG KẾT NĂM',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Block 1: Income vs Expense
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryBox(
                      'Tổng thu',
                      recap.totalCashIn,
                      AppColors.primary,
                      textTheme,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryBox(
                      'Tổng chi',
                      recap.totalCashOut,
                      Colors.red,
                      textTheme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Block 2: Top Events
              Text(
                'Sự kiện nổi bật',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              if (recap.topEvents.isEmpty)
                const Text('Năm qua trôi qua yên bình, không có biến cố lớn.')
              else
                ...recap.topEvents.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          e.eventId ?? 'Sự kiện',
                          style: textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        MoneyFormat.format(e.cashDelta),
                        style: textTheme.bodyMedium?.copyWith(
                          color: e.cashDelta >= 0 ? AppColors.primary : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
              const SizedBox(height: 24),

              // Block 3: Net Worth Chart
              Text(
                'Biến động tài sản (12 tháng)',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: CustomPaint(
                  painter: _NetWorthChartPainter(
                    history: recap.fullHistory,
                    inkColor: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              GameButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text('Ăn Tết', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildSummaryBox(String title, double amount, Color color, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(title, style: textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            MoneyFormat.format(amount),
            style: textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _NetWorthChartPainter extends CustomPainter {
  final List<MonthlyHistoryRecord> history;
  final Color inkColor;

  _NetWorthChartPainter({required this.history, required this.inkColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (history.isEmpty) return;

    final paint = Paint()
      ..color = inkColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final double minNw = history.map((e) => e.netWorth).reduce((a, b) => a < b ? a : b);
    final double maxNw = history.map((e) => e.netWorth).reduce((a, b) => a > b ? a : b);
    
    final range = maxNw - minNw == 0 ? 1 : maxNw - minNw; // Avoid division by zero
    
    final path = Path();
    for (int i = 0; i < history.length; i++) {
      final x = size.width * (i / (history.length - 1 > 0 ? history.length - 1 : 1));
      final normalizedY = (history[i].netWorth - minNw) / range;
      final y = size.height - (normalizedY * size.height);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NetWorthChartPainter oldDelegate) {
    return oldDelegate.history != history;
  }
}
