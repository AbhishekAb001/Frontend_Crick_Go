import 'package:cricket_management/controllers/page_controller.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';

class Player {
  final String name;
  final String localName;
  final String role;
  final String team;
  final String imageUrl;

  Player({
    required this.name,
    required this.localName,
    required this.role,
    required this.team,
    required this.imageUrl,
  });
}

class LiveMatch {
  final String team1;
  final String team2;
  final String score1;
  final String score2;
  final String matchStatus;
  final String team1Logo;
  final String team2Logo;
  final String tournamentName;
  final String venue;
  final String matchType;
  final List<Player> team1Players;
  final List<Player> team2Players;
  final String currentBatsman1;
  final String currentBatsman2;
  final String currentBowler;
  final String currentBatsman1Local;
  final String currentBatsman2Local;
  final String currentBowlerLocal;

  LiveMatch({
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
    required this.matchStatus,
    required this.team1Logo,
    required this.team2Logo,
    required this.tournamentName,
    required this.venue,
    required this.matchType,
    required this.team1Players,
    required this.team2Players,
    required this.currentBatsman1,
    required this.currentBatsman2,
    required this.currentBowler,
    required this.currentBatsman1Local,
    required this.currentBatsman2Local,
    required this.currentBowlerLocal,
  });
}

class LiveScorePage extends StatefulWidget {
  const LiveScorePage({super.key});

  @override
  _LiveScorePageState createState() => _LiveScorePageState();
}

