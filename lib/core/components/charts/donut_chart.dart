import 'dart:math' as math;
import 'package:flutter/material.dart';

class PieSlice {
  final double value;
  final Color color;
  final String label;

  const PieSlice({
    required this.value,
    required this.color,
    required this.label,
  });
}

class DonutChart extends StatefulWidget {
  final List<PieSlice> slices;
  final double size;
  final double thickness;
  final double separatorWidth;
  final Color centerColor;
  final Color gapColor;
  final TextStyle labelStyle;
  final Duration duration;
  final Duration delay;

  const DonutChart({
    super.key,
    required this.slices,
    this.size = 220,
    this.thickness = 55,
    this.separatorWidth = 6,
    this.centerColor = Colors.white,
    this.gapColor = Colors.white,
    this.labelStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
  });

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward(from: 0);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DonutChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.slices != widget.slices ||
        oldWidget.duration != widget.duration ||
        oldWidget.delay != widget.delay) {
      _controller.duration = widget.duration;

      _controller.reset();

      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return CustomPaint(
            painter: _DonutPainter(
              slices: widget.slices,
              thickness: widget.thickness,
              separatorWidth: widget.separatorWidth,
              centerColor: widget.centerColor,
              gapColor: widget.gapColor,
              labelStyle: widget.labelStyle,
              animationValue: _animation.value,
            ),
          );
        },
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<PieSlice> slices;
  final double thickness;
  final double separatorWidth;
  final Color centerColor;
  final Color gapColor;
  final TextStyle labelStyle;
  final double animationValue;

  _DonutPainter({
    required this.slices,
    required this.thickness,
    required this.separatorWidth,
    required this.centerColor,
    required this.gapColor,
    required this.labelStyle,
    required this.animationValue,
  });

  Path _segmentPath({
    required Offset center,
    required double outerRadius,
    required double innerRadius,
    required double startAngle,
    required double sweepAngle,
  }) {
    final outerRect = Rect.fromCircle(center: center, radius: outerRadius);
    final innerRect = Rect.fromCircle(center: center, radius: innerRadius);

    return Path()
      ..addArc(outerRect, startAngle, sweepAngle)
      ..arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false)
      ..close();
  }

  void _drawSeparator(
    Canvas canvas,
    Offset center,
    double innerRadius,
    double outerRadius,
    double angle,
    Paint paint,
  ) {
    final p1 = Offset(
      center.dx + innerRadius * math.cos(angle),
      center.dy + innerRadius * math.sin(angle),
    );
    final p2 = Offset(
      center.dx + outerRadius * math.cos(angle),
      center.dy + outerRadius * math.sin(angle),
    );

    canvas.drawLine(p1, p2, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final total = slices.fold<double>(0, (sum, item) => sum + item.value);
    if (total <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2;
    final innerRadius = outerRadius - thickness;
    final labelRadius = innerRadius + (thickness / 2);

    final slicePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final separatorPaint = Paint()
      ..color = gapColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = separatorWidth
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;

    // Center hole
    canvas.drawCircle(center, innerRadius, Paint()..color = centerColor);

    // Track the dynamic starting position of each slice as they grow stacked together
    double currentStartAngle = -math.pi / 2;

    // List to keep track of individual visual milestones for separators and labels
    final List<double> actualStartAngles = [];
    final List<double> actualSweepAngles = [];

    // Single pass for calculating positions and drawing slices
    for (int i = 0; i < slices.length; i++) {
      final slice = slices[i];

      // Calculate the ultimate target sweep angle for this slice
      final targetSweep = (slice.value / total) * 2 * math.pi;

      // Scale THIS individual slice's sweep by the animation value
      final visibleSweep = targetSweep * animationValue;

      actualStartAngles.add(currentStartAngle);
      actualSweepAngles.add(visibleSweep);

      if (visibleSweep > 0) {
        slicePaint.color = slice.color;
        canvas.drawPath(
          _segmentPath(
            center: center,
            outerRadius: outerRadius,
            innerRadius: innerRadius,
            startAngle: currentStartAngle,
            sweepAngle: visibleSweep,
          ),
          slicePaint,
        );
      }

      // Crucial: The NEXT slice starts exactly where THIS animated slice ends
      currentStartAngle += visibleSweep;
    }

    // Draw separators dynamically trailing behind each growing slice
    if (animationValue > 0.01) {
      for (int i = 0; i < slices.length; i++) {
        // Draw separator at the starting boundary of each slice
        _drawSeparator(
          canvas,
          center,
          innerRadius,
          outerRadius,
          actualStartAngles[i],
          separatorPaint,
        );
      }

      // If the animation is not complete, draw a closing separator at the very edge of the stack
      if (animationValue < 0.99) {
        _drawSeparator(
          canvas,
          center,
          innerRadius,
          outerRadius,
          currentStartAngle,
          separatorPaint,
        );
      }
    }

    // Fade in or display text labels smoothly when nearing completion
    if (animationValue > 0.95) {
      for (int i = 0; i < slices.length; i++) {
        final midAngle = actualStartAngles[i] + (actualSweepAngles[i] / 2);

        final labelOffset = Offset(
          center.dx + labelRadius * math.cos(midAngle),
          center.dy + labelRadius * math.sin(midAngle),
        );

        final tp = TextPainter(
          text: TextSpan(text: slices[i].label, style: labelStyle),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )..layout();

        tp.paint(canvas, labelOffset - Offset(tp.width / 2, tp.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.slices != slices ||
        oldDelegate.thickness != thickness ||
        oldDelegate.separatorWidth != separatorWidth ||
        oldDelegate.centerColor != centerColor ||
        oldDelegate.gapColor != gapColor ||
        oldDelegate.labelStyle != labelStyle ||
        oldDelegate.animationValue != animationValue;
  }
}
