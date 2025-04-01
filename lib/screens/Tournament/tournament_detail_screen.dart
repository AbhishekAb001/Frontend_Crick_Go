// ignore_for_file: deprecated_member_use
import 'package:cricket_management/controllers/page_controller.dart';
import 'package:cricket_management/screens/Tournament/subpages/leaderboard_page.dart';
import 'package:cricket_management/screens/Tournament/subpages/matches_page.dart';
import 'package:cricket_management/screens/Tournament/subpages/teams_page.dart';
import 'package:cricket_management/screens/Tournament/subpages/statistics_page.dart';
import 'package:cricket_management/screens/Tournament/subpages/gallery_page.dart';
import 'package:cricket_management/screens/Tournament/subpages/about_page.dart';
import 'package:cricket_management/widgets/points_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TournamentDetailScreen extends StatefulWidget {
  final Map<String, String> tournament;

  const TournamentDetailScreen({Key? key, required this.tournament})
      : super(key: key);

  @override
  State<TournamentDetailScreen> createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  late double width;
  late double height;
  final PageNavigationController _pageController =
      Get.find<PageNavigationController>();

  List<Widget> contentPages = [
    const MatchesPage(),
    const TeamsPage(),
    const SizedBox(),
    const LeaderboardPage(),
    const StatisticsPage(),
    const GallaryPage(),
    const AboutPage(),
  ];

  final List<Map<String, dynamic>> matches = [
    {
      'team1': 'Mumbai Indians',
      'team2': 'Chennai Super Kings',
      'date': '29 Mar 2024',
      'time': '7:30 PM',
      'venue': 'Wankhede Stadium, Mumbai',
      'status': 'Upcoming',
      'team1Logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png',
      'team2Logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/logos/Roundbig/CSKroundbig.png',
    },
    {
      'team1': 'Royal Challengers',
      'team2': 'Rajasthan Royals',
      'date': '30 Mar 2024',
      'time': '3:30 PM',
      'venue': 'M.Chinnaswamy Stadium, Bangalore',
      'status': 'Upcoming',
      'team1Logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Logos/Roundbig/RCBroundbig.png',
      'team2Logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RR/Logos/Roundbig/RRroundbig.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: height * 0.02),
            _buildMenuBar(),
            SizedBox(height: height * 0.02),
            Container(
              constraints: BoxConstraints(
                minHeight: height * 0.8,
              ),
              child: (selectedMenuIndex == 2)
                  ? PointsTable.buildPointsTable(context)
                  : contentPages[selectedMenuIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: width,
        height: height * 0.35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.purple.withOpacity(0.3),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white.withOpacity(0.1), Colors.transparent],
                  ).createShader(rect);
                },
                child: Image.network(
                  widget.tournament['image'] ?? 'default_image_url',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        _pageController.navigateToMain(2);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: width * 0.02,
                      ),
                      padding: EdgeInsets.all(width * 0.008),
                      constraints: BoxConstraints(
                        minWidth: width * 0.03,
                        minHeight: width * 0.03,
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  _buildTournamentLogo(),
                  SizedBox(width: width * 0.02),
                  _buildTournamentInfo(),
                  const Spacer(),
                  _buildStatCard("22", "Total\nMatches", Colors.blue),
                  SizedBox(width: width * 0.02),
                  _buildStatCard("8", "Teams\nParticipating", Colors.purple),
                  SizedBox(width: width * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentLogo() {
    return Container(
      width: width * 0.12,
      height: width * 0.12,
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.1), // Changed from solid white to semi-transparent
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: widget.tournament['image'] ?? 'default_image_url',
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tournament['name'] ?? 'Tournament Name',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.02, // Reduced from 0.03
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: height * 0.008), // Reduced from 0.01
        Row(
          children: [
            Icon(Icons.location_on,
                color: Colors.white70,
                size: width * 0.012), // Reduced from 0.015
            SizedBox(width: width * 0.004), // Reduced from 0.005
            Text(
              widget.tournament['location'] ?? 'Location not specified',
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01, // Reduced from 0.015
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.008), // Reduced from 0.01
        Row(
          children: [
            Icon(Icons.calendar_today,
                color: Colors.white70,
                size: width * 0.012), // Reduced from 0.015
            SizedBox(width: width * 0.004), // Reduced from 0.005
            Text(
              "22nd March 2024 - 25th March 2024",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01, // Reduced from 0.015
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Update at class level
  int selectedMenuIndex = 0;

  Widget _buildMenuBar() {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: width,
        height: height * 0.08,
        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuItem("Matches", selectedMenuIndex == 0, () {
              setState(() => selectedMenuIndex = 0);
            }),
            _buildMenuItem("Teams", selectedMenuIndex == 1, () {
              setState(() => selectedMenuIndex = 1);
            }),
            _buildMenuItem("Points Table", selectedMenuIndex == 2, () {
              setState(() => selectedMenuIndex = 2);
            }),
            _buildMenuItem("Leaderboard", selectedMenuIndex == 3, () {
              setState(() => selectedMenuIndex = 3);
            }),
            _buildMenuItem("Statistics", selectedMenuIndex == 4, () {
              setState(() => selectedMenuIndex = 4);
            }),
            _buildMenuItem("Gallery", selectedMenuIndex == 5, () {
              setState(() => selectedMenuIndex = 5);
            }),
            _buildMenuItem("About", selectedMenuIndex == 6, () {
              setState(() => selectedMenuIndex = 6);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildTournamentScreen(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: height * 0.02),
                  _buildMenuBar(),
                  SizedBox(height: height * 0.02),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight * 0.6, // Adjusted height
                    ),
                    child: contentPages[selectedMenuIndex],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: Colors.blue.withOpacity(0.5), width: 1)
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.blue : Colors.white70,
            fontSize: width * 0.012,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      width: width * 0.08,
      height: width * 0.08,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Changed from solid white
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: width * 0.02,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white70, // Changed from black54
              fontSize: width * 0.009,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
