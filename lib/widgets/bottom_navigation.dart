import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import '../theme/app_theme.dart';

class LuxuryBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onSearchPressed;

  const LuxuryBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 94 + bottomPadding,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: bottomPadding > 0 ? bottomPadding : 10,
            ),
            child: GlassContainer(
              useOwnLayer: true,
              height: 72,
              shape: const LiquidRoundedSuperellipse(borderRadius: 28),
              settings: const LiquidGlassSettings(
                thickness: 28,
                blur: 16,
                glassColor: Color(0xEE0F0F12), // Deep dark luxury liquid glass
                refractiveIndex: 1.48,
                specularSharpness: GlassSpecularSharpness.sharp,
                lightIntensity: 0.6,
                ambientStrength: 0.15,
                saturation: 1.4,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      index: 0,
                      icon: Icons.home_rounded,
                      isActive: selectedIndex == 0,
                    ),
                    _buildNavItem(
                      index: 1,
                      icon: Icons.grid_view_rounded,
                      isActive: selectedIndex == 1,
                    ),
                    // Gap for Center Liquid Glass Orb
                    const SizedBox(width: 58),
                    _buildNavItem(
                      index: 2,
                      icon: Icons.shopping_bag_outlined,
                      isActive: selectedIndex == 2,
                    ),
                    _buildNavItem(
                      index: 3,
                      icon: Icons.person_outline_rounded,
                      isActive: selectedIndex == 3,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Center Floating Mint Liquid Glass Action Button
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onSearchPressed,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mint.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const GlassContainer(
                  useOwnLayer: true,
                  width: 58,
                  height: 58,
                  shape: LiquidOval(),
                  settings: LiquidGlassSettings(
                    thickness: 30,
                    blur: 12,
                    glassColor: Color(0xE863D6C4), // Mint/teal liquid glass
                    refractiveIndex: 1.55,
                    specularSharpness: GlassSpecularSharpness.sharp,
                    lightIntensity: 0.85,
                    glowIntensity: 0.9,
                    saturation: 1.6,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required bool isActive,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onItemSelected(index),
      child: SizedBox(
        width: 48,
        height: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? Colors.white : const Color(0xFF757580),
            ),
            const SizedBox(height: 4),
            // Yellow indicator dot beneath selected item
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 5 : 0,
              height: isActive ? 5 : 0,
              decoration: const BoxDecoration(
                color: AppColors.goldYellow,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
