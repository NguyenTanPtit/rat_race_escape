import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';

class GameButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color fill;
  final Color shadowColor;

  const GameButton({
    super.key,
    required this.child,
    this.onPressed,
    this.fill = AppColors.primary,
    this.shadowColor = AppColors.shadowVariantInk,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool _isPressed = false;

  bool get _isDisabled => widget.onPressed == null;

  void _handleTapDown(TapDownDetails details) {
    if (_isDisabled) return;
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isDisabled) return;
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (_isDisabled) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool showShadow = !_isPressed && !_isDisabled;
    final Color currentColor = _isDisabled ? AppColors.disabledFill : widget.fill;
    final Color currentBorderColor = _isDisabled ? AppColors.disabledInk : AppColors.ink;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        transform: Matrix4.translationValues(
          showShadow ? 0 : AppTokens.shadowOffset.dx,
          showShadow ? 0 : AppTokens.shadowOffset.dy,
          0,
        ),
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: AppTokens.borderRadius,
          border: Border.all(
            color: currentBorderColor,
            width: AppTokens.borderWidth,
          ),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: AppTokens.shadowOffset,
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
