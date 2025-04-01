import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['OVERALL', 'MILESTONES'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats tabs
          SizedBox(height: height * 0.025),

          _buildTabBar(width, height),

          SizedBox(height: height * 0.025),

          // TabBarView with fixed height
          SizedBox(
            height: height * 0.7,
            child: TabBarView(
              controller: _tabController,
              children: [
                // OVERALL tab content
                _buildStatsContent(width, height),

                // MILESTONES tab content
                _buildMilestonesContent(width, height),
              ],
            ),
          ),

          // Add spacing
          SizedBox(height: height * 0.02),

          // Add footer
          const Footer(),
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
                _buildStatBox(width, height, '16', 'Matches'),
                _buildStatBox(width, height, '58', 'Innings'),
                _buildStatBox(width, height, '4654', 'Runs'),
                _buildStatBox(width, height, '308', 'Wickets'),
                _buildStatBox(width, height, '3618', 'Balls'),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Second row of stats
            Row(
              children: [
                _buildStatBox(width, height, '382', 'Extras'),
                _buildStatBox(width, height, '375', 'Fours'),
                _buildStatBox(width, height, '149', 'Sixes'),
                _buildStatBox(width, height, '2', '50\'s'),
                _buildStatBox(width, height, '0', '100\'s'),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Third row of stats
            Row(
              children: [
                _buildStatBox(width, height, '9', '50+ Partnership',
                    isSmall: true),
                _buildStatBox(width, height, '0', '100+ Partnership',
                    isSmall: true),
                _buildStatBox(width, height, '3', 'Maidens', isSmall: true),
                _buildStatBox(width, height, '1537', 'Dot balls',
                    isSmall: true),
                _buildStatBox(width, height, '127', 'Catches', isSmall: true),
              ],
            ),

            SizedBox(height: height * 0.015),

            // Fourth row of stats
            Row(
              children: [
                _buildStatBox(width, height, '31', 'Stumpings', isSmall: true),
                _buildStatBox(width, height, '51.44', 'BDR%', isSmall: true),
                _buildStatBox(width, height, '6.90', 'BDR Freq.',
                    isSmall: true),
                _buildStatBox(width, height, '2.35', 'DB Freq.', isSmall: true),
                _buildStatBox(width, height, '42.48', 'DB%', isSmall: true),
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
            _buildMilestone(
              width,
              'Most Sixes',
              '12 sixes by Hardik Pandya',
              Icons.sports_cricket,
            ),
            _buildMilestone(
              width,
              'Most Fours',
              '14 fours by Rohit Sharma',
              Icons.sports_cricket,
            ),
            _buildMilestone(
              width,
              'Best Bowling Figures',
              '5/23 by Jasprit Bumrah',
              Icons.sports_cricket,
            ),
            _buildMilestone(
              width,
              'Highest Partnership',
              '112 runs by Rohit & Virat',
              Icons.people,
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
                _tabController.animateTo(index);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: _tabController.index == index
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _tabController.index == index
                      ? Colors.white.withOpacity(0.3)
                      : Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: GoogleFonts.poppins(
                  color: _tabController.index == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.7),
                  fontSize: width * 0.012,
                  fontWeight: _tabController.index == index
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

  Widget _buildStatBox(double width, double height, String value, String label,
      {bool isSmall = false, LinearGradient? gradient}) {
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
