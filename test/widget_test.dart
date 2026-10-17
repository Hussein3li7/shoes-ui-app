import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';
import 'package:test_app/screens/home_screen.dart';
import 'package:test_app/screens/product_details_screen.dart';
import 'package:test_app/widgets/bottom_navigation.dart';
import 'package:test_app/widgets/custom_curved_size_selector.dart';
import 'package:test_app/widgets/featured_product_card.dart';
import 'package:test_app/widgets/liquid_glass_bottom_nav_bar.dart';

void main() {
  testWidgets('App loads and renders SneakerCommerceApp directly', (WidgetTester tester) async {
    await tester.pumpWidget(const SneakerCommerceApp(showSplash: false));
    await tester.pump();

    // Verify header, popular section, and brands are present
    expect(find.byType(RichText), findsWidgets);
    expect(find.text('Most Popular'), findsOneWidget);
    expect(find.text('Nike'), findsOneWidget);
  });

  testWidgets('VideoSplashScreen renders with Skip button and fallback branding', (WidgetTester tester) async {
    await tester.pumpWidget(const SneakerCommerceApp(showSplash: true));
    await tester.pump();

    // Verify Skip button is available
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('SNEAKER VAULT'), findsOneWidget);
  });

  testWidgets('Tapping product navigates with Hero animation to ProductDetailsScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const SneakerCommerceApp(showSplash: false));
    await tester.pump();

    // Tap first featured card
    await tester.tap(find.byType(FeaturedProductCard).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    // Verify ProductDetailsScreen is displayed with Hero widget
    expect(find.byType(ProductDetailsScreen), findsOneWidget);
    expect(find.byType(Hero), findsWidgets);
    expect(find.text('Order Now'), findsOneWidget);
  });

  testWidgets('CurvedSizeArcSelector renders, scrolls, and centers selected size', (WidgetTester tester) async {
    int selected = 30;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 360,
              child: CurvedSizeArcSelector(
                sizes: const [27, 28, 29, 30, 31, 32, 33],
                selectedSize: selected,
                onSizeSelected: (newSize) {
                  selected = newSize;
                },
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify initial center selected size
    expect(find.text('30'), findsOneWidget);
    expect(find.text('SIZE'), findsOneWidget);

    // Scroll by dragging left
    await tester.drag(find.byType(CurvedSizeArcSelector), const Offset(-80, 0));
    await tester.pumpAndSettle();

    // Verify callback and updated center size
    expect(selected, isNot(30));
  });

  testWidgets('Renders LiquidGlassBottomNavigationBar on iOS platform and LuxuryBottomNav on other platforms', (WidgetTester tester) async {
    // 1. Android (default) platform renders LuxuryBottomNav
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(key: ValueKey('android_home')),
      ),
    );
    await tester.pump();
    expect(find.byType(LuxuryBottomNav), findsOneWidget);
    expect(find.byType(LiquidGlassBottomNavigationBar), findsNothing);

    // 2. iOS platform renders LiquidGlassBottomNavigationBar
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(key: ValueKey('ios_home')),
      ),
    );
    await tester.pump();
    expect(find.byType(LiquidGlassBottomNavigationBar), findsOneWidget);
    expect(find.byType(LuxuryBottomNav), findsNothing);

    // Reset override
    debugDefaultTargetPlatformOverride = null;
  });
}
