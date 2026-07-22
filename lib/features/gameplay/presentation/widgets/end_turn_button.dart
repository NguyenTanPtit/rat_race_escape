import 'package:flutter/material.dart';
import 'package:rat_race_escape/core/theme/app_colors.dart';
import 'package:rat_race_escape/core/theme/app_tokens.dart';
class EndTurnButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressUp;
  final bool isAutoAdvancing;

  const EndTurnButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onLongPressUp,
    this.isAutoAdvancing = false,
  });

  @override
  State<EndTurnButton> createState() => _EndTurnButtonState();
}

class _EndTurnButtonState extends State<EndTurnButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _glowAnimation = Tween<double>(begin: 0.2, end: 0.8).animate(CurvedAnimation(parent: _glowController, curve: Curves.easeInOut));
    if (widget.isAutoAdvancing) _glowController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant EndTurnButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAutoAdvancing != oldWidget.isAutoAdvancing) {
      if (widget.isAutoAdvancing) {
        _glowController.repeat(reverse: true);
      } else {
        _glowController.stop();
      }
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

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

  void _handleLongPress() {
    if (widget.onLongPress == null) return;
    setState(() => _isPressed = false);
    widget.onLongPress?.call();
  }

  void _handleLongPressUp() {
    if (widget.onLongPressUp == null) return;
    widget.onLongPressUp?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    final translation = (_isPressed && !isDisabled) || widget.isAutoAdvancing
        ? const Offset(4.0, 6.0)
        : Offset.zero;

    final shadowOffset = (!isDisabled && !_isPressed && !widget.isAutoAdvancing)
        ? const Offset(4.0, 6.0)
        : Offset.zero;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onLongPress: _handleLongPress,
      onLongPressUp: _handleLongPressUp,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return AnimatedContainer(
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
                if (!isDisabled && !_isPressed && !widget.isAutoAdvancing)
                  BoxShadow(
                    color: AppColors.shadowOnPrimary,
                    offset: shadowOffset,
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                if (widget.isAutoAdvancing)
                  BoxShadow(
                    color: Colors.white.withValues(alpha: _glowAnimation.value),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: widget.isAutoAdvancing ? 0 : 4.0), // Optical alignment
                child: Icon(
                  widget.isAutoAdvancing ? Icons.fast_forward_rounded : Icons.play_arrow,
                  size: 40,
                  color: isDisabled ? AppColors.disabledInk : AppColors.ink,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
