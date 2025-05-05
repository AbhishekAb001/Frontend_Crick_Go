import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cricket_management/widgets/footer.dart';

class MVPTab extends StatefulWidget {
  const MVPTab({super.key});

  @override
  State<MVPTab> createState() => _MVPTabState();
}

class _MVPTabState extends State<MVPTab> {
  late double width;
  late double height;

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
            _buildSectionTitle('Most Valuable Players'),
            SizedBox(height: height * 0.01),

            // Current match MVPs
            Row(
              children: [
                Expanded(
                  child: _buildMVPCard(
                    'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg',
                    'Rohit Sharma',
                    'WIZARDS',
                    'Batting',
                    0.85,
                    Colors.blue,
                    '22 runs, 18 balls, 2 fours, 1 six',
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: _buildMVPCard(
                    'https://img.cricketworld.com/images/f-066249/mitchell-starc.jpg',
                    'Mitchell Starc',
                    'CHALLENGERS',
                    'Bowling',
                    0.78,
                    Colors.purple,
                    '1 wicket, 2 overs, 18 runs, 9.00 economy',
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Tournament stats
            _buildSectionTitle('Tournament Stats Leaders'),
            SizedBox(height: height * 0.01),

            // Batting leaders
            _buildStatLeaderSection('Batting', [
              _buildStatLeader(
                'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg',
                'Rohit Sharma',
                'WIZARDS',
                '245 runs',
                '5 matches',
              ),
              _buildStatLeader(
                'https://img.cricketworld.com/images/f-126249/2023-04-09t120455z_1283255784_up1ej490xk5oe_rtrmadp_3_cricket-ipl.jpg',
                'Virat Kohli',
                'CHALLENGERS',
                '220 runs',
                '5 matches',
              ),
              _buildStatLeader(
                'https://img.cricketworld.com/images/f-096249/kl-rahul.jpg',
                'KL Rahul',
                'WIZARDS',
                '185 runs',
                '5 matches',
              ),
            ]),

            SizedBox(height: height * 0.02),

            // Bowling leaders
            _buildStatLeaderSection('Bowling', [
              _buildStatLeader(
                'https://img.cricketworld.com/images/f-066249/mitchell-starc.jpg',
                'Mitchell Starc',
                'CHALLENGERS',
                '12 wickets',
                '5 matches',
              ),
              _buildStatLeader(
                'https://img.cricketworld.com/images/f-066249/jasprit-bumrah.jpg',
                'Jasprit Bumrah',
                'WIZARDS',
                '10 wickets',
                '5 matches',
              ),
              _buildStatLeader(
                'https://img.cricketworld.com/images/f-066249/pat-cummins.jpg',
                'Pat Cummins',
                'CHALLENGERS',
                '8 wickets',
                '5 matches',
              ),
            ]),
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

  Widget _buildMVPCard(String imageUrl, String name, String team,
      String category, double rating, Color color, String stats) {
    return ElasticIn(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.all(width * 0.015),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  radius: width * 0.05,
                  lineWidth: width * 0.005,
                  percent: rating,
                  center: ClipRRect(
                    borderRadius: BorderRadius.circular(width * 0.04),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: width * 0.07,
                      height: width * 0.07,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  progressColor: color,
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(width * 0.004),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      (rating * 10).toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.008,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Text(
              name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.012,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              team,
              style: GoogleFonts.poppins(
                color: color,
                fontSize: width * 0.01,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.01,
                vertical: height * 0.003,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: GoogleFonts.poppins(
                  color: color,
                  fontSize: width * 0.008,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              stats,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.009,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatLeaderSection(String title, List<Widget> leaders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.012,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.005),
        ...leaders,
      ],
    );
  }

  Widget _buildStatLeader(
      String imageUrl, String name, String team, String stat, String matches) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.008),
        padding: EdgeInsets.all(width * 0.01),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.02),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: width * 0.04,
                height: width * 0.04,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.withOpacity(0.3),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.withOpacity(0.3),
                  child:
                      Icon(Icons.error, color: Colors.red, size: width * 0.02),
                ),
              ),
            ),
            SizedBox(width: width * 0.01),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    team,
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.008,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stat,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: width * 0.01,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  matches,
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: width * 0.008,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
