import 'package:cricket_management/screens/Tournament/tournament_screen.dart';
import 'package:cricket_management/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'service/theme_controller.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      // Log error details
      debugPrint('FlutterError: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
    };

    runApp(CricketManagementApp());
  }, (error, stackTrace) {
    // Catch any errors not caught by Flutter
    debugPrint('Uncaught error: $error');
    debugPrint('Stack trace: $stackTrace');
  });
}

class CricketManagementApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  CricketManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Cricket Tournament Manager',
        theme: themeController.currentTheme.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        getPages: [
          GetPage(
              name: '/splash',
              page: () => const SplashScreen(),
              transition: Transition.fade,
              transitionDuration: const Duration(milliseconds: 800)),
          GetPage(
              name: '/login',
              page: () => LoginScreen(),
              transition: Transition.rightToLeft,
              transitionDuration: const Duration(milliseconds: 500)),
          GetPage(
              name: '/signup',
              page: () => SignUpScreen(),
              transition: Transition.zoom,
              curve: Curves.easeInOut,
              transitionDuration: const Duration(milliseconds: 600)),
          GetPage(
              name: '/dashboard',
              page: () => DashboardScreen(),
              transition: Transition.fadeIn,
              curve: Curves.easeIn,
              transitionDuration: const Duration(milliseconds: 700)),
        ],
      ),
    );
  }
}
