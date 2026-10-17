import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.darkNav,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    LiquidGlassWidgets.wrap(
      child: const SneakerCommerceApp(),
    ),
  );
}

class SneakerCommerceApp extends StatelessWidget {
  final bool showSplash;

  const SneakerCommerceApp({
    super.key,
    this.showSplash = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneaker Collections',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: showSplash ? const VideoSplashScreen() : const HomeScreen(),
    );
  }
}