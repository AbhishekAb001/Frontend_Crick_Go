import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
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
                  color: Color.fromARGB(255, 19, 18, 18).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
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
                        color: Color.fromARGB(157, 221, 0, 33),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.035),
                    _buildTextField('Full Name'),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField('Email'),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField('Password', obscureText: true),
                    SizedBox(height: mq.size.height * 0.025),
                    _buildTextField('Confirm Password', obscureText: true),
                    SizedBox(height: mq.size.height * 0.05),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: mq.size.width * 0.1,
                        height: mq.size.width * 0.03,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 219, 24, 24),
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
                          child: Text(
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
                        SizedBox(width: 10),
                        _buildSocialButton(
                            FontAwesomeIcons.facebook, Colors.blue),
                        SizedBox(width: 10),
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

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: GoogleFonts.lato(color: Colors.white),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        print("Sign Up with Social Media");
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.all(10),
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
}
