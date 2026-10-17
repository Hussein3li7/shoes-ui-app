import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sneaker.dart';
import '../theme/app_theme.dart';
import 'sneaker_display.dart';

class PopularProductCard extends StatelessWidget {
  final Sneaker sneaker;
  final VoidCallback onTap;

  const PopularProductCard({
    super.key,
    required this.sneaker,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product image container (~68px) with pastel background
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: sneaker.backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Center(
                  child: SneakerDisplay(
                    sneaker: sneaker,
                    width: 78,
                    height: 58,
                    tiltAngle: -0.18,
                    showFloatingShadow: false,
                    heroTag: 'sneaker_${sneaker.id}',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Middle: Name & Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sneaker.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sneaker.formattedPrice,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // Right: Circular discount badge
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: sneaker.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${sneaker.discountPercent}%\nOFF',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
