// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:ui';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Track hover state for each featured card
  final List<bool> _isHoveredList = [false, false, false];

  // Track hover state for each match card
  final List<bool> _isMatchHoveredList = [false, false, false];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Darker background
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildFeaturedContent(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildUpcomingMatches(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildPlayerRankings(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildNewsUpdates(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildRecentResults(mq),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Hero Section with Carousel Effect
  Widget _buildHeroSection(MediaQueryData mq) {
    final List<String> carouselItems = [
      "https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/09/45713402-c65a-4d42-8344-9fae3c362b6e/GettyImages-1942239871.jpg",
      "https://resources.pulse.icc-cricket.com/ICC/photo/2024/01/14/e6679a96-e0cc-4b2f-8142-470f5abf31a0/India.jpg",
      "https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/08/3d7b5e7f-7f20-447d-8fb3-77dd252c9e98/Rohit-Sharma.jpg",
    ];

    final List<String> carouselTitles = [
      "DC vs KKR\nIPL 2024",
      "MI vs RCB\nIPL 2024",
      "CSK vs SRH\nIPL 2024",
    ];

    return FadeIn(
      child: CarouselSlider(
        options: CarouselOptions(
          height: mq.size.height * 0.4, // Reduced from 0.5
          autoPlay: true, // Auto-play the carousel
          enlargeCenterPage: true, // Enlarge the center card
          viewportFraction: 0.85, // Reduced from 0.9
          autoPlayInterval: const Duration(seconds: 3), // Auto-play interval
          autoPlayAnimationDuration:
              const Duration(milliseconds: 800), // Animation duration
          autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
          pauseAutoPlayOnTouch: true, // Pause auto-play on touch
        ),
        items: carouselItems.asMap().entries.map((entry) {
          int index = entry.key;
          String imageUrl = entry.value;
          return _buildHeroCard(mq, carouselTitles[index], imageUrl);
        }).toList(),
      ),
    );
  }

  /// ✅ Hero Card
  Widget _buildHeroCard(MediaQueryData mq, String title, String imageUrl) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 6), // Reduced from 8
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(mq.size.width * 0.03), // Smaller padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: mq.size.width * 0.02, // Reduced from 0.03
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.01),
                  ElevatedButton(
                    onPressed: () {
                      // Add action for "Watch Live"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.02,
                        vertical: mq.size.height * 0.015,
                      ), // Smaller button
                    ),
                    child: Text(
                      "Watch Live",
                      style: GoogleFonts.lato(
                        fontSize: mq.size.width * 0.01, // Reduced from 0.015
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Featured Content Section
  Widget _buildFeaturedContent(MediaQueryData mq) {
    return ZoomIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.whatshot, color: Colors.orange, size: 20),
              SizedBox(width: mq.size.width * 0.01),
              Text(
                "Featured Content",
                style: GoogleFonts.poppins(
                  fontSize: mq.size.width * 0.013, // Reduced from 0.015
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: mq.size.height * 0.01), // Reduced spacing
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFeaturedCard(mq, "Top Stories", 0,
                    "https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/09/45713402-c65a-4d42-8344-9fae3c362b6e/GettyImages-1942239871.jpg"),
                SizedBox(width: mq.size.width * 0.02), // Spacing between cards
                _buildFeaturedCard(mq, "Match Highlights", 1,
                    "https://resources.pulse.icc-cricket.com/ICC/photo/2024/01/14/e6679a96-e0cc-4b2f-8142-470f5abf31a0/India.jpg"),
                SizedBox(width: mq.size.width * 0.02), // Spacing between cards
                _buildFeaturedCard(mq, "Player Spotlight", 2,
                    "https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/08/3d7b5e7f-7f20-447d-8fb3-77dd252c9e98/Rohit-Sharma.jpg"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Featured Card with Individual Hover Effect
  Widget _buildFeaturedCard(
      MediaQueryData mq, String title, int index, String imageUrl) {
    return FadeInUp(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) =>
            setState(() => _isHoveredList[index] = true), // Hover starts
        onExit: (_) =>
            setState(() => _isHoveredList[index] = false), // Hover ends
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Animation duration
          curve: Curves.easeOutQuint, // Smooth animation
          transform: Matrix4.identity()
            ..scale(_isHoveredList[index] ? 1.05 : 1.0)
            ..translate(0.0, _isHoveredList[index] ? -8.0 : 0.0),
          width: mq.size.width * 0.22, // Reduced from 0.25
          height: mq.size.height * 0.22, // Reduced from 0.25
          margin:
              EdgeInsets.only(right: mq.size.width * 0.02), // Reduced margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHoveredList[index]
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                : [], // No shadow when not hovered
          ),
          child: Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Title Text (Visible only on hover)
              if (_isHoveredList[index])
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: mq.size.width * 0.015, // Reduced from 0.018
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Upcoming Matches Section
  Widget _buildUpcomingMatches(MediaQueryData mq) {
    return SlideInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📅 Upcoming Matches",
            style: GoogleFonts.lato(
              fontSize: mq.size.width * 0.015, // Reduced from 0.02
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: mq.size.height * 0.01), // Reduced spacing
          SizedBox(
            height: mq.size.height * 0.3, // Adjusted height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Number of match cards
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: mq.size.width * 0.02), // Spacing between cards
                  child:
                      _buildMatchCard(mq, "MI vs RCB", "March 20, 2024", index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Match Card with Hover Effect
  Widget _buildMatchCard(
      MediaQueryData mq, String teams, String date, int index) {
    return MouseRegion(
      onEnter: (_) =>
          setState(() => _isMatchHoveredList[index] = true), // Hover starts
      onExit: (_) =>
          setState(() => _isMatchHoveredList[index] = false), // Hover ends
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Animation duration
        curve: Curves.easeOutQuint, // Smooth animation
        transform: Matrix4.identity()
          ..translate(0.0,
              _isMatchHoveredList[index] ? -10.0 : 0.0), // Move up on hover
        width: mq.size.width * 0.22, // Reduced from 0.25
        padding: EdgeInsets.all(mq.size.width * 0.01),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[900]!,
              Colors.grey[850]!,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isMatchHoveredList[index]
                ? Colors.blue.withOpacity(0.5)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: _isMatchHoveredList[index]
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : [], // No shadow when not hovered
        ),
        child: Stack(
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Stadium/wankhede.jpg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Tournament Name and Date (Visible only on hover)
            if (_isMatchHoveredList[index])
              Positioned(
                top: 8,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IPL 2024", // Tournament name
                      style: GoogleFonts.lato(
                        fontSize: mq.size.width * 0.012, // Reduced from 0.015
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.005), // Reduced spacing
                    Text(
                      date,
                      style: GoogleFonts.lato(
                        fontSize: mq.size.width * 0.008, // Reduced from 0.01
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

            // Team Name (Always visible at the bottom)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  teams,
                  style: GoogleFonts.lato(
                    fontSize: mq.size.width * 0.015, // Reduced from 0.02
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Recent Results Section
  Widget _buildRecentResults(MediaQueryData mq) {
    final List<Map<String, dynamic>> recentMatches = [
      {
        'team1': {
          'name': 'MI',
          'score': '213/3',
          'logo':
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png'
        },
        'team2': {
          'name': 'CSK',
          'score': '206/4',
          'logo':
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/logos/Roundbig/CSKroundbig.png'
        },
        'result': 'MI won by 7 runs',
        'motm': 'Rohit Sharma',
        'venue': 'Wankhede Stadium, Mumbai',
        'date': 'March 20, 2024',
      },
      {
        'team1': {
          'name': 'RCB',
          'score': '185/6',
          'logo':
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Logos/Roundbig/RCBroundbig.png'
        },
        'team2': {
          'name': 'GT',
          'score': '189/4',
          'logo':
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/GT/Logos/Roundbig/GTroundbig.png'
        },
        'result': 'GT won by 6 wickets',
        'motm': 'Shubman Gill',
        'venue': 'M.Chinnaswamy Stadium, Bangalore',
        'date': 'March 19, 2024',
      },
    ];

    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.trophy,
                  color: Colors.amber, size: mq.size.width * 0.015),
              SizedBox(width: mq.size.width * 0.01),
              Text(
                "Recent Results",
                style: GoogleFonts.poppins(
                  fontSize: mq.size.width * 0.015,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: mq.size.height * 0.02),
          ...recentMatches
              .map((match) => _buildRestyledResultCard(mq, match))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildRestyledResultCard(
      MediaQueryData mq, Map<String, dynamic> match) {
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[900]!.withOpacity(0.9),
            Colors.grey[850]!.withOpacity(0.9),
          ],
        ),
        border: Border.all(color: Colors.grey[800]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.all(mq.size.width * 0.015),
            child: Column(
              children: [
                // Teams and Scores
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTeamInfo(mq, match['team1']),
                    Column(
                      children: [
                        Text(
                          'VS',
                          style: GoogleFonts.poppins(
                            color: Colors.white60,
                            fontSize: mq.size.width * 0.01,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.01,
                            vertical: mq.size.height * 0.005,
                          ),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Completed',
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: mq.size.width * 0.008,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildTeamInfo(mq, match['team2']),
                  ],
                ),
                Divider(color: Colors.grey[800], height: mq.size.height * 0.02),
                // Match Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDetailItem(mq, FontAwesomeIcons.trophy, Colors.amber,
                        match['result']),
                    _buildDetailItem(mq, FontAwesomeIcons.medal, Colors.blue,
                        "MoM: ${match['motm']}"),
                    _buildDetailItem(mq, FontAwesomeIcons.locationDot,
                        Colors.red, match['venue']),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamInfo(MediaQueryData mq, Map<String, dynamic> team) {
    return Column(
      children: [
        Container(
          width: mq.size.width * 0.04,
          height: mq.size.width * 0.04,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(team['logo']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: mq.size.height * 0.01),
        Text(
          team['name'],
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: mq.size.width * 0.012,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          team['score'],
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: mq.size.width * 0.01,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(
      MediaQueryData mq, IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: mq.size.width * 0.012),
        SizedBox(width: mq.size.width * 0.005),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: mq.size.width * 0.01,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerRankings(MediaQueryData mq) {
    return SlideInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🏏 Player Rankings",
            style: GoogleFonts.poppins(
              fontSize: mq.size.width * 0.015,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: mq.size.height * 0.02),
          Container(
            padding: EdgeInsets.all(mq.size.width * 0.015),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.blue.withOpacity(0.3)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildRankingItem(mq, "Virat Kohli", "Batting", "1", "India"),
                _buildRankingItem(
                    mq, "Jasprit Bumrah", "Bowling", "2", "India"),
                _buildRankingItem(
                    mq, "Ben Stokes", "All-Rounder", "3", "England"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingItem(MediaQueryData mq, String name, String category,
      String rank, String country) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "#$rank",
            style: GoogleFonts.poppins(
              color: Colors.amber,
              fontSize: mq.size.width * 0.012,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: mq.size.width * 0.012,
            ),
          ),
          Text(
            category,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: mq.size.width * 0.01,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              country,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: mq.size.width * 0.01,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsUpdates(MediaQueryData mq) {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📰 Latest Cricket News",
            style: GoogleFonts.poppins(
              fontSize: mq.size.width * 0.015,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: mq.size.height * 0.02),
          Container(
            height: mq.size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: mq.size.width * 0.3,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withOpacity(0.3),
                        Colors.blue.withOpacity(0.3)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/09/45713402-c65a-4d42-8344-9fae3c362b6e/GettyImages-1942239871.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent],
                          ),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Breaking Cricket News ${index + 1}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: mq.size.width * 0.012,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Latest updates from the world of cricket",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: mq.size.width * 0.01,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTeamStats(MediaQueryData mq) {
  return FadeInLeft(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(FontAwesomeIcons.chartLine,
                color: Colors.green, size: mq.size.width * 0.015),
            SizedBox(width: mq.size.width * 0.01),
            Text(
              "Team Statistics",
              style: GoogleFonts.poppins(
                fontSize: mq.size.width * 0.015,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: mq.size.height * 0.02),
        Container(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.withOpacity(0.3),
                Colors.purple.withOpacity(0.3)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[800]!, width: 1),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard(mq, "Mumbai Indians", "65%", "Win Rate"),
                  _buildStatCard(
                      mq, "Chennai Super Kings", "180+", "Matches Won"),
                  _buildStatCard(
                      mq, "Royal Challengers", "190.5", "Highest Score"),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatCard(
    MediaQueryData mq, String team, String value, String label) {
  return Container(
    width: mq.size.width * 0.2,
    padding: EdgeInsets.all(mq.size.width * 0.01),
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey[800]!, width: 1),
    ),
    child: Column(
      children: [
        Text(
          team,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: mq.size.width * 0.01,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: mq.size.height * 0.01),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.green,
            fontSize: mq.size.width * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: mq.size.width * 0.008,
          ),
        ),
      ],
    ),
  );
}
