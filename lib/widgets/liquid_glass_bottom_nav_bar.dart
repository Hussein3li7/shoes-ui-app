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

/// A floating, pill-shaped Apple-style iOS 26 Liquid Glass Bottom Navigation Bar.
///
/// Built using [liquid_glass_widgets] and [GlassTabBar.bottom] for native shader
/// refraction, chromatic aberration, specular reflections, dynamic blur,
/// and smooth liquid pinch transitions between tabs.
class LiquidGlassBottomNavigationBar extends StatelessWidget {
  /// The currently active tab index (0 to items.length - 1).
  final int selectedIndex;

  /// Callback triggered when a tab is tapped.
  final ValueChanged<int> onTabSelected;

  /// Custom navigation destinations. If null, defaults to the 5 standard iOS 26
  /// destinations: Home, Search, Library, Favorites, Profile.
  final List<LiquidGlassNavItem>? customItems;

  /// Height of the floating glass bar (default: 68.0, recommended: 64–72).
  final double barHeight;

  /// Outer horizontal padding from the screen edge (default: 16.0).
  /// Yields approximately 92% screen width on standard mobile viewports.
  final double horizontalPadding;

  /// Bottom margin above the screen edge / system safe area (default: 12.0).
  final double bottomMargin;

  /// Corner radius of the pill-shaped glass container (default: 32.0).
  final double borderRadius;

  /// Elegant restrained iOS pink/red accent color for the selected tab indicator and icon.
  final Color accentColor;

  /// Unselected icon & label color (translucent white for liquid glass absorption).
  final Color unselectedColor;

  /// Glass quality tier (defaults to [GlassQuality.premium] for fixed navigation).
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
    this.accentColor = const Color(0xFFFF2D55), // Apple iOS System Pink / Coral-Red Accent
    this.unselectedColor = const Color(0xB3FFFFFF), // Soft translucent white (70%)
    this.quality = GlassQuality.premium,
  });

  /// Default 5 destinations matching the reference layout:
  /// 1. Home
  /// 2. Search
  /// 3. Library
  /// 4. Favorites
  /// 5. Profile
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

    // Convert items to native GlassTab configurations
    final tabs = items.map((item) {
      return GlassTab(
        icon: Icon(item.icon),
        activeIcon: Icon(item.activeIcon ?? item.icon),
        label: item.label,
        glowColor: item.glowColor ?? accentColor.withValues(alpha: 0.35),
      );
    }).toList();

    // Subtle translucent pink/red indicator tint (avoids opaque red or heavy gradients)
    final indicatorTint = accentColor.withValues(alpha: 0.18);

    return GlassTabBar.bottom(
      tabs: tabs,
      selectedIndex: selectedIndex.clamp(0, tabs.length - 1),
      onTabSelected: onTabSelected,
      barHeight: barHeight,
      barBorderRadius: borderRadius,
      horizontalPadding: horizontalPadding,
      verticalPadding: bottomMargin,
      spacing: 4,
      iconLabelSpacing: 3,
      iconSize: 21,
      labelFontSize: 10.5,
      showIndicator: true,
      quality: quality,
      magnification: 1.12,
      indicatorPinchStrength: 0.35, // Subtle liquid-jelly movement when changing tabs
      indicatorColor: indicatorTint,
      selectedIconColor: accentColor,
      unselectedIconColor: unselectedColor,
      selectedLabelColor: accentColor,
      unselectedLabelColor: unselectedColor.withValues(alpha: 0.65),
      glowBlurRadius: 24,
      glowSpreadRadius: 4,
      glowOpacity: 0.35,
      selectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
      ),
      unselectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 10.5,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.1,
      ),
      // Real Liquid Glass physical settings:
      // High refraction, soft specular highlights, natural background absorption
      settings: LiquidGlassSettings(
        thickness: 26,
        blur: 18,
        refractiveIndex: 1.28,
        chromaticAberration: 0.012,
        lightAngle: GlassDefaults.lightAngle,
        lightIntensity: 0.65,
        ambientStrength: 0.12,
        saturation: 1.35,
        glassColor: const Color(0x14FFFFFF), // Ultra-clear translucent glass
        specularSharpness: GlassSpecularSharpness.sharp,
        shadowElevation: 2.0,
        shadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 28,
            spreadRadius: -4,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      indicatorSettings: LiquidGlassSettings(
        thickness: 16,
        blur: 12,
        refractiveIndex: 1.18,
        lightIntensity: 0.5,
        ambientStrength: 0.08,
        saturation: 1.2,
        glassColor: indicatorTint,
        specularSharpness: GlassSpecularSharpness.medium,
      ),
    );
  }
}
