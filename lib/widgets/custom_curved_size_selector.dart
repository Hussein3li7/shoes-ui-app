import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CurvedSizeArcSelector extends StatefulWidget {
  final List<int> sizes;
  final int selectedSize;
  final ValueChanged<int> onSizeSelected;

  const CurvedSizeArcSelector({
    super.key,
    this.sizes = const [25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38],
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  State<CurvedSizeArcSelector> createState() => _CurvedSizeArcSelectorState();
}

class _CurvedSizeArcSelectorState extends State<CurvedSizeArcSelector>
    with SingleTickerProviderStateMixin {
  static const double _itemSpacing = 56.0;
  static const double _totalHeight = 110.0;

  late AnimationController _snapController;
  Animation<double>? _snapAnimation;
  late double _currentOffset;
  late int _centerIndex;

  @override
  void initState() {
    super.initState();
    _centerIndex = _getInitialIndex();
    _currentOffset = _centerIndex * _itemSpacing;

    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    )..addListener(() {
        if (_snapAnimation != null) {
          setState(() {
            _currentOffset = _snapAnimation!.value;
            _updateCenterIndex();
          });
        }
      });
  }

  int _getInitialIndex() {
    final idx = widget.sizes.indexOf(widget.selectedSize);
    return idx != -1 ? idx : (widget.sizes.length ~/ 2);
  }

  @override
  void didUpdateWidget(covariant CurvedSizeArcSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedSize != widget.selectedSize) {
      final targetIdx = widget.sizes.indexOf(widget.selectedSize);
      if (targetIdx != -1 && targetIdx != _centerIndex) {
        _animateToIndex(targetIdx);
      }
    }
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _updateCenterIndex() {
    final newCenter =
        (_currentOffset / _itemSpacing).round().clamp(0, widget.sizes.length - 1);
    if (newCenter != _centerIndex) {
      _centerIndex = newCenter;
      widget.onSizeSelected(widget.sizes[_centerIndex]);
    }
  }

  void _animateToIndex(int targetIndex) {
    final clampedTarget = targetIndex.clamp(0, widget.sizes.length - 1);
    final targetOffset = clampedTarget * _itemSpacing;

    _snapAnimation = Tween<double>(
      begin: _currentOffset,
      end: targetOffset,
    ).animate(
      CurvedAnimation(
        parent: _snapController,
        curve: Curves.easeOutCubic,
      ),
    );

    _snapController.forward(from: 0.0).then((_) {
      _centerIndex = clampedTarget;
      widget.onSizeSelected(widget.sizes[_centerIndex]);
    });
  }

  void _onDragStart(DragStartDetails details) {
    _snapController.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentOffset -= details.delta.dx;
      // Clamp with a small elastic bounce limit
      final maxOffset = (widget.sizes.length - 1) * _itemSpacing;
      _currentOffset = _currentOffset.clamp(-20.0, maxOffset + 20.0);
      _updateCenterIndex();
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    int targetIndex;

    if (velocity.abs() > 250) {
      // Swiping with velocity: move towards fling direction
      if (velocity < 0) {
        targetIndex = _centerIndex + 1;
      } else {
        targetIndex = _centerIndex - 1;
      }
    } else {
      targetIndex = (_currentOffset / _itemSpacing).round();
    }

    _animateToIndex(targetIndex);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final halfWidth = totalWidth / 2;
        final curveFactor = totalWidth * 0.42;

        return SizedBox(
          width: totalWidth,
          height: _totalHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Upward curved guide arc
                CustomPaint(
                  size: Size(totalWidth, _totalHeight),
                  painter: ArcCurvePainter(),
                ),

                // Scrollable items positioned dynamically along the curve
                ...List.generate(widget.sizes.length, (index) {
                  final sizeVal = widget.sizes[index];

                  // Horizontal distance relative to the center
                  final dx = (index * _itemSpacing) - _currentOffset;
                  final screenX = halfWidth + dx;

                  // Skip rendering items far off screen
                  if (screenX < -50 || screenX > totalWidth + 50) {
                    return const SizedBox.shrink();
                  }

                  // Curve calculation: peak is at center, drops off quadratically to edges
                  final t = dx / curveFactor;
                  final y = 20.0 + (t * t * 54.0);

                  // Normalized distance from center (0.0 = exactly centered)
                  final distFromCenter = (dx / _itemSpacing).abs();
                  final isClosestToCenter = distFromCenter < 0.5;

                  // Edge fade opacity for smooth carousel appearance
                  final edgeOpacity =
                      (1.0 - (dx.abs() / (halfWidth + 30))).clamp(0.0, 1.0);

                  if (isClosestToCenter) {
                    // Center Selected Size: Elevated white card, black dot, bold text & "SIZE"
                    final elevationFactor = (1.0 - (distFromCenter * 2)).clamp(0.0, 1.0);

                    return Positioned(
                      left: screenX - 28,
                      top: y - 10,
                      child: GestureDetector(
                        onTap: () => _animateToIndex(index),
                        child: Opacity(
                          opacity: edgeOpacity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Black dot above selected size
                              Container(
                                width: 5,
                                height: 5,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.textPrimary
                                      .withValues(alpha: elevationFactor),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              // Elevated white container
                              Container(
                                width: 56,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.08 * elevationFactor,
                                      ),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$sizeVal',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'SIZE',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textSecondary,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  // Non-center items along the curve
                  return Positioned(
                    left: screenX - 18,
                    top: y + 10,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _animateToIndex(index),
                      child: Opacity(
                        opacity: edgeOpacity,
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          child: Text(
                            '$sizeVal',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ArcCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Smooth upward curving arc path
    path.moveTo(w * 0.08, h * 0.76);
    path.quadraticBezierTo(w * 0.5, h * 0.22, w * 0.92, h * 0.76);

    final paint = Paint()
      ..color = const Color(0xFFEBEBF0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
