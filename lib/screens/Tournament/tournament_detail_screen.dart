import 'package:flutter/material.dart';
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

  final List<Map<String, dynamic>> matches = [
    {
      'team1': 'Mumbai Indians',
      'team2': 'Chennai Super Kings',
      'date': '29 Mar 2024',
      'time': '7:30 PM',
      'venue': 'Wankhede Stadium, Mumbai',
      'status': 'Upcoming',
      'team1Logo': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png',
      'team2Logo': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/logos/Roundbig/CSKroundbig.png',
    },
    {
      'team1': 'Royal Challengers',
      'team2': 'Rajasthan Royals',
      'date': '30 Mar 2024',
      'time': '3:30 PM',
      'venue': 'M.Chinnaswamy Stadium, Bangalore',
      'status': 'Upcoming',
      'team1Logo': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Logos/Roundbig/RCBroundbig.png',
      'team2Logo': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RR/Logos/Roundbig/RRroundbig.png',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTournamentInfo(),
            _buildMatchesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        height: height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.tournament['image']!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tournament['name']!,
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '28 Mar - 30 Apr 2024',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.012,
                      color: Colors.white70,
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

  Widget _buildTournamentInfo() {
    return SlideInLeft(
      duration: const Duration(milliseconds: 800),
      child: Container(
        margin: EdgeInsets.all(width * 0.02),
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: Colors.blue[900]?.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Total Teams', '${widget.tournament['teams']} Teams'),
            _buildInfoRow('Duration', widget.tournament['duration']!),
            _buildInfoRow('Format', 'T20'),
            _buildInfoRow('Prize Pool', '₹1,00,00,000'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: width * 0.01,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: width * 0.01,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Text(
            'Matches',
            style: GoogleFonts.poppins(
              fontSize: width * 0.015,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ...matches.asMap().entries.map((entry) {
          final index = entry.key;
          final match = entry.value;
          return FadeInUp(
            delay: Duration(milliseconds: 200 * index),
            duration: const Duration(milliseconds: 500),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              padding: EdgeInsets.all(width * 0.015),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.purple.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTeamInfo(match['team1'], match['team1Logo']),
                      Text(
                        'VS',
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.015,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      _buildTeamInfo(match['team2'], match['team2Logo']),
                    ],
                  ),
                  Divider(color: Colors.white.withOpacity(0.1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${match['date']} | ${match['time']}',
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.009,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        match['venue'],
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.009,
                          color: Colors.white70,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01,
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          match['status'],
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.009,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTeamInfo(String teamName, String logoUrl) {
    return Row(
      children: [
        Container(
          width: width * 0.03,
          height: width * 0.03,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(logoUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: width * 0.01),
        Text(
          teamName,
          style: GoogleFonts.poppins(
            fontSize: width * 0.01,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}