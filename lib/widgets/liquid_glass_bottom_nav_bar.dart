import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Navigation item model for [LiquidGlassBottomNavigationBar].
class LiquidGlassNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final Color? glowColor;

  const LiquidGlassNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.glowColor,
  });
}

/// Premium Liquid Glass Bottom Navigation Bar
///
/// Designed specifically for light/white application backgrounds.
///
/// Visual direction:
/// - Neutral translucent glass
/// - Dark charcoal inactive icons
/// - Mint/teal active state
/// - Subtle shadow
/// - Minimal Apple-inspired appearance
class LiquidGlassBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  final ValueChanged<int> onTabSelected;

  final List<LiquidGlassNavItem>? customItems;

  final double barHeight;

  final double horizontalPadding;

  final double bottomMargin;

  final double borderRadius;

  /// Active color.
  ///
  /// Mint/teal is used to match the application's visual identity.
  final Color accentColor;

  /// Inactive icons are DARK because the application uses
  /// a white/light background.
  final Color unselectedColor;

  final GlassQuality quality;

  const LiquidGlassBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.customItems,
    this.barHeight = 68.0,
    this.horizontalPadding = 16.0,
    this.bottomMargin = 12.0,
    this.borderRadius = 32.0,

    // Murafaati / modern light UI accent.
    this.accentColor = const Color.fromARGB(255, 28, 140, 123),

    // IMPORTANT:
    // Do NOT use white here because the screen background is white.
    this.unselectedColor = const Color(0xFF202124),

    this.quality = GlassQuality.premium,
  });

  static const List<LiquidGlassNavItem> defaultItems = [
    LiquidGlassNavItem(
      label: 'Home',
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
    ),
    LiquidGlassNavItem(
      label: 'Search',
      icon: CupertinoIcons.search,
      activeIcon: CupertinoIcons.search,
    ),
    LiquidGlassNavItem(
      label: 'Library',
      icon: CupertinoIcons.square_stack_3d_up,
      activeIcon: CupertinoIcons.square_stack_3d_up_fill,
    ),
    LiquidGlassNavItem(
      label: 'Favorites',
      icon: CupertinoIcons.heart,
      activeIcon: CupertinoIcons.heart_fill,
    ),
    LiquidGlassNavItem(
      label: 'Profile',
      icon: CupertinoIcons.person,
      activeIcon: CupertinoIcons.person_fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = customItems ?? defaultItems;

    final tabs = items.map((item) {
      return GlassTab(
        icon: Icon(item.icon, color: unselectedColor),
        activeIcon: Icon(item.activeIcon ?? item.icon, color: accentColor),
        label: item.label,
        // glowColor: item.glowColor ?? accentColor.withValues(alpha: 0.22),
      );
    }).toList();

    final safeSelectedIndex = selectedIndex.clamp(0, tabs.length - 1);

    final indicatorTint = accentColor.withValues(alpha: 0.16);

    return GlassTabBar.bottom(
      tabs: tabs,

      selectedIndex: safeSelectedIndex,

      onTabSelected: onTabSelected,

      // ----------------------------------------------------------
      // SIZE
      // ----------------------------------------------------------
      barHeight: barHeight,

      barBorderRadius: borderRadius,

      horizontalPadding: horizontalPadding,

      verticalPadding: bottomMargin,

      spacing: 4,

      iconLabelSpacing: 3,

      iconSize: 21,

      labelFontSize: 10.5,

      // ----------------------------------------------------------
      // INDICATOR
      // ----------------------------------------------------------
      showIndicator: true,

      indicatorColor: indicatorTint,

      magnification: 1.10,

      indicatorPinchStrength: 0.28,

      // ----------------------------------------------------------
      // ICON COLORS
      // ----------------------------------------------------------

      // ACTIVE
      selectedIconColor: accentColor,

      // IMPORTANT:
      // Dark icons instead of white.
      unselectedIconColor: unselectedColor,

      // ----------------------------------------------------------
      // LABEL COLORS
      // ----------------------------------------------------------
      selectedLabelColor: accentColor,

      // Dark grey instead of translucent white.
      unselectedLabelColor: unselectedColor.withValues(alpha: 0.72),

      // ----------------------------------------------------------
      // GLOW
      // ----------------------------------------------------------
      glowBlurRadius: 20,

      glowSpreadRadius: 2,

      glowOpacity: 0.20,

      // ----------------------------------------------------------
      // TYPOGRAPHY
      // ----------------------------------------------------------
      selectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
        color: accentColor,
      ),

      unselectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 10.5,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.1,
        color: unselectedColor,
      ),

      // ----------------------------------------------------------
      // MAIN GLASS
      // ----------------------------------------------------------
      settings: LiquidGlassSettings(
        thickness: 20,
        blur: 5,
        refractiveIndex: 1.2,
        chromaticAberration: 0.01,
        lightAngle: GlassDefaults.lightAngle,
        lightIntensity: 0.5,
        ambientStrength: 0.0,
        saturation: 1.5,
        glassColor: const Color(0x18FFFFFF),
        specularSharpness: GlassSpecularSharpness.medium,
        shadowElevation: 1.0,
        shadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            spreadRadius: -5,
            offset: const Offset(0, 7),
          ),
        ],
      ),

      // ----------------------------------------------------------
      // ACTIVE INDICATOR GLASS
      // ----------------------------------------------------------
      indicatorSettings: LiquidGlassSettings(
        // Keep the indicator visually glass-like,
        // but avoid strong distortion during movement.
        thickness: 20,

        // Very low blur.
        blur: 5,

        // Almost neutral refraction.
        refractiveIndex: 1.2,

        // Disable chromatic distortion.
        chromaticAberration: 0.01,

        lightAngle: GlassDefaults.lightAngle,

        // Very subtle reflection.
        lightIntensity: 0.5,

        // Minimal ambient effect.
        ambientStrength: 0.0,

        saturation: 1.5,

        // Transparent glass.
        glassColor: const Color(0x12000000),

        specularSharpness: GlassSpecularSharpness.medium,
      ),
    );
  }
}
