import 'dart:math' as math;
import 'package:flutter/material.dart';

class SimpleGradientDonut extends StatelessWidget {
  final double size;
  final List<Color> colors;
  final double strokeWidth;
  const SimpleGradientDonut({
    super.key,
    this.size = 16,
    this.colors = const [
      Colors.pink,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ],
    this.strokeWidth = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DonutPainter(colors: colors, strokeWidth: strokeWidth),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;
  _DonutPainter({required this.colors, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(colors: colors).createShader(rect);

    canvas.drawArc(
      Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: size.width / 2 - strokeWidth / 2,
      ),
      -math.pi / 2,
      math.pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
