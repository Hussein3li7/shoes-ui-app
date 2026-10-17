import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/sneaker.dart';
import '../theme/app_theme.dart';

class SneakerDisplay extends StatelessWidget {
  final Sneaker sneaker;
  final SneakerViewType viewType;
  final double width;
  final double height;
  final double rotationAngleDeg; // 0 to 360 for 360 viewer
  final double tiltAngle; // static display tilt
  final bool showFloatingShadow;
  final bool heroEnabled;
  final String? heroTag;
  final double verticalOffset;

  const SneakerDisplay({
    super.key,
    required this.sneaker,
    this.viewType = SneakerViewType.angle,
    this.width = 240,
    this.height = 180,
    this.rotationAngleDeg = 0,
    this.tiltAngle = -0.26, // approx -15 degrees
    this.showFloatingShadow = true,
    this.heroEnabled = false,
    this.heroTag,
    this.verticalOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = sneaker.imageAngles[viewType] ?? sneaker.primaryImageUrl;

    // Calculate dynamic 3D rotation transform based on rotationAngleDeg
    final rad = (rotationAngleDeg * math.pi) / 180.0;
    final sinFactor = math.sin(rad);
    final cosFactor = math.cos(rad);

    Widget sneakerContent = Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Realistic soft contact shadow beneath the floating sneaker
        if (showFloatingShadow)
          Positioned(
            bottom: 4,
            child: Container(
              width: width * 0.72,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 18,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),

        // Floating sneaker with 3D tilt & perspective
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0012)
            ..rotateZ(tiltAngle + (sinFactor * 0.08))
            ..rotateY(sinFactor * 0.45)
            ..scaleByDouble(
              1.0 - (cosFactor.abs() * 0.06),
              1.0 - (cosFactor.abs() * 0.06),
              1.0 - (cosFactor.abs() * 0.06),
              1.0,
            ),
          child: imageUrl.startsWith('http')
              ? Image.network(
                  imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return _buildVectorFallback(width, height);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _buildVectorFallback(width, height);
                  },
                )
              : Image.asset(
                  imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildVectorFallback(width, height);
                  },
                ),
        ),
      ],
    );

    if (verticalOffset != 0.0) {
      sneakerContent = Transform.translate(
        offset: Offset(0, verticalOffset),
        child: sneakerContent,
      );
    }

    if (heroTag != null || heroEnabled) {
      final effectiveTag = heroTag ?? 'sneaker_${sneaker.id}';
      return Hero(
        tag: effectiveTag,
        child: Material(
          type: MaterialType.transparency,
          child: sneakerContent,
        ),
      );
    }

    return sneakerContent;
  }

  Widget _buildVectorFallback(double w, double h) {
    return SizedBox(
      width: w,
      height: h,
      child: CustomPaint(
        painter: LuxurySneakerPainter(
          accentColor: sneaker.backgroundColor == AppColors.pastelMint
              ? AppColors.mint
              : (sneaker.backgroundColor == AppColors.pastelLavender
                  ? AppColors.deepPurple
                  : AppColors.orangePrice),
          viewType: viewType,
        ),
      ),
    );
  }
}

class LuxurySneakerPainter extends CustomPainter {
  final Color accentColor;
  final SneakerViewType viewType;

  LuxurySneakerPainter({
    required this.accentColor,
    required this.viewType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw stylized silhouette sneaker profile
    final solePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final soleOutline = Paint()
      ..color = const Color(0xFFD4D4DC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final upperPaint = Paint()
      ..color = const Color(0xFFF7F7FA)
      ..style = PaintingStyle.fill;

    final overlayPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final swooshPaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.fill;

    // Sole path
    final solePath = Path();
    solePath.moveTo(w * 0.12, h * 0.78);
    solePath.quadraticBezierTo(w * 0.45, h * 0.74, w * 0.88, h * 0.75);
    solePath.quadraticBezierTo(w * 0.94, h * 0.77, w * 0.92, h * 0.86);
    solePath.lineTo(w * 0.14, h * 0.86);
    solePath.quadraticBezierTo(w * 0.08, h * 0.82, w * 0.12, h * 0.78);
    solePath.close();

    canvas.drawPath(solePath, solePaint);
    canvas.drawPath(solePath, soleOutline);

    // Upper body path
    final upperPath = Path();
    upperPath.moveTo(w * 0.12, h * 0.78);
    upperPath.quadraticBezierTo(w * 0.15, h * 0.48, w * 0.28, h * 0.32);
    upperPath.quadraticBezierTo(w * 0.36, h * 0.24, w * 0.44, h * 0.34);
    upperPath.quadraticBezierTo(w * 0.58, h * 0.52, w * 0.78, h * 0.58);
    upperPath.quadraticBezierTo(w * 0.92, h * 0.62, w * 0.88, h * 0.75);
    upperPath.quadraticBezierTo(w * 0.45, h * 0.74, w * 0.12, h * 0.78);
    upperPath.close();

    canvas.drawPath(upperPath, upperPaint);

    // Accent collar / heel cup
    final accentPath = Path();
    accentPath.moveTo(w * 0.14, h * 0.76);
    accentPath.quadraticBezierTo(w * 0.16, h * 0.52, w * 0.26, h * 0.36);
    accentPath.lineTo(w * 0.35, h * 0.42);
    accentPath.quadraticBezierTo(w * 0.24, h * 0.64, w * 0.38, h * 0.76);
    accentPath.close();

    canvas.drawPath(accentPath, overlayPaint);

    // Dynamic Nike-style Swoosh
    final swooshPath = Path();
    swooshPath.moveTo(w * 0.25, h * 0.58);
    swooshPath.quadraticBezierTo(w * 0.48, h * 0.65, w * 0.72, h * 0.48);
    swooshPath.quadraticBezierTo(w * 0.56, h * 0.72, w * 0.36, h * 0.64);
    swooshPath.close();

    canvas.drawPath(swooshPath, swooshPaint);

    // Laces
    final lacePaint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 4; i++) {
      final yOffset = h * 0.38 + (i * 8);
      final xOffset = w * 0.36 + (i * 9);
      canvas.drawLine(
        Offset(xOffset, yOffset),
        Offset(xOffset + 12, yOffset + 4),
        lacePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant LuxurySneakerPainter oldDelegate) {
    return oldDelegate.accentColor != accentColor ||
        oldDelegate.viewType != viewType;
  }
}
