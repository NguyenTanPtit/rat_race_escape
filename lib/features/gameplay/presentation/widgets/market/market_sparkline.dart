import 'package:flutter/material.dart';

import 'package:rat_race_escape/core/theme/app_colors.dart';

/// Tiny 12-month price sparkline for a market class.
class MarketSparkline extends StatelessWidget {
  final List<double> prices;
  final double height;

  const MarketSparkline({super.key, required this.prices, this.height = 44});

  @override
  Widget build(BuildContext context) {
    if (prices.length < 2) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'Chưa đủ dữ liệu giá',
            style: TextStyle(fontSize: 12, color: AppColors.disabledInk, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _SparklinePainter(prices)),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> prices;

  _SparklinePainter(this.prices);

  @override
  void paint(Canvas canvas, Size size) {
    final min = prices.reduce((a, b) => a < b ? a : b);
    final max = prices.reduce((a, b) => a > b ? a : b);
    final range = (max - min) < 1e-9 ? 1.0 : max - min;

    final points = <Offset>[];
    for (var i = 0; i < prices.length; i++) {
      final x = size.width * i / (prices.length - 1);
      final y = size.height - ((prices[i] - min) / range) * size.height;
      points.add(Offset(x, y));
    }

    final isUp = prices.last >= prices.first;
    final paint = Paint()
      ..color = isUp ? AppColors.primaryDark : AppColors.stressHigh
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, paint);

    // End dot
    canvas.drawCircle(points.last, 3.5, Paint()..color = paint.color);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) => oldDelegate.prices != prices;
}
