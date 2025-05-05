import 'package:cricket_management/controllers/page_controller.dart';
import 'package:cricket_management/screens/LiveScore/tabs/analysis_tab.dart';
import 'package:cricket_management/screens/LiveScore/tabs/commentary_tab.dart';
import 'package:cricket_management/screens/LiveScore/tabs/live_tab.dart';
import 'package:cricket_management/screens/LiveScore/tabs/scorecard_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cricket_management/screens/LiveScore/tabs/cricheroes_tab.dart';
import 'package:cricket_management/screens/LiveScore/tabs/mvp_tab.dart';
import 'package:cricket_management/screens/LiveScore/tabs/teams_tab.dart';
import 'package:cricket_management/screens/LiveScore/tabs/gallery_tab.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MatchDetailScreen extends StatefulWidget {
  final Map<String, dynamic> matchInfo;

  const MatchDetailScreen({super.key, required this.matchInfo});

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen>
    with SingleTickerProviderStateMixin {
  PageNavigationController pageController =
      Get.find<PageNavigationController>();
  int selectedMenuIndex = 0;
  late double width;
  late double height;
  late TabController _tabController;
  int selectedPageIndex = 0;
  List<Widget> contentPages = [
    const LiveTab(),
    ScorecardTab(),
    const CommentaryTab(),
    const AnalysisTab(),
    CricheroesTab(),
    const MVPTab(),
    const TeamsTab(),
    const GalleryTab(),
  ];

  // Track hover state for tab items
  late List<bool> _isHovering;

  Map<String, dynamic> get matchInfo => widget.matchInfo;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedMenuIndex = _tabController.index;
      });
    });
    _isHovering = List<bool>.filled(8, false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    _buildHeader(),
                    SizedBox(height: height * 0.02),
                    _buildMenuBar(),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: height * 0.6,
                      ),
                      child: contentPages[selectedMenuIndex],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: width,
        // height: height * 0.22, // Reduced from 0.25 for better proportions
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
                  'https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(width * 0.015), // Reduced padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Better spacing
                children: [
                  // Rest of the content remains the same
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    pageController.navigateToSub(1, -1);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                              Text(
                                'Indoor Series',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: width * 0.014,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' (League Matches)',
                                style: GoogleFonts.poppins(
                                  color: Colors.white60,
                                  fontSize: width * 0.012,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: width * 0.012,
                              ),
                              SizedBox(width: width * 0.004),
                              Text(
                                'Indoor, Jamnagar, Box Cricket',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: width * 0.01,
                                ),
                              ),
                              SizedBox(width: width * 0.01),
                              Icon(
                                Icons.sports_cricket,
                                color: Colors.green[300],
                                size: width * 0.012,
                              ),
                              SizedBox(width: width * 0.004),
                              Text(
                                '10 Ov.',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: width * 0.01,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.005),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white70,
                                size: width * 0.012,
                              ),
                              SizedBox(width: width * 0.004),
                              Text(
                                '02-Apr-25 10:17 PM',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: width * 0.01,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'LIVE',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Toss: wizards opt to bat',
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: width * 0.01,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01), // Reduced from 0.02
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTeamInfo('WIZARDS',
                          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png'),
                      _buildScoreInfo('5/0', '(0.2 Ov)'),
                    ],
                  ),
                  SizedBox(height: height * 0.01), // Reduced from 0.015
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTeamInfo('FORTNER BOYS',
                          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/logos/Roundbig/CSKroundbig.png'),
                      Text(
                        'Yet to Bat',
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                          fontSize: width * 0.012,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(String teamName, String logoUrl) {
    return Row(
      children: [
        Container(
          width: width * 0.03,
          height: width * 0.03,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.015),
            child: CachedNetworkImage(
              imageUrl: logoUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.sports_cricket,
                color: Colors.white,
                size: width * 0.015,
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.01),
        Text(
          teamName,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.016,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreInfo(String score, String overs) {
    return Row(
      children: [
        Text(
          score,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: width * 0.005),
        Text(
          overs,
          style: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: width * 0.01,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuBar() {
    final tabs = [
      "LIVE",
      "SCORECARD",
      "COMMENTARY",
      "ANALYSIS",
      "CRICHEROES",
      "MVP",
      "TEAMS",
      "GALLERY"
    ];

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
          children: List.generate(
            tabs.length,
            (index) =>
                _buildMenuItem(tabs[index], _tabController.index == index, () {
              _tabController.animateTo(index);
            }),
          ),
        ),
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

  Widget _buildSelectedContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildLiveTab(),
        Center(
            child: Text('Scorecard Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
        Center(
            child: Text('Commentary Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
        Center(
            child: Text('Analysis Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
        Center(
            child: Text('Cricheroes Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
        Center(
            child: Text('MVP Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
        Center(
            child: Text('Teams Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
        Center(
            child: Text('Gallery Tab',
                style: GoogleFonts.poppins(color: Colors.white))),
      ],
    );
  }

  Widget _buildLiveTab() {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Current Batsmen'),
            SizedBox(height: height * 0.01),
            _buildBatsmanRow('Rohit Sharma', '22', '18', '2', '1', '122.22'),
            _buildBatsmanRow('Virat Kohli', '15', '12', '1', '1', '125.00'),
            SizedBox(height: height * 0.02),
            _buildSectionTitle('Current Bowler'),
            SizedBox(height: height * 0.01),
            _buildBowlerRow('Jasprit Bumrah', '2.3', '0', '15', '1', '6.00'),
            SizedBox(height: height * 0.02),
            _buildSectionTitle('Last 6 Balls'),
            SizedBox(height: height * 0.01),
            _buildLastBallsRow(['1', 'W', '0', '4', '2', '6']),
            SizedBox(height: height * 0.02),
            _buildSectionTitle('Partnership'),
            SizedBox(height: height * 0.01),
            _buildStatCard('5', 'runs, 0.2 overs, RR: 15.00'),
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

  Widget _buildBatsmanRow(String name, String runs, String balls, String fours,
      String sixes, String strikeRate) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.008), // Reduced from 0.01
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.012, // Added specific horizontal padding
          vertical: height * 0.008, // Added specific vertical padding
        ),
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
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                runs,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                balls,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                fours,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                sixes,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                strikeRate,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBowlerRow(String name, String overs, String maidens, String runs,
      String wickets, String economy) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
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
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                overs,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                maidens,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                runs,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                wickets,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                economy,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastBallsRow(List<String> balls) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: balls.map((ball) {
        Color ballColor;
        Color textColor;
        if (ball == 'W') {
          ballColor = Colors.red.withOpacity(0.3);
          textColor = Colors.red;
        } else if (ball == '4') {
          ballColor = Colors.blue.withOpacity(0.3);
          textColor = Colors.blue;
        } else if (ball == '6') {
          ballColor = Colors.green.withOpacity(0.3);
          textColor = Colors.green;
        } else if (ball == '0') {
          ballColor = Colors.grey.withOpacity(0.3);
          textColor = Colors.grey;
        } else {
          ballColor = Colors.amber.withOpacity(0.3);
          textColor = Colors.amber;
        }

        return Bounce(
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: width * 0.025, // Reduced from 0.03 for better spacing
            height: width * 0.025, // Reduced from 0.03 for better spacing
            margin: EdgeInsets.only(right: width * 0.008), // Reduced from 0.01
            decoration: BoxDecoration(
              color: ballColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: textColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              ball,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: width * 0.012,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return ElasticIn(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.all(width * 0.012), // Reduced from 0.015
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.035, // Reduced from 0.04
              height: width * 0.035, // Reduced from 0.04
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: width * 0.015, // Reduced from 0.018
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: width * 0.01),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.012,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
