import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class BrandSelector extends StatelessWidget {
  final List<String> brands;
  final String selectedBrand;
  final ValueChanged<String> onBrandSelected;

  const BrandSelector({
    super.key,
    required this.brands,
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = brand.toLowerCase() == selectedBrand.toLowerCase();

          return GestureDetector(
            onTap: () => onBrandSelected(brand),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 22 : 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.darkNav : AppColors.secondarySurface,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? Colors.transparent : const Color(0xFFEEEEF2),
                  width: 1.2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.darkNav.withValues(alpha: 0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        )
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected && brand.toLowerCase() == 'nike') ...[
                    // Small yellow/orange Nike-style swoosh mark
                    Transform.rotate(
                      angle: -0.25,
                      child: const Icon(
                        Icons.check_rounded,
                        color: AppColors.goldYellow,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    brand,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
