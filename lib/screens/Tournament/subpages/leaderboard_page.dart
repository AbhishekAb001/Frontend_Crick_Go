import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Tournament Leaderboard',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: Row(
              children: [
                _buildLeaderboardSection(
                  width,
                  height,
                  'Top Batsmen',
                  [
                    {
                      'name': 'Virat Kohli',
                      'team': 'Royal Challengers',
                      'image': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/2.png',
                      'stat': '264 runs',
                      'detail': 'Avg: 52.80 | SR: 147.32',
                    },
                    {
                      'name': 'Rohit Sharma',
                      'team': 'Mumbai Indians',
                      'image': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/6.png',
                      'stat': '228 runs',
                      'detail': 'Avg: 45.60 | SR: 142.50',
                    },
                  ],
                ),
                SizedBox(width: width * 0.02),
                _buildLeaderboardSection(
                  width,
                  height,
                  'Top Bowlers',
                  [
                    {
                      'name': 'Jasprit Bumrah',
                      'team': 'Mumbai Indians',
                      'image': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/1.png',
                      'stat': '12 wickets',
                      'detail': 'Econ: 6.25 | Avg: 15.33',
                    },
                    {
                      'name': 'Mohammed Shami',
                      'team': 'Gujarat Titans',
                      'image': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/47.png',
                      'stat': '10 wickets',
                      'detail': 'Econ: 7.15 | Avg: 18.40',
                    },
                  ],
                ),
                SizedBox(width: width * 0.02),
                _buildLeaderboardSection(
                  width,
                  height,
                  'Best Fielders',
                  [
                    {
                      'name': 'Ravindra Jadeja',
                      'team': 'Chennai Super Kings',
                      'image': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/9.png',
                      'stat': '6 catches',
                      'detail': '2 run outs | 98% success',
                    },
                    {
                      'name': 'Faf du Plessis',
                      'team': 'Royal Challengers',
                      'image': 'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/94.png',
                      'stat': '5 catches',
                      'detail': '1 run out | 96% success',
                    },
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardSection(
    double width,
    double height,
    String title,
    List<Map<String, String>> players,
  ) {
    return Expanded(
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.blue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.015,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.012,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  padding: EdgeInsets.all(width * 0.01),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      padding: EdgeInsets.all(width * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.03,
                            height: width * 0.03,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: players[index]['image']!,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  players[index]['name']!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: width * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  players[index]['team']!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
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
                                players[index]['stat']!,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: width * 0.01,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                players[index]['detail']!,
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: width * 0.008,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}