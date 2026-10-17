import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/sneaker.dart';
import '../theme/app_theme.dart';
import '../widgets/sneaker_display.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _couponApplied = true;
  final TextEditingController _couponController =
      TextEditingController(text: '#nikeairshoes1969');

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _processPayment() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success checkmark animation
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.pastelMint,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mint.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: AppColors.mint,
                    size: 42,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Payment Successful!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your luxury sneaker order #NK-92817 has been confirmed and is being packaged.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  Navigator.popUntil(context, (route) => route.isFirst); // Go to Home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkNav,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Back to Home',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
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
        title: Text(
          'Payment Method',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.deepPurple,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SCROLLABLE BODY
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CART ITEMS (3 horizontal product cards)
                    ...SneakerData.cartSneakers.map(
                      (sneaker) => _buildCartItemCard(sneaker),
                    ),
                    const SizedBox(height: 18),

                    // APPLY COUPON SECTION
                    Text(
                      'Apply Coupon',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _couponController,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          // Mint circular check icon
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _couponApplied = !_couponApplied;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: _couponApplied
                                    ? AppColors.mint
                                    : const Color(0xFFDCDCE2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  _couponApplied
                                      ? Icons.check_rounded
                                      : Icons.add_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ORDER SUMMARY
                    _buildOrderSummary(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // BOTTOM PAYMENT CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: GestureDetector(
                onTap: _processPayment,
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.mint,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mint.withValues(alpha: 0.4),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Procced To Pay',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemCard(Sneaker sneaker) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pastel image container (~64px)
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: sneaker.backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Center(
                child: SneakerDisplay(
                  sneaker: sneaker,
                  width: 70,
                  height: 52,
                  tiltAngle: -0.16,
                  showFloatingShadow: false,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Product name and price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  sneaker.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sneaker.formattedPrice,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Circular discount badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: sneaker.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${sneaker.discountPercent}%\nOFF',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final double itemPrice = 83.96;
    final double discount = _couponApplied ? 10.96 : 0.00;
    final double shipping = 17.05;
    final double total = itemPrice - discount + shipping;

    return Column(
      children: [
        _buildSummaryRow(
          'Item Price',
          '\$${itemPrice.toStringAsFixed(2)}',
          isPrimary: false,
        ),
        const SizedBox(height: 10),
        _buildSummaryRow(
          'Coupon Code Discount',
          _couponApplied ? '- \$${discount.toStringAsFixed(2)}' : '\$0.00',
          isPrimary: false,
          valueColor: const Color(0xFFFF5252), // Red/coral discount
        ),
        const SizedBox(height: 10),
        _buildSummaryRow(
          'Shipping Charges',
          '\$${shipping.toStringAsFixed(2)}',
          isPrimary: false,
        ),
        const SizedBox(height: 14),
        const Divider(color: AppColors.dividerColor, thickness: 1.2),
        const SizedBox(height: 12),
        _buildSummaryRow(
          'Total Amount',
          '\$${total.toStringAsFixed(2)}',
          isPrimary: true,
          valueSize: 18,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    required bool isPrimary,
    Color? valueColor,
    double valueSize = 14,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isPrimary ? 16 : 13.5,
            fontWeight: isPrimary ? FontWeight.w800 : FontWeight.w500,
            color: isPrimary ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: valueSize,
            fontWeight: isPrimary ? FontWeight.w900 : FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
