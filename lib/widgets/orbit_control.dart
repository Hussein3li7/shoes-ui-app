import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class OrbitControl extends StatelessWidget {
  final double currentAngle; // 0.0 to 360.0
  final ValueChanged<double> onAngleChanged;

  const OrbitControl({
    super.key,
    required this.currentAngle,
    required this.onAngleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Dragging horizontally smoothly adjusts the angle
        double newAngle = (currentAngle + (details.delta.dx * 1.2)) % 360.0;
        if (newAngle < 0) newAngle += 360.0;
        onAngleChanged(newAngle);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Elliptical ring with black circular interactive handle
          SizedBox(
            width: 260,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Turquoise Ellipse
                CustomPaint(
                  size: const Size(260, 64),
                  painter: TurquoiseOrbitPainter(
                    angle: currentAngle,
                  ),
                ),

                // Center Black Handle with "< >"
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.darkNav,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkNav.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '< >',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Angle display: "306°"
          Text(
            '${currentAngle.toInt()}°',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class TurquoiseOrbitPainter extends CustomPainter {
  final double angle;

  TurquoiseOrbitPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width - 24,
      height: size.height - 18,
    );

    // Orbit ellipse ring paint
    final ringPaint = Paint()
      ..color = AppColors.mint.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawOval(rect, ringPaint);

    // Position of tracking indicator ball along the ellipse
    final rad = (angle * math.pi) / 180.0;
    final rx = rect.width / 2;
    final ry = rect.height / 2;
    final cx = rect.center.dx;
    final cy = rect.center.dy;

    final dotX = cx + (rx * math.cos(rad));
    final dotY = cy + (ry * math.sin(rad));

    final dotPaint = Paint()
      ..color = AppColors.mint
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = AppColors.mint.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawCircle(Offset(dotX, dotY), 6, glowPaint);
    canvas.drawCircle(Offset(dotX, dotY), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant TurquoiseOrbitPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
