import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum SneakerViewType {
  angle,
  side,
  top,
  sole,
}

class Sneaker {
  final String id;
  final String name;
  final String subname;
  final String brand;
  final double price;
  final double? originalPrice;
  final int discountPercent;
  final String discountTag;
  final Color backgroundColor;
  final String watermark;
  final Map<SneakerViewType, String> imageAngles;
  final String primaryImageUrl;
  final Color badgeColor;
  final String? model3dUrl;

  const Sneaker({
    required this.id,
    required this.name,
    required this.subname,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.discountPercent,
    required this.discountTag,
    required this.backgroundColor,
    required this.watermark,
    required this.imageAngles,
    required this.primaryImageUrl,
    required this.badgeColor,
    this.model3dUrl,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedOriginalPrice =>
      originalPrice != null ? '\$${originalPrice!.toStringAsFixed(2)}' : '';
}

class SneakerData {
  SneakerData._();

  static const List<String> brands = [
    'All',
    'Nike',
    'Adidas',
    'Puma',
    'Reebok',
  ];

  static const Sneaker featuredJordanPrototype = Sneaker(
    id: 'jordan-1-prototype',
    name: 'Jordan 1 Retro High',
    subname: 'Og Prototype',
    brand: 'Nike',
    price: 526.14,
    originalPrice: 657.67,
    discountPercent: 20,
    discountTag: 'Save 20%',
    backgroundColor: AppColors.pastelLavender,
    watermark: 'NIKE AIR',
    primaryImageUrl:
        'assets/img/download-nike-shoes-transparent-png-for-designing-projects-16.png',
    imageAngles: {
      SneakerViewType.angle:
          'assets/img/download-nike-shoes-transparent-png-for-designing-projects-16.png',
      SneakerViewType.side:
          'assets/img/512b4b870390fac58da5206e88d228d6.png',
      SneakerViewType.top:
          'assets/img/pair-of-colorful-sports-shoes-for-active-lifestyle-png.webp',
      SneakerViewType.sole:
          'assets/img/pngtree-dropshipping-men-hole-sole-jogging-shoes-png-image_11389148.png',
    },
    badgeColor: AppColors.pastelLavender,
  );

  static const Sneaker featuredMintAirMax = Sneaker(
    id: 'air-max-mint',
    name: 'Nike Air Max Pulse',
    subname: 'Mint Horizon',
    brand: 'Nike',
    price: 437.61,
    originalPrice: 547.01,
    discountPercent: 20,
    discountTag: 'Save 20%',
    backgroundColor: AppColors.pastelMint,
    watermark: 'AIR MAX',
    primaryImageUrl:
        'assets/img/green-running-shoes-png-24.png',
    imageAngles: {
      SneakerViewType.angle:
          'assets/img/green-running-shoes-png-24.png',
      SneakerViewType.side:
          'assets/img/colorful-cool-running-sneakers-mockup-vibrant-colors-isolated-on-a-transparent-background-free-png.webp',
      SneakerViewType.top:
          'assets/img/pair-of-colorful-sports-shoes-for-active-lifestyle-png.webp',
      SneakerViewType.sole:
          'assets/img/pngtree-dropshipping-men-hole-sole-jogging-shoes-png-image_11389148.png',
    },
    badgeColor: AppColors.pastelMint,
  );

  static const Sneaker popularJordanWhite = Sneaker(
    id: 'jordan-1-white',
    name: 'Jordan 1 White',
    subname: 'Pure Edition',
    brand: 'Nike',
    price: 566.18,
    originalPrice: 707.72,
    discountPercent: 20,
    discountTag: '20% OFF',
    backgroundColor: AppColors.pastelBlue,
    watermark: 'JORDAN',
    primaryImageUrl:
        'assets/img/512b4b870390fac58da5206e88d228d6.png',
    imageAngles: {
      SneakerViewType.angle:
          'assets/img/512b4b870390fac58da5206e88d228d6.png',
      SneakerViewType.side:
          'assets/img/download-nike-shoes-transparent-png-for-designing-projects-16.png',
      SneakerViewType.top:
          'assets/img/pair-of-colorful-sports-shoes-for-active-lifestyle-png.webp',
      SneakerViewType.sole:
          'assets/img/pngtree-dropshipping-men-hole-sole-jogging-shoes-png-image_11389148.png',
    },
    badgeColor: AppColors.pastelBlue,
    model3dUrl: 'assets/models/sneaker_from_png.glb',
  );

  static const Sneaker popularMidCoconut = Sneaker(
    id: 'mid-coconut-nike',
    name: 'Mid Coconut Nike',
    subname: 'Dunk Low Special',
    brand: 'Nike',
    price: 195.20,
    originalPrice: 229.64,
    discountPercent: 15,
    discountTag: '15% OFF',
    backgroundColor: AppColors.pastelYellow,
    watermark: 'DUNK MID',
    primaryImageUrl:
        'assets/img/pngtree-men-jogging-shoes-clipart-png-image_19647116.png',
    imageAngles: {
      SneakerViewType.angle:
          'assets/img/pngtree-men-jogging-shoes-clipart-png-image_19647116.png',
      SneakerViewType.side:
          'assets/img/compressed_cc2b6c7d0c91c142817535bc16c459cd.webp',
      SneakerViewType.top:
          'assets/img/pair-of-colorful-sports-shoes-for-active-lifestyle-png.webp',
      SneakerViewType.sole:
          'assets/img/pngtree-dropshipping-men-hole-sole-jogging-shoes-png-image_11389148.png',
    },
    badgeColor: AppColors.pastelYellow,
  );

  static const Sneaker cartCoconutPink = Sneaker(
    id: 'mid-coconut-pink',
    name: 'Mid Coconut Nike',
    subname: 'Blush Sunset Edition',
    brand: 'Nike',
    price: 195.20,
    originalPrice: 260.27,
    discountPercent: 25,
    discountTag: '25% OFF',
    backgroundColor: AppColors.pastelPink,
    watermark: 'NIKE AIR',
    primaryImageUrl:
        'assets/img/pngtree-sports-shoes-png-image_15910407.png',
    imageAngles: {
      SneakerViewType.angle:
          'assets/img/pngtree-sports-shoes-png-image_15910407.png',
      SneakerViewType.side:
          'assets/img/colorful-cool-running-sneakers-mockup-vibrant-colors-isolated-on-a-transparent-background-free-png.webp',
      SneakerViewType.top:
          'assets/img/pair-of-colorful-sports-shoes-for-active-lifestyle-png.webp',
      SneakerViewType.sole:
          'assets/img/pngtree-dropshipping-men-hole-sole-jogging-shoes-png-image_11389148.png',
    },
    badgeColor: AppColors.pastelPink,
  );

  static List<Sneaker> get featuredSneakers => [
        featuredJordanPrototype,
        featuredMintAirMax,
      ];

  static List<Sneaker> get popularSneakers => [
        popularJordanWhite,
        popularMidCoconut,
      ];

  static List<Sneaker> get cartSneakers => [
        popularJordanWhite,
        popularMidCoconut,
        cartCoconutPink,
      ];
}
