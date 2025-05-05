import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_management/widgets/footer.dart';

class CricheroesTab extends StatelessWidget {
  late double width;
  late double height;

  CricheroesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Match Highlights'),
            SizedBox(height: height * 0.01),

            // Video highlights
            _buildVideoHighlight(
              'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg',
              'Rohit Sharmas brilliant 22 off 18 balls',
              '1:24',
            ),

            _buildVideoHighlight(
              'https://img.cricketworld.com/images/f-126249/2023-04-09t120455z_1283255784_up1ej490xk5oe_rtrmadp_3_cricket-ipl.jpg',
              'Mitchell Starcs wicket of Rohit Sharma',
              '0:45',
            ),

            SizedBox(height: height * 0.02),

            // Social media posts
            _buildSectionTitle('Social Media'),
            SizedBox(height: height * 0.01),

            Row(
              children: [
                Expanded(
                  child: _buildSocialPost(
                    'https://pbs.twimg.com/profile_images/1013798240683266048/zRim1x6M_400x400.jpg',
                    'Cricket World',
                    '@cricketworld',
                    'Rohit Sharma looking in good form today! #IndoorSeries',
                    '15m ago',
                    124,
                    45,
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: _buildSocialPost(
                    'https://pbs.twimg.com/profile_images/1724236516007174144/JqJo8CfX_400x400.jpg',
                    'Cricket Fans',
                    '@crickfans',
                    'Mitchell Starc with a beautiful delivery to dismiss Rohit! #CricketLive',
                    '8m ago',
                    87,
                    23,
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Fan engagement
            _buildSectionTitle('Fan Engagement'),
            SizedBox(height: height * 0.01),

            Container(
              padding: EdgeInsets.all(width * 0.015),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Who will win this match?',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.014,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  _buildPollOption('WIZARDS', 0.65, Colors.blue),
                  SizedBox(height: height * 0.008),
                  _buildPollOption('CHALLENGERS', 0.35, Colors.purple),
                  SizedBox(height: height * 0.01),
                  Text(
                    '245 votes • 10 minutes left',
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.01,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.04),

            // Add Footer with animation
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 800),
              child: const Footer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.015,
        vertical: height * 0.008,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blue.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.blue,
          fontSize: width * 0.014,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildVideoHighlight(String imageUrl, String title, String duration) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.01),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: height * 0.12,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: width * 0.02,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.008,
                      vertical: height * 0.003,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      duration,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.008,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialPost(String avatarUrl, String name, String handle,
      String content, String time, int likes, int comments) {
    return Container(
      padding: EdgeInsets.all(width * 0.015),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.02),
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  width: width * 0.03,
                  height: width * 0.03,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Icon(Icons.error,
                        color: Colors.red, size: width * 0.015),
                  ),
                ),
              ),
              SizedBox(width: width * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    handle,
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.008,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          Text(
            content,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: width * 0.01,
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: GoogleFonts.poppins(
                  color: Colors.white60,
                  fontSize: width * 0.008,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: width * 0.012,
                  ),
                  SizedBox(width: width * 0.003),
                  Text(
                    likes.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.008,
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white60,
                    size: width * 0.012,
                  ),
                  SizedBox(width: width * 0.003),
                  Text(
                    comments.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.008,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPollOption(String option, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.012,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: GoogleFonts.poppins(
                color: color,
                fontSize: width * 0.012,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.005),
        Stack(
          children: [
            Container(
              height: height * 0.008,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: height * 0.008,
              width: width * 0.4 * percentage,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.7),
                    color.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
