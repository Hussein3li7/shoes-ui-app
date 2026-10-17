import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sneaker.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_chip.dart';
import '../widgets/featured_product_card.dart';
import '../widgets/popular_product_card.dart';
import '../widgets/bottom_navigation.dart';
import 'product_details_screen.dart';
import 'payment_method_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedBrand = 'Nike';
  int _currentNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  void _navigateToDetails(Sneaker sneaker) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProductDetailsScreen(sneaker: sneaker),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentMethodScreen(),
      ),
    );
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search Nike, Jordan, Dunks...',
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: AppColors.textMuted,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.mint,
                  ),
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Searching for "${_searchController.text}"'),
                      backgroundColor: AppColors.darkNav,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mint,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Search Collections',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // TOP HEADER
                  _buildHeader(),
                  const SizedBox(height: 24),

                  // BRAND FILTERS
                  BrandSelector(
                    brands: SneakerData.brands,
                    selectedBrand: _selectedBrand,
                    onBrandSelected: (brand) {
                      setState(() => _selectedBrand = brand);
                    },
                  ),
                  const SizedBox(height: 20),

                  // FEATURED PRODUCTS CAROUSEL
                  SizedBox(
                    height: 295,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 6),
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: SneakerData.featuredSneakers.length,
                      itemBuilder: (context, index) {
                        final sneaker = SneakerData.featuredSneakers[index];
                        return FeaturedProductCard(
                          sneaker: sneaker,
                          onTap: () => _navigateToDetails(sneaker),
                          onAddToCart: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${sneaker.name} added to cart!'),
                                duration: const Duration(seconds: 2),
                                backgroundColor: AppColors.darkNav,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // MOST POPULAR SECTION
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Most Popular Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Most Popular',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.2,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Viewing all popular sneakers'),
                                    backgroundColor: AppColors.darkNav,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Popular Product List
                        ...SneakerData.popularSneakers.map(
                          (sneaker) => PopularProductCard(
                            sneaker: sneaker,
                            onTap: () => _navigateToDetails(sneaker),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FLOATING NOTCHED BOTTOM NAVIGATION BAR
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: LuxuryBottomNav(
                selectedIndex: _currentNavIndex,
                onItemSelected: (index) {
                  setState(() => _currentNavIndex = index);
                  if (index == 2) {
                    _navigateToCart();
                  }
                },
                onSearchPressed: _showSearchModal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "Explore new \nCollections"
          RichText(
            text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                height: 1.15,
                letterSpacing: -0.4,
              ),
              children: [
                const TextSpan(text: 'Explore '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Transform.rotate(
                    angle: -0.06,
                    child: Text(
                      'new',
                      style: GoogleFonts.caveat(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mint,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: '\nCollections'),
              ],
            ),
          ),

          // Search button: circular white container ~44px with subtle shadow
          GestureDetector(
            onTap: _showSearchModal,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFF0F0F4),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
