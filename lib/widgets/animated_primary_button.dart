import 'package:flutter/material.dart';

class AnimatedPrimaryButton extends StatefulWidget {
  const AnimatedPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.secondary = false,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool secondary;
  final bool compact;

  @override
  State<AnimatedPrimaryButton> createState() => _AnimatedPrimaryButtonState();
}

class _AnimatedPrimaryButtonState extends State<AnimatedPrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final background =
        widget.secondary ? Colors.white : const Color(0xFF07848C);
    final foreground =
        widget.secondary ? const Color(0xFF07848C) : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.025 : 1,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow:
                widget.secondary
                    ? []
                    : [
                      BoxShadow(
                        color: const Color(
                          0xFF07848C,
                        ).withValues(alpha: _hovered ? 0.28 : 0.16),
                        blurRadius: _hovered ? 22 : 14,
                        offset: Offset(0, _hovered ? 12 : 8),
                      ),
                    ],
          ),
          child: FilledButton.icon(
            onPressed: widget.onPressed,
            icon:
                widget.icon == null
                    ? const SizedBox.shrink()
                    : Icon(widget.icon, size: 18),
            label: Text(widget.label),
            style: FilledButton.styleFrom(
              elevation: 0,
              backgroundColor:
                  widget.secondary && _hovered
                      ? const Color(0xFFE6F7F8)
                      : background,
              foregroundColor: foreground,
              side:
                  widget.secondary
                      ? const BorderSide(color: Color(0xFFE2E8F0))
                      : BorderSide.none,
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? 16 : 22,
                vertical: widget.compact ? 13 : 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
