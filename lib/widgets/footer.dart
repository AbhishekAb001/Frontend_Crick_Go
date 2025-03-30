import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.purple.withOpacity(0.2),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialLink(Icons.facebook_rounded, 'Facebook', context),
                SizedBox(width: width * 0.02),
                _buildSocialLink(
                    Icons.flutter_dash_rounded, 'Twitter', context),
                SizedBox(width: width * 0.02),
                _buildSocialLink(
                    Icons.camera_alt_rounded, 'Instagram', context),
                SizedBox(width: width * 0.02),
                _buildSocialLink(
                    Icons.play_circle_fill_rounded, 'YouTube', context),
                SizedBox(width: width * 0.02),
                _buildSocialLink(
                    Icons.sports_cricket_rounded, 'Cricket', context),
              ],
            ),
            SizedBox(height: height * 0.015),
            Container(
              width: width * 0.3,
              height: 1,
              color: Colors.white.withOpacity(0.1),
            ),
            SizedBox(height: height * 0.01),
            Text(
              '© 2024 Cricket Management. All rights reserved.',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.6),
                fontSize: width * 0.009,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLink(
      IconData icon, String platform, BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.01,
          vertical: width * 0.005,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              size: width * 0.018,
            ),
            SizedBox(width: width * 0.005),
            Text(
              platform,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.9),
                fontSize: width * 0.01,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
