import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade Animation Controller
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);

    _fadeController.forward();

    // Navigate to Login Screen after 5 seconds
    // Timer(const Duration(seconds: 5), () {
    //   Navigator.pushReplacementNamed(context, "/login");
    // });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Left Side (Lottie, Animated Texts, Button)
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lottie Animation
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.4,
                      height:
                          screenHeight * 0.35, // Adjusted for responsiveness
                      child: Lottie.network(
                        'https://assets7.lottiefiles.com/packages/lf20_1pxqjqps.json', // Cricket Ball Animation
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // Responsive height

                  // Title Animation (Fade Transition)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      "Cricket Management System",
                      style: GoogleFonts.lato(
                        fontSize: screenWidth * 0.025,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 212, 14, 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Responsive height

                  // Info Text (Typewriter Animation)
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        textStyle: GoogleFonts.lato(
                          fontSize: screenWidth * 0.015,
                          color: Color.fromARGB(179, 215, 102, 9),
                          fontWeight: FontWeight.w400,
                        ),
                        'Manage your cricket team effortlessly!',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        textStyle: GoogleFonts.lato(
                          fontSize: screenWidth * 0.015,
                          color: Color.fromARGB(179, 18, 205, 77),
                          fontWeight: FontWeight.w400,
                        ),
                        'Track player performance and statistics.',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        textStyle: GoogleFonts.lato(
                          fontSize: screenWidth * 0.015,
                          color: Color.fromARGB(179, 45, 112, 221),
                          fontWeight: FontWeight.w400,
                        ),
                        'Plan tournaments with ease!',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                  ),
                  SizedBox(height: screenHeight * 0.05), // Responsive height

                  // Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(225, 228, 2, 2),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.02),
                      textStyle: GoogleFonts.lato(
                          fontSize: screenWidth * 0.02,
                          fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.lato(
                        fontSize: screenWidth * 0.015,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Side (Image)
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/batball.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
