import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';

/// A neo-brutalist card with a hand-drawn ("sketchy") border.
///
/// The border path is built from anchor points that are each jittered
/// exactly once and then reused, so every segment agrees on where it
/// starts and ends. This guarantees a closed, seam-free outline.
/// Bezier control points are free to re-jitter: they only bend the
/// curve and can never create a gap or a spike.
class SketchyGameCard extends StatelessWidget {
  final Widget child;
  final Color fill;
  final Color shadowColor;
  final int seed;

  const SketchyGameCard({
    super.key,
    required this.child,
    this.fill = AppColors.cardFill,
    this.shadowColor = AppColors.shadowVariantInk,
    this.seed = 42,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SketchyBorderPainter(
        fill: fill,
        shadowColor: shadowColor,
        seed: seed,
      ),
      child: Padding(
        // Keep the child clear of the jitter band, the stroke and the shadow.
        padding: const EdgeInsets.fromLTRB(
          _SketchyBorderPainter.inset,
          _SketchyBorderPainter.inset,
          _SketchyBorderPainter.inset + AppTokens.shadowOffsetX,
          _SketchyBorderPainter.inset + AppTokens.shadowOffsetY,
        ),
        child: child,
      ),
    );
  }
}

class _SketchyBorderPainter extends CustomPainter {
  final Color fill;
  final Color shadowColor;
  final int seed;

  _SketchyBorderPainter({
    required this.fill,
    required this.shadowColor,
    required this.seed,
  });

  static const double maxJitter = 2.0;

  /// Space reserved on every side so that jitter + half the stroke width
  /// can never escape the canvas.
  static const double inset = maxJitter + AppTokens.borderWidth / 2;

  @override
  void paint(Canvas canvas, Size size) {
    // Stable seed: same widget + same size -> same shape on every repaint.
    final rand = Random(seed ^ size.width.toInt() ^ size.height.toInt());

    /// Jitter delta in [-maxJitter, +maxJitter]. Each call draws a new value,
    /// so a delta must be sampled ONCE per anchor point and stored.
    double jd() => (rand.nextDouble() * 2 - 1) * maxJitter;

    // Base rectangle, deflated so jitter/stroke stay inside the canvas and
    // the right/bottom edges leave room for the hard shadow.
    final double left = inset;
    final double top = inset;
    final double right = size.width - inset - AppTokens.shadowOffsetX;
    final double bottom = size.height - inset - AppTokens.shadowOffsetY;

    // Corner radii: each corner slightly different, clamped so two corners
    // on the same edge can never overlap on small cards.
    final double maxRadius =
        min((right - left) / 2, (bottom - top) / 2) - maxJitter;
    double radius() =>
        (AppTokens.cardRadius + jd() * 2).clamp(10.0, max(10.0, maxRadius));

    final double rTL = radius();
    final double rTR = radius();
    final double rBR = radius();
    final double rBL = radius();

    // ---- Anchor points: jittered ONCE, then reused. -----------------------
    // a<Edge><NearCorner>, e.g. aTopLeft = point on the TOP edge next to the
    // top-left corner. Perpendicular jitter only, so edges wobble but the
    // path stays ordered.
    final Offset aLeftTop = Offset(left + jd(), top + rTL); // start point
    final Offset aTopLeft = Offset(left + rTL, top + jd());
    final Offset aTopRight = Offset(right - rTR, top + jd());
    final Offset aRightTop = Offset(right + jd(), top + rTR);
    final Offset aRightBottom = Offset(right + jd(), bottom - rBR);
    final Offset aBottomRight = Offset(right - rBR, bottom + jd());
    final Offset aBottomLeft = Offset(left + rBL, bottom + jd());
    final Offset aLeftBottom = Offset(left + jd(), bottom - rBL);

    final Path path = Path()
      ..moveTo(aLeftTop.dx, aLeftTop.dy)
    // Top-left corner.
      ..quadraticBezierTo(left + jd(), top + jd(), aTopLeft.dx, aTopLeft.dy)
    // Top edge.
      ..lineTo(aTopRight.dx, aTopRight.dy)
    // Top-right corner.
      ..quadraticBezierTo(right + jd(), top + jd(), aRightTop.dx, aRightTop.dy)
    // Right edge.
      ..lineTo(aRightBottom.dx, aRightBottom.dy)
    // Bottom-right corner.
      ..quadraticBezierTo(
          right + jd(), bottom + jd(), aBottomRight.dx, aBottomRight.dy)
    // Bottom edge.
      ..lineTo(aBottomLeft.dx, aBottomLeft.dy)
    // Bottom-left corner.
      ..quadraticBezierTo(
          left + jd(), bottom + jd(), aLeftBottom.dx, aLeftBottom.dy)
    // Left edge: close() joins aLeftBottom back to aLeftTop with a single
    // straight segment -- seam-free because both endpoints are shared.
      ..close();

    // 1. Shadow: the SAME path shifted, so it hugs the wobbly outline.
    final Paint shadowPaint = Paint()
      ..color = shadowColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(
      path.shift(const Offset(AppTokens.shadowOffsetX, AppTokens.shadowOffsetY)),
      shadowPaint,
    );

    // 2. Fill.
    final Paint fillPaint = Paint()
      ..color = fill
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Border. Round joins/caps soften the anchor "kinks" into a
    // hand-drawn look instead of sharp spikes.
    final Paint borderPaint = Paint()
      ..color = AppColors.ink
      ..strokeWidth = AppTokens.borderWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _SketchyBorderPainter oldDelegate) {
    return oldDelegate.fill != fill ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.seed != seed;
  }
}