import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sneaker.dart';
import '../theme/app_theme.dart';
import '../widgets/circular_stock_badge.dart';
import '../widgets/custom_curved_size_selector.dart';
import '../widgets/orbit_control.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/sneaker_display.dart';
import 'payment_method_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Sneaker sneaker;

  const ProductDetailsScreen({
    super.key,
    required this.sneaker,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Sneaker _sneaker;
  SneakerViewType _selectedView = SneakerViewType.angle;
  double _rotationAngle = 306.0;
  int _quantity = 1;
  int _selectedSize = 30;

  @override
  void initState() {
    super.initState();
    _sneaker = widget.sneaker;
  }

  void _navigateToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentMethodScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            _buildTopBar(context),

            // MAIN SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // PRODUCT SHOWCASE STACK
                    _buildProductShowcase(),

                    // 360° ORBIT CONTROL
                    OrbitControl(
                      currentAngle: _rotationAngle,
                      onAngleChanged: (newAngle) {
                        setState(() => _rotationAngle = newAngle);
                      },
                    ),
                    const SizedBox(height: 20),

                    // 4 PRODUCT THUMBNAILS
                    _buildThumbnails(),
                    const SizedBox(height: 28),

                    // PRODUCT INFORMATION & VERTICAL QUANTITY SELECTOR
                    _buildProductInfoAndQuantity(),
                    const SizedBox(height: 16),

                    // CURVED SHOE SIZE SELECTOR
                    CurvedSizeArcSelector(
                      selectedSize: _selectedSize,
                      onSizeSelected: (newSize) {
                        setState(() => _selectedSize = newSize);
                      },
                    ),
                    const SizedBox(height: 16),

                    // ORDER NOW BUTTON
                    _buildOrderButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFF0F0F4),
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),

          // Circular Stock Badge / Stamp
          const CircularStockBadge(size: 60),
        ],
      ),
    );
  }

  Widget _buildProductShowcase() {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Pastel background glow
          Positioned(
            top: 20,
            child: Container(
              width: 240,
              height: 170,
              decoration: BoxDecoration(
                color: _sneaker.backgroundColor.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: _sneaker.backgroundColor.withValues(alpha: 0.5),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
            ),
          ),

          // Large faded watermark text behind sneaker
          Positioned(
            top: 40,
            child: IgnorePointer(
              child: Text(
                _sneaker.watermark,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4.0,
                  color: Colors.black.withValues(alpha: 0.04),
                ),
              ),
            ),
          ),

          // Central Floating & Rotating Sneaker
          Positioned(
            top: 10,
            child: SneakerDisplay(
              sneaker: _sneaker,
              viewType: _selectedView,
              width: 270,
              height: 185,
              rotationAngleDeg: _rotationAngle,
              tiltAngle: -0.16,
              showFloatingShadow: true,
              heroTag: 'sneaker_${_sneaker.id}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnails() {
    final views = [
      SneakerViewType.angle,
      SneakerViewType.side,
      SneakerViewType.top,
      SneakerViewType.sole,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: views.map((view) {
        final isSelected = _selectedView == view;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedView = view;
              // Reset/adjust angle for view perspective
              if (view == SneakerViewType.side) _rotationAngle = 0;
              if (view == SneakerViewType.angle) _rotationAngle = 306;
              if (view == SneakerViewType.top) _rotationAngle = 90;
              if (view == SneakerViewType.sole) _rotationAngle = 180;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            width: 60,
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 7),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.mint : const Color(0xFFF0F0F4),
                width: isSelected ? 2.0 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.mint.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.04),
                  blurRadius: isSelected ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Builder(
                builder: (context) {
                  final img = _sneaker.imageAngles[view] ?? _sneaker.primaryImageUrl;
                  final fallbackIcon = Center(
                    child: Icon(
                      view == SneakerViewType.sole
                          ? Icons.view_compact_rounded
                          : (view == SneakerViewType.top
                              ? Icons.straighten_rounded
                              : Icons.skateboarding_rounded),
                      size: 24,
                      color: isSelected ? AppColors.mint : AppColors.textSecondary,
                    ),
                  );

                  return img.startsWith('http')
                      ? Image.network(
                          img,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => fallbackIcon,
                        )
                      : Image.asset(
                          img,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => fallbackIcon,
                        );
                },
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductInfoAndQuantity() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Column: Name, Subname, Price, Save Flat 20%
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_sneaker.name}\n${_sneaker.subname}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.2,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 10),
              // Price in Orange #FF6B00
              Text(
                _sneaker.formattedPrice,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.orangePrice,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 4),
              // Save Flat 20%
              Text(
                'Save Flat ${_sneaker.discountPercent}%',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Right Column: Vertical quantity selector (+ in deep purple, 01, - in grey)
        VerticalQuantitySelector(
          quantity: _quantity,
          onIncrement: () {
            setState(() => _quantity++);
          },
          onDecrement: () {
            if (_quantity > 1) {
              setState(() => _quantity--);
            }
          },
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return Center(
      child: GestureDetector(
        onTap: _navigateToPayment,
        child: Container(
          width: 190,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.mint,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.mint.withValues(alpha: 0.4),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Order Now',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
