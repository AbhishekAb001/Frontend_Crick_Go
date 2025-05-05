import 'package:cricket_management/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const CricketManagementApp());
  // runZonedGuarded(() {
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     debugPrint('FlutterError: ${details.exception}');
  //     debugPrint('Stack trace: ${details.stack}');
  //   };
  // }, (error, stackTrace) {
  //   // Catch any errors not caught by Flutter
  //   debugPrint('Uncaught error: $error');
  //   debugPrint('Stack trace: $stackTrace');
  // });
}

class CricketManagementApp extends StatelessWidget {
  const CricketManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cricket Tournament Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
