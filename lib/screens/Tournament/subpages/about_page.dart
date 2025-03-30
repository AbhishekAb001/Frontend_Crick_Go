import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late double width;
  late double height;

  // Sample tournament data - in a real app, this would come from an API or database
  final Map<String, dynamic> tournamentInfo = {
    'description':
        'The Premier Cricket League (PCL) is an annual cricket tournament featuring the top teams from across the country. The tournament follows a round-robin format followed by knockout stages to determine the champion.',
    'organizer': 'National Cricket Association',
    'venue': 'Multiple stadiums across the country',
    'prize': '₹50,00,000',
    'rules': [
      'Each match will be played for 20 overs per side',
      'Power play rules as per international T20 standards',
      'DRS (Decision Review System) available for all matches',
      'Super Over will decide the winner in case of a tie',
      'Points: Win (2), Tie/No Result (1), Loss (0)',
      'Top 4 teams qualify for playoffs',
      'All ICC rules and regulations apply',
    ],
    'timeline': [
      {'date': '15 Mar 2024', 'event': 'Team Registration Deadline'},
      {'date': '18 Mar 2024', 'event': 'Team Auction'},
      {'date': '20 Mar 2024', 'event': 'Opening Ceremony'},
      {'date': '22 Mar 2024', 'event': 'First Match'},
      {'date': '10 Apr 2024', 'event': 'Last League Match'},
      {'date': '12 Apr 2024', 'event': 'Qualifier 1'},
      {'date': '13 Apr 2024', 'event': 'Eliminator'},
      {'date': '14 Apr 2024', 'event': 'Qualifier 2'},
      {'date': '16 Apr 2024', 'event': 'Final'},
      {'date': '17 Apr 2024', 'event': 'Closing Ceremony'},
    ],
    'contact': {
      'email': 'info@premiercricketleague.com',
      'phone': '+91 9876543210',
      'website': 'www.premiercricketleague.com',
      'social': {
        'twitter': '@PremierCricketLeague',
        'instagram': '@pcl_official',
        'facebook': 'PremierCricketLeagueOfficial',
      },
    },
  };

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("About Tournament"),
              SizedBox(height: height * 0.02),
              _buildAboutSection(),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Tournament Rules"),
              SizedBox(height: height * 0.02),
              _buildRulesSection(),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Tournament Timeline"),
              SizedBox(height: height * 0.02),
              _buildTimelineSection(),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Contact Information"),
              SizedBox(height: height * 0.02),
              _buildContactSection(),
              SizedBox(height: height * 0.05),
              const Footer(),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: width * 0.018,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tournamentInfo['description'],
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01,
                height: 1.5,
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.people,
                    "Organizer",
                    tournamentInfo['organizer'],
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: _buildInfoItem(
                    Icons.location_on,
                    "Venue",
                    tournamentInfo['venue'],
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: _buildInfoItem(
                    Icons.emoji_events,
                    "Prize Pool",
                    tournamentInfo['prize'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(width * 0.01),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: width * 0.015,
          ),
          SizedBox(width: width * 0.01),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: width * 0.009,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: width * 0.01,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesSection() {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.purple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < tournamentInfo['rules'].length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.02,
                      height: width * 0.02,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "${i + 1}",
                          style: GoogleFonts.poppins(
                            color: Colors.purple,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    Expanded(
                      child: Text(
                        tournamentInfo['rules'][i],
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: width * 0.01,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineSection() {
    return FadeInUp(
      duration: const Duration(milliseconds: 900),
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.amber.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            for (int i = 0; i < tournamentInfo['timeline'].length; i++)
              _buildTimelineItem(
                tournamentInfo['timeline'][i]['date'],
                tournamentInfo['timeline'][i]['event'],
                i == tournamentInfo['timeline'].length - 1,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String date, String event, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: width * 0.01),
        Column(
          children: [
            Container(
              width: width * 0.015,
              height: width * 0.015,
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.amber,
                  width: 2,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: height * 0.04,
                color: Colors.amber.withOpacity(0.3),
              ),
          ],
        ),
        SizedBox(width: width * 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: GoogleFonts.poppins(
                  color: Colors.amber,
                  fontSize: width * 0.01,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                event,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: isLast ? 0 : height * 0.01),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.green.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildContactItem(
                    Icons.email,
                    "Email",
                    tournamentInfo['contact']['email'],
                    Colors.green,
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: _buildContactItem(
                    Icons.phone,
                    "Phone",
                    tournamentInfo['contact']['phone'],
                    Colors.green,
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: _buildContactItem(
                    Icons.language,
                    "Website",
                    tournamentInfo['contact']['website'],
                    Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Social Media",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.012,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                _buildSocialItem(Icons.facebook, "Facebook", Colors.blue),
                SizedBox(width: width * 0.01),
                _buildSocialItem(Icons.camera_alt, "Instagram", Colors.pink),
                SizedBox(width: width * 0.01),
                _buildSocialItem(Icons.message, "Twitter", Colors.lightBlue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
      IconData icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(width * 0.01),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: width * 0.015,
          ),
          SizedBox(width: width * 0.01),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: width * 0.009,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: width * 0.01,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialItem(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.015,
        vertical: height * 0.008,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: width * 0.012,
          ),
          SizedBox(width: width * 0.005),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: width * 0.01,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
