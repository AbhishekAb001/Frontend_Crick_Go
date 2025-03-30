import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

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
              'Tournament Statistics',
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
                Expanded(
                  child: Column(
                    children: [
                      _buildStatCard(
                        width,
                        height,
                        'Highest Score',
                        '189/4',
                        'Mumbai Indians vs CSK',
                        Icons.trending_up,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildStatCard(
                        width,
                        height,
                        'Most Sixes',
                        '24',
                        'Royal Challengers',
                        Icons.sports_cricket,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Column(
                    children: [
                      _buildStatCard(
                        width,
                        height,
                        'Best Bowling',
                        '5/21',
                        'Jasprit Bumrah (MI)',
                        Icons.sports_baseball,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildStatCard(
                        width,
                        height,
                        'Highest Partnership',
                        '156',
                        'Kohli - du Plessis (RCB)',
                        Icons.people,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Expanded(
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
                padding: EdgeInsets.all(width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tournament Milestones',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildMilestone(
                            width,
                            'Fastest Fifty',
                            '21 balls by MS Dhoni',
                            Icons.speed,
                          ),
                          _buildMilestone(
                            width,
                            'Most Catches',
                            '6 catches by Ravindra Jadeja',
                            Icons.catching_pokemon,
                          ),
                          _buildMilestone(
                            width,
                            'Highest Individual Score',
                            '96 runs by Virat Kohli',
                            Icons.person_outline,
                          ),
                          _buildMilestone(
                            width,
                            'Best Economy Rate',
                            '6.25 by Jasprit Bumrah',
                            Icons.trending_down,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    double width,
    double height,
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Container(
        height: height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: width * 0.03,
            ),
            SizedBox(height: height * 0.01),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
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
