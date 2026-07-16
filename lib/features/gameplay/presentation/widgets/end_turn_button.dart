import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';

class EndTurnButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const EndTurnButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<EndTurnButton> createState() => _EndTurnButtonState();
}

class _EndTurnButtonState extends State<EndTurnButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    final translation = (_isPressed && !isDisabled)
        ? const Offset(4.0, 6.0)
        : Offset.zero;

    final shadowOffset = (!isDisabled && !_isPressed)
        ? const Offset(4.0, 6.0)
        : Offset.zero;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        transform: Matrix4.translationValues(translation.dx, translation.dy, 0),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDisabled ? AppColors.disabledFill : AppColors.primary,
          border: Border.all(
            color: isDisabled ? AppColors.disabledInk : AppColors.ink,
            width: AppTokens.borderWidth,
          ),
          boxShadow: [
            if (!isDisabled && !_isPressed)
              BoxShadow(
                color: AppColors.shadowOnPrimary,
                offset: shadowOffset,
                blurRadius: 0,
                spreadRadius: 0,
              ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0), // Optical alignment
            child: Icon(
              Icons.play_arrow,
              size: 40,
              color: isDisabled ? AppColors.disabledInk : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}
