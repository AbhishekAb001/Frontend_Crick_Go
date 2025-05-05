import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _isLoading = false; // Add a loading state variable

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    double fontSize = mq.size.width * 0.015;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/signupbgc.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Positioned(
            right: mq.size.width * 0.08,
            top: mq.size.height * 0.07,
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
                    Text(
                      "Sign Up",
                      style: GoogleFonts.lato(
                        fontSize: fontSize * 2,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(157, 221, 0, 33),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.035),
                    _buildTextField('Username', _usernameController),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField('Full Name', _fullNameController),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField('Email', _emailController),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField('Password', _passwordController,
                        obscureText: !_isPasswordVisible, toggleVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField(
                        'Confirm Password', _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        toggleVisibility: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    }),
                    SizedBox(height: mq.size.height * 0.05),
                    GestureDetector(
                      onTap: _isLoading ? null : registerUser, // Disable tap when loading
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
                                  'Sign Up',
                                  style: GoogleFonts.lato(
                                      fontSize: fontSize, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
                    Text(
                      "Or Sign Up with",
                      style: GoogleFonts.lato(
                          fontSize: mq.size.width * 0.01,
                          color: Colors.white70),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
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
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text("Already have an account? Login",
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

  Widget _buildSocialButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle social button tap
        print("Social button tapped");
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
          child: Icon(
            icon,
            color: color,
            size: MediaQuery.of(context).size.width * 0.01,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, VoidCallback? toggleVisibility}) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        suffixIcon: toggleVisibility != null
            ? IconButton(
                icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: toggleVisibility,
              )
            : null,
      ),
      style: GoogleFonts.lato(color: Colors.white),
    );
  }

  void registerUser() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    if (_usernameController.text.trim().isNotEmpty &&
        _fullNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _confirmPasswordController.text.trim().isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          final response = await http.post(
            Uri.parse("http://localhost:8080/auth/register"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              "username": _usernameController.text,
              "fullName": _fullNameController.text,
              "email": _emailController.text,
              "password": _passwordController.text,
            }),
          );

          if (response.statusCode == 201) {
            // Handle successful registration
            Get.snackbar(
              'Success',
              'Registration successful',
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
            _usernameController.clear();
            _fullNameController.clear();
            _emailController.clear();
            _passwordController.clear();
            _confirmPasswordController.clear();
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            // Handle server error
            Get.snackbar(
              'Error',
              'Registration failed: ${response.body}',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          }
        } catch (e) {
          // Handle network error
          Get.snackbar(
            'Error',
            'Network error occurred',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all the fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }

    setState(() {
      _isLoading = false; // Reset loading state
    });
  }
}
