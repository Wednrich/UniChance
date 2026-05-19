import 'package:flutter/material.dart';

class DecorativeBackground extends StatelessWidget {
  const DecorativeBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final background = IgnorePointer(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(seconds: 7),
        curve: Curves.easeInOut,
        builder: (context, value, _) {
          return CustomPaint(
            painter: _BackgroundPainter(value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );

    if (child == null) {
      return background;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        background,
        SafeArea(top: false, bottom: false, child: child!),
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFF7FAFA),
    );

    final teal =
        Paint()..color = const Color(0xFF07848C).withValues(alpha: 0.055);
    final light =
        Paint()..color = const Color(0xFFE6F7F8).withValues(alpha: 0.75);
    final yellow =
        Paint()..color = const Color(0xFFFFD166).withValues(alpha: 0.12);
    final dot =
        Paint()..color = const Color(0xFF07848C).withValues(alpha: 0.10);

    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * (0.16 + progress * 0.015)),
      120,
      light,
    );
    canvas.drawCircle(
      Offset(size.width * 0.90, size.height * (0.22 - progress * 0.010)),
      150,
      teal,
    );
    canvas.drawCircle(
      Offset(size.width * 0.76, size.height * (0.78 + progress * 0.012)),
      110,
      yellow,
    );

    for (double x = 28; x < size.width; x += 44) {
      for (double y = 120; y < size.height; y += 44) {
        if ((x + y).round().isEven) {
          canvas.drawCircle(Offset(x, y), 1.2, dot);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
