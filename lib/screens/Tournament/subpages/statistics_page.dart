import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/screens/Tournament/tournament_detail_screen.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchStateById();
  }

  Map<String, dynamic> state = {};

  bool isLoading = false;

  void _fetchStateById() async {
    setState(() {
      isLoading = true;
    });
    String? token = await AuthSharedP().getToken();
    log("State id : ${tournament["statId"]}");
    try {
      http.Response response = await http.get(
        Uri.parse(
            "http://localhost:8080/stat/get?statId=${tournament["statId"]}"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        setState(() {
          state = decodedResponse;
          isLoading = false;
        });
        log("State: $decodedResponse");
        log("MileStones string : ${state['mileStonesMap']}");
        log("MileStones  : ${state['mileStones']}");
        if (state['mileStonesMap'] != null && state['mileStonesMap'] is Map) {
          state['mileStonesMap'].forEach((key, value) {
            log('Milestone Key: $key, Value: $value');
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log("Exception while fetching state by id: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: (isLoading)
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blue, size: 25),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatsContent(width, height),
                          SizedBox(height: height * 0.025),
                          Text(
                            'Tournament Milestones',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: width * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          _buildMilestonesContent(width, height),
                          SizedBox(height: height * 0.02),
                          const Footer(),
                        ],
                      ),
              ],
            ),
    );
  }

  // Stats content widget
  Widget _buildStatsContent(double width, double height) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row of stats
            Row(
              children: [
                _buildStatBox(
                    width, height, state['matches'].toString(), 'Matches'),
                _buildStatBox(
                    width, height, state['innings'].toString(), 'Innings'),
                _buildStatBox(width, height, state['runs'].toString(), 'Runs'),
                _buildStatBox(
                    width, height, state['wickets'].toString(), 'Wickets'),
                _buildStatBox(
                    width, height, state['balls'].toString(), 'Balls'),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Second row of stats
            Row(
              children: [
                _buildStatBox(
                    width, height, state['extras'].toString(), 'Extras'),
                _buildStatBox(
                    width, height, state['fours'].toString(), 'Fours'),
                _buildStatBox(
                    width, height, state['sixes'].toString(), 'Sixes'),
                _buildStatBox(
                    width, height, state['fifties'].toString(), '50\'s'),
                _buildStatBox(
                    width, height, state['hundreds'].toString(), '100\'s'),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Third row of stats
            Row(
              children: [
                _buildStatBox(
                    width,
                    height,
                    state['fiftyPlusPartnerships'].toString(),
                    '50+ Partnership',
                    isSmall: true),
                _buildStatBox(
                    width,
                    height,
                    state['hundredPlusPartnerships'].toString(),
                    '100+ Partnership',
                    isSmall: true),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Fourth row of stats
            Row(
              children: [
                _buildStatBox(
                    width, height, state['stumpings'].toString(), 'Stumpings',
                    isSmall: true),
                _buildStatBox(
                    width, height, state['catches'].toString(), 'Catches',
                    isSmall: true),
                _buildStatBox(
                    width, height, state['dotBalls'].toString(), 'Dot balls',
                    isSmall: true),
                _buildStatBox(
                    width, height, state['maidens'].toString(), 'Maidens',
                    isSmall: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Milestones content widget
  Widget _buildMilestonesContent(double width, double height) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Container(
        constraints: BoxConstraints(
          minHeight: height * 0.4,
          maxHeight: height * 0.6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.all(width * 0.02),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: (state['mileStonesMap'] != null &&
                  state['mileStonesMap'] is Map)
              ? (state['mileStonesMap'] as Map).entries.map<Widget>((entry) {
                  return _buildMilestone(
                    width,
                    entry.key,
                    entry.value,
                    Icons.sports_cricket,
                  );
                }).toList()
              : [
                  Center(
                    child: Text(
                      'No milestones available',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }

  Widget _buildStatBox(double width, double height, String value, String label,
      {bool isSmall = false}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.01, vertical: height * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: isSmall ? width * 0.011 : width * 0.015,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.005),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.003),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isSmall ? width * 0.007 : width * 0.008,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestone(
    double width,
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: width * 0.01),
      padding: EdgeInsets.all(width * 0.01),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.01),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: width * 0.02,
            ),
          ),
          SizedBox(width: width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.01,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.009,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
