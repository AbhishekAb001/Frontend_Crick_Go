import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_management/widgets/footer.dart';

class TeamsTab extends StatefulWidget {
  const TeamsTab({super.key});

  @override
  State<TeamsTab> createState() => _TeamsTabState();
}

class _TeamsTabState extends State<TeamsTab> {
  late double width;
  late double height;
  int selectedTabIndex = 0;
  final List<String> tabs = ['WIZARDS', 'CHALLENGERS'];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.025),

            // Custom tab bar similar to statistics page
            _buildTabBar(width, height),

            SizedBox(height: height * 0.025),

            // Content based on selected tab
            Container(
              height: height * 0.6,
              child: selectedTabIndex == 0
                  ? _buildTeamView(
                      'WIZARDS',
                      'https://img.cricketworld.com/images/f-106249/india-logo.png',
                      Colors.blue,
                      [
                        _buildPlayerInfo('Rohit Sharma (C)', 'Opening Batsman',
                            'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg'),
                        // Other players...
                      ],
                    )
                  : _buildTeamView(
                      'CHALLENGERS',
                      'https://img.cricketworld.com/images/f-106249/australia-logo.png',
                      Colors.purple,
                      [
                        _buildPlayerInfo('Aaron Finch (C)', 'Opening Batsman',
                            'https://img.cricketworld.com/images/f-066249/aaron-finch.jpg'),
                        // Other players...
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

  Widget _buildTabBar(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        tabs.length,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTabIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: selectedTabIndex == index
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selectedTabIndex == index
                      ? Colors.white.withOpacity(0.3)
                      : Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: GoogleFonts.poppins(
                  color: selectedTabIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.7),
                  fontSize: width * 0.012,
                  fontWeight: selectedTabIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // The rest of the methods remain the same
  Widget _buildTeamView(
      String teamName, String logoUrl, Color teamColor, List<Widget> players) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team header
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: logoUrl,
                width: width * 0.05,
                height: width * 0.05,
                placeholder: (context, url) => Container(
                  color: Colors.grey.withOpacity(0.3),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.withOpacity(0.3),
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
              SizedBox(width: width * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamName,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.016,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '11 Players',
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.01,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: height * 0.02),

          // Team stats
          Container(
            padding: EdgeInsets.all(width * 0.015),
            decoration: BoxDecoration(
              color: teamColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTeamStat('Matches', '5'),
                _buildTeamStat('Won', '3'),
                _buildTeamStat('Lost', '2'),
                _buildTeamStat('NRR', '+0.425'),
                _buildTeamStat('Points', '6'),
              ],
            ),
          ),

          SizedBox(height: height * 0.02),

          // Players list
          _buildSectionTitle('Playing XI'),
          SizedBox(height: height * 0.01),

          ...players,
        ],
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

  Widget _buildTeamStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.014,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: width * 0.01,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerInfo(String name, String role, String imageUrl) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.01),
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
              borderRadius: BorderRadius.circular(width * 0.025),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: width * 0.05,
                height: width * 0.05,
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
            SizedBox(width: width * 0.01),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.012,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    role,
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.01,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.info_outline,
              color: Colors.white60,
              size: width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
