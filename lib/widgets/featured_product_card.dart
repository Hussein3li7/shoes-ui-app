import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sneaker.dart';
import '../theme/app_theme.dart';
import 'sneaker_display.dart';

class FeaturedProductCard extends StatelessWidget {
  final Sneaker sneaker;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const FeaturedProductCard({
    super.key,
    required this.sneaker,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        height: 285,
        margin: const EdgeInsets.only(right: 18, top: 12, bottom: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Card base container
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: sneaker.backgroundColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: sneaker.backgroundColor.withValues(alpha: 0.6),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top brand / model label
                    Text(
                      sneaker.brand.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary.withValues(alpha: 0.4),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sneaker.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Spacer(),
                    // Bottom Section: Price & Discount
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                sneaker.formattedPrice,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                sneaker.discountTag,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Circular "+" button
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.darkNav,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.darkNav.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Large subtle faded watermark text behind sneaker
            Positioned(
              top: 85,
              left: 14,
              right: 14,
              child: IgnorePointer(
                child: Text(
                  sneaker.watermark,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: Colors.black.withValues(alpha: 0.045),
                  ),
                ),
              ),
            ),

            // Floating sneaker positioned more toward bottom to clearly show product name
            Positioned(
              top: 68,
              left: -12,
              right: -18,
              child: SneakerDisplay(
                sneaker: sneaker,
                width: 220,
                height: 145,
                tiltAngle: -0.22,
                showFloatingShadow: true,
                heroTag: 'sneaker_${sneaker.id}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
