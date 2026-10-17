import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CircularStockBadge extends StatefulWidget {
  final double size;

  const CircularStockBadge({
    super.key,
    this.size = 54,
  });

  @override
  State<CircularStockBadge> createState() => _CircularStockBadgeState();
}

class _CircularStockBadgeState extends State<CircularStockBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating outer circular text
          RotationTransition(
            turns: _rotationController,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: CircularTextStampPainter(
                text: 'AVAILABLE IN STOCK • NIKE AIR JORDAN • ',
              ),
            ),
          ),
          // Inner icon circle
          Container(
            width: widget.size * 0.52,
            height: widget.size * 0.52,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.skateboarding_rounded,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularTextStampPainter extends CustomPainter {
  final String text;

  CircularTextStampPainter({required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final textRadius = radius - 6;

    final angleStep = (2 * math.pi) / text.length;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final angle = (i * angleStep) - (math.pi / 2);

      final x = center.dx + (textRadius * math.cos(angle));
      final y = center.dy + (textRadius * math.sin(angle));

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + (math.pi / 2));

      final textSpan = TextSpan(
        text: char,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 6.8,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
