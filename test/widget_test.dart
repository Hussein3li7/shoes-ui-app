import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/main.dart';
import 'package:test_app/screens/product_details_screen.dart';
import 'package:test_app/widgets/custom_curved_size_selector.dart';
import 'package:test_app/widgets/featured_product_card.dart';

void main() {
  testWidgets('App loads and renders SneakerCommerceApp', (WidgetTester tester) async {
    await tester.pumpWidget(const SneakerCommerceApp());
    await tester.pump();

    // Verify header, popular section, and brands are present
    expect(find.byType(RichText), findsWidgets);
    expect(find.text('Most Popular'), findsOneWidget);
    expect(find.text('Nike'), findsOneWidget);
  });

  testWidgets('Tapping product navigates with Hero animation to ProductDetailsScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const SneakerCommerceApp());
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
}
