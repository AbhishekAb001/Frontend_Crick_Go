import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/controllers/profile_controller.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    // Fade-in Animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start Animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    double fontSize = mq.size.width * 0.015; // Adjust font size dynamically

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/loginbgc.jpg', // Add your background image
              fit: BoxFit.cover,
            ),
          ),

          // Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Fade-in Animated Login Form aligned to the left
          Positioned(
            left: mq.size.width * 0.08, // Align to left with some margin
            top: mq.size.height * 0.15, // Adjust position dynamically
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: mq.size.width * 0.3,
                padding: EdgeInsets.all(mq.size.width * 0.03),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 19, 18, 18).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Login Title
                    Text(
                      "Login",
                      style: GoogleFonts.lato(
                        fontSize: fontSize * 2,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(157, 221, 0, 33),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.035),

                    // Username Field
                    TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: GoogleFonts.lato(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    SizedBox(height: mq.size.height * 0.025),

                    // Password Field
                    TextField(
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.lato(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    SizedBox(height: mq.size.height * 0.05),

                    // Animated Login Button
                    GestureDetector(
                      onTap:
                          _isLoading ? null : login, // Disable tap when loading
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: mq.size.width * 0.1,
                        height: mq.size.width * 0.03,
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? Colors.grey // Change color when loading
                              : const Color.fromARGB(255, 219, 24, 24),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Login',
                                  style: GoogleFonts.lato(
                                      fontSize: fontSize, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),

                    // Social Media Login Options
                    Text(
                      "Or Login with",
                      style: GoogleFonts.lato(
                          fontSize: mq.size.width * 0.01,
                          color: Colors.white70),
                    ),
                    SizedBox(height: mq.size.height * 0.02),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(FontAwesomeIcons.google, Colors.red),
                        const SizedBox(width: 10),
                        _buildSocialButton(
                            FontAwesomeIcons.facebook, Colors.blue),
                        const SizedBox(width: 10),
                        _buildSocialButton(
                            FontAwesomeIcons.twitter, Colors.lightBlue),
                      ],
                    ),
                    SizedBox(height: mq.size.height * 0.02),

                    // Sign Up Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text("Don't have an account? Sign Up",
                          style: GoogleFonts.lato(
                              fontSize: mq.size.width * 0.01,
                              color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Social Media Button Widget
  Widget _buildSocialButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        print("Login with Social Media");
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon,
              color: color, size: MediaQuery.of(context).size.width * 0.01),
        ),
      ),
    );
  }

  bool _isLoading = false; // Add a loading state variable

  void login() async {
    AuthSharedP authSharedP = AuthSharedP();
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    if (_userNameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (_userNameController.text == "admin") {
        await authSharedP.setAdminStatus(true);
        await authSharedP.getAdminStatus();
      }
      try {
        final response = await http.post(
          Uri.parse("http://localhost:8080/auth/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'username': _userNameController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          // Handle successful response
          Get.snackbar(
            "Success",
            "Logged in successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
          authSharedP.setIsLoggedIn(true);
          authSharedP.setProfileData(jsonDecode(response.body));
          authSharedP.setValues(jsonDecode(response.body)['token'],
              jsonDecode(response.body)['username']);

          Navigator.pushNamed(context, '/dashboard');
        } else {
          // Handle error response
          Get.snackbar(
            "Error",
            "Failed to login",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        }
      } catch (e) {
        log(e.toString());
        Get.snackbar(
          "Error",
          "$e",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
    } else {
      Get.snackbar(
        "Required",
        "All Fields are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }

    setState(() {
      _isLoading = false; // Reset loading state
    });
  }
}