class _LiveScorePageState extends State<LiveScorePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final PageNavigationController _pageNavigationController =
      Get.find<PageNavigationController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int selectedMatchIndex = 0;

  final List<LiveMatch> liveMatches = [
    LiveMatch(
      team1: 'Mumbai Indians',
      team2: 'Chennai Super Kings',
      score1: '245/6',
      score2: '182/4',
      matchStatus: 'Mumbai needs 64 runs in 28 balls',
      team1Logo:
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png',
      team2Logo:
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/Logos/Roundbig/CSKroundbig.png',
      tournamentName: 'Indian Premier League 2024',
      venue: 'Wankhede Stadium, Mumbai',
      matchType: 'T20',
      team1Players: [
        Player(
          name: 'Rohit Mishra',
          localName: 'रोहित मिश्रा',
          role: 'Batsman',
          team: 'Mumbai Indians',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Players/RohitSharma.png',
        ),
        Player(
          name: 'Manav Gore',
          localName: 'मानव गोरे',
          role: 'Wicket Keeper',
          team: 'Mumbai Indians',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Players/IshanKishan.png',
        ),
        Player(
          name: 'Suryakumar Yadav',
          localName: 'सूर्यकुमार यादव',
          role: 'Batsman',
          team: 'Mumbai Indians',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Players/SuryakumarYadav.png',
        ),
        Player(
          name: 'Hardik Pandya',
          localName: 'हार्दिक पंड्या',
          role: 'All Rounder',
          team: 'Mumbai Indians',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Players/HardikPandya.png',
        ),
      ],
      team2Players: [
        Player(
          name: 'Ruturaj Gaikwad',
          localName: 'रुतुराज गायकवाड',
          role: 'Batsman',
          team: 'Chennai Super Kings',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/Players/RuturajGaikwad.png',
        ),
        Player(
          name: 'Ravindra Jadeja',
          localName: 'रविंद्र जडेजा',
          role: 'All Rounder',
          team: 'Chennai Super Kings',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/Players/RavindraJadeja.png',
        ),
        Player(
          name: 'Deepak Chahar',
          localName: 'दीपक चाहर',
          role: 'Bowler',
          team: 'Chennai Super Kings',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/Players/DeepakChahar.png',
        ),
        Player(
          name: 'Shivam Dube',
          localName: 'शिवम दूबे',
          role: 'All Rounder',
          team: 'Chennai Super Kings',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/Players/ShivamDube.png',
        ),
      ],
      currentBatsman1: 'Rohit Mishra',
      currentBatsman2: 'Manav Gore',
      currentBowler: 'Ravindra Jadeja',
      currentBatsman1Local: 'रोहित मिश्रा',
      currentBatsman2Local: 'मानव गोरे',
      currentBowlerLocal: 'रविंद्र जडेजा',
    ),
    LiveMatch(
      team1: 'Royal Challengers Bangalore',
      team2: 'Kolkata Knight Riders',
      score1: '198/4',
      score2: '156/3',
      matchStatus: 'KKR needs 43 runs in 18 balls',
      team1Logo:
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Logos/Roundbig/RCBroundbig.png',
      team2Logo:
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/KKR/Logos/Roundbig/KKRroundbig.png',
      tournamentName: 'Indian Premier League 2024',
      venue: 'M. Chinnaswamy Stadium, Bangalore',
      matchType: 'T20',
      team1Players: [
        Player(
          name: 'Virat Kohli',
          localName: 'विराट कोहली',
          role: 'Batsman',
          team: 'Royal Challengers Bangalore',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Players/ViratKohli.png',
        ),
        Player(
          name: 'Faf du Plessis',
          localName: 'फाफ डु प्लेसिस',
          role: 'Batsman',
          team: 'Royal Challengers Bangalore',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Players/FafduPlessis.png',
        ),
        Player(
          name: 'Glenn Maxwell',
          localName: 'ग्लेन मैक्सवेल',
          role: 'All Rounder',
          team: 'Royal Challengers Bangalore',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Players/GlennMaxwell.png',
        ),
        Player(
          name: 'Mohammed Siraj',
          localName: 'मोहम्मद सिराज',
          role: 'Bowler',
          team: 'Royal Challengers Bangalore',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Players/MohammedSiraj.png',
        ),
      ],
      team2Players: [
        Player(
          name: 'Andre Russell',
          localName: 'एंड्रे रसेल',
          role: 'All Rounder',
          team: 'Kolkata Knight Riders',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/KKR/Players/AndreRussell.png',
        ),
        Player(
          name: 'Sunil Narine',
          localName: 'सुनील नारायण',
          role: 'All Rounder',
          team: 'Kolkata Knight Riders',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/KKR/Players/SunilNarine.png',
        ),
        Player(
          name: 'Varun Chakravarthy',
          localName: 'वरुण चक्रवर्ती',
          role: 'Bowler',
          team: 'Kolkata Knight Riders',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/KKR/Players/VarunChakravarthy.png',
        ),
        Player(
          name: 'Venkatesh Iyer',
          localName: 'वेंकटेश अय्यर',
          role: 'All Rounder',
          team: 'Kolkata Knight Riders',
          imageUrl:
              'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/KKR/Players/VenkateshIyer.png',
        ),
      ],
      currentBatsman1: 'Virat Kohli',
      currentBatsman2: 'Faf du Plessis',
      currentBowler: 'Andre Russell',
      currentBatsman1Local: 'विराट कोहली',
      currentBatsman2Local: 'फाफ डु प्लेसिस',
      currentBowlerLocal: 'एंड्रे रसेल',
    ),
  ];

  double getTextSize(double factor) =>
      MediaQuery.of(context).size.width * 0.01 * factor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // Animated background gradient
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color(0xFF0A0A0A),
                      Color(0xFF1A1A1A),
                    ],
                    stops: [_controller.value, _controller.value + 0.5],
                  ),
                ),
              );
            },
          ),
          // Main content
          Column(
            children: [
              FadeInDown(
                child: Container(
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.1), blurRadius: 12)
                    ],
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: liveMatches.length,
                    itemBuilder: (context, index) => _buildMatchItem(index),
                  ),
                ),
              ),
              Expanded(
                child: FadeInUp(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isDesktop ? 32 : 16),
                    child: Column(
                      children: [
                        ZoomIn(child: _buildScoreCard(size)),
                        SizedBox(height: size.height * 0.03),
                        SlideInRight(child: _buildStatsSection(size)),
                        SizedBox(height: size.height * 0.03),
                        FadeInUp(child: _buildCommentarySection(size)),
                        SizedBox(height: size.height * 0.02),
                        const Footer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    Widget _buildMatchItem(int index) {
    final match = liveMatches[index];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SlideInLeft(
        delay: Duration(milliseconds: 100 * index),
        child: GestureDetector(
          onTap: () => setState(() => selectedMatchIndex = index),
          onDoubleTap: () {
            _pageNavigationController.navigateToSub(1, 0);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width * 0.3,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedMatchIndex == index
                  ? Colors.indigo.withOpacity(0.3)
                  : Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedMatchIndex == index
                    ? Colors.blue.withOpacity(0.5)
                    : Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: selectedMatchIndex == index
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.transparent,
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  match.tournamentName,
                  style: GoogleFonts.poppins(
                    fontSize: getTextSize(0.8),
                    color: Colors.blue[300],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${match.team1} vs ${match.team2}',
                  style: GoogleFonts.poppins(
                    fontSize: getTextSize(1.2),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  match.matchStatus,
                  style: GoogleFonts.poppins(
                    fontSize: getTextSize(0.9),
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  match.venue,
                  style: GoogleFonts.poppins(
                    fontSize: getTextSize(0.8),
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(Size size) {
    final match = liveMatches[selectedMatchIndex];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
            'https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/09/45713402-c65a-4d42-8344-9fae3c362b6e/GettyImages-1942239871.jpg',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.8),
            BlendMode.darken,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.withOpacity(0.4),
            Colors.purple.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTeamScore(match.team1, match.score1, match.team1Logo),
              _buildLiveIndicator(),
              _buildTeamScore(match.team2, match.score2, match.team2Logo),
            ],
          ),
          const SizedBox(height: 20),
          _buildMatchProgress(match),
        ],
      ),
    );
  }

  Widget _buildLiveIndicator() {
    return Column(
      children: [
        Text(
          'VS',
          style: GoogleFonts.poppins(
            fontSize: getTextSize(1.2),
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2 + _controller.value * 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      Colors.green.withOpacity(0.5 + _controller.value * 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.green
                          .withOpacity(0.5 + _controller.value * 0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'LIVE',
                    style: GoogleFonts.poppins(
                      fontSize: getTextSize(0.8),
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMatchProgress(LiveMatch match) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            match.matchStatus,
            style: GoogleFonts.poppins(
              fontSize: getTextSize(1.1),
              color: Colors.indigo[300],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.75, // Calculate based on match progress
            backgroundColor: Colors.grey[800],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamScore(String team, String score, String logoUrl) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: logoUrl,
          height: getTextSize(4.0),
          width: getTextSize(4.0),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(height: 8),
        Text(
          team,
          style: GoogleFonts.poppins(
            fontSize: getTextSize(1.2),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          score,
          style: GoogleFonts.robotoMono(
            fontSize: getTextSize(1.1),
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SlideInLeft(
            child: _buildBatsmenStats(),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: SlideInRight(
            child: _buildBowlerStats(),
          ),
        ),
      ],
    );
  }

  Widget _buildBatsmenStats() {
    final match = liveMatches[selectedMatchIndex];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batsmen',
            style: GoogleFonts.poppins(
              fontSize: getTextSize(1.4),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildBatsmanRow(
                match.currentBatsman1,
                match.currentBatsman1Local,
                '86',
                '52',
                '8',
                '4',
                match.team1Players
                    .firstWhere((p) => p.name == match.currentBatsman1)
                    .imageUrl,
              ),
              _buildBatsmanRow(
                match.currentBatsman2,
                match.currentBatsman2Local,
                '45',
                '38',
                '4',
                '1',
                match.team1Players
                    .firstWhere((p) => p.name == match.currentBatsman2)
                    .imageUrl,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBatsmanRow(
    String name,
    String localName,
    String runs,
    String balls,
    String fours,
    String sixes,
    String imageUrl,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: getTextSize(1.2),
                  backgroundColor: Colors.grey[800],
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: getTextSize(2.4),
                      height: getTextSize(2.4),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: getTextSize(1.8),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: getTextSize(1.0),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      localName,
                      style: GoogleFonts.poppins(
                        fontSize: getTextSize(0.8),
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  runs,
                  style: GoogleFonts.robotoMono(
                    fontSize: getTextSize(1.0),
                    color: Colors.white,
                  ),
                ),
                Text(
                  '($balls)',
                  style: GoogleFonts.robotoMono(
                    fontSize: getTextSize(0.9),
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '${fours}x4',
                  style: GoogleFonts.robotoMono(
                    fontSize: getTextSize(0.9),
                    color: Colors.blue[300],
                  ),
                ),
                Text(
                  '${sixes}x6',
                  style: GoogleFonts.robotoMono(
                    fontSize: getTextSize(0.9),
                    color: Colors.purple[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBowlerStats() {
    final match = liveMatches[selectedMatchIndex];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bowler',
            style: GoogleFonts.poppins(
              fontSize: getTextSize(1.4),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildBowlerRow(
                match.currentBowler,
                match.currentBowlerLocal,
                '4.0',
                '0',
                '45',
                '2',
                '11.25',
                match.team2Players
                    .firstWhere((p) => p.name == match.currentBowler)
                    .imageUrl,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBowlerRow(
    String name,
    String localName,
    String overs,
    String maidens,
    String runs,
    String wickets,
    String economy,
    String imageUrl,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: getTextSize(1.2),
                  backgroundColor: Colors.grey[800],
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: getTextSize(2.4),
                      height: getTextSize(2.4),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: getTextSize(1.8),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: getTextSize(1.0),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      localName,
                      style: GoogleFonts.poppins(
                        fontSize: getTextSize(0.8),
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$overs-$maidens-$runs-$wickets',
                  style: GoogleFonts.robotoMono(
                    fontSize: getTextSize(1.0),
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Econ: $economy',
                  style: GoogleFonts.robotoMono(
                    fontSize: getTextSize(0.9),
                    color: _getEconomyColor(double.parse(economy)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getEconomyColor(double economy) {
    if (economy <= 6) return Colors.green[300]!;
    if (economy <= 8) return Colors.yellow[700]!;
    return Colors.red[300]!;
  }

  Widget _buildCommentarySection(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
            'https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/08/3d7b5e7f-7f20-447d-8fb3-77dd252c9e98/Rohit-Sharma.jpg',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.85),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.indigo.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Commentary',
            style: GoogleFonts.poppins(
              fontSize: getTextSize(1.4), // reduced from 2.0
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildCommentaryItem('19.6',
                  'SIX! Rohit Sharma finishes off in style!', Colors.purple),
              _buildCommentaryItem(
                  '19.5', 'FOUR! Exquisite cover drive', Colors.blue),
              _buildCommentaryItem(
                  '19.4', 'Wide ball, way outside off', Colors.grey),
              _buildCommentaryItem(
                  '19.3', 'Single taken, good running', Colors.green),
              _buildCommentaryItem(
                  '19.2', 'DOT BALL! Excellent yorker', Colors.red),
              _buildCommentaryItem(
                  '19.1', 'TWO RUNS! Quick running', Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentaryItem(String over, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getTextSize(0.8),
              vertical: getTextSize(0.4),
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              over,
              style: GoogleFonts.robotoMono(
                fontSize: getTextSize(0.9), // reduced from 1.2
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          SizedBox(width: getTextSize(1.2)),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: getTextSize(0.9), // reduced from 1.2
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BallByBallView extends StatelessWidget {
  final String delivery;
  final String event;
  final Color color;

  const BallByBallView({
    super.key,
    required this.delivery,
    required this.event,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              delivery,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(event),
          ),
        ],
      ),
    );
  }
}
