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
  const TournamentDetailScreen({
    super.key,
  });

  @override
  State<TournamentDetailScreen> createState() => _TournamentDetailScreenState();
}

Map<String, dynamic> tournament = {};

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
    AboutPage(),
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
  void initState() {
    super.initState();
    tournament = _pageController.data;
  }

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
                  tournament['imageUrl'] ?? 'default_image_url',
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
                  _buildStatCard(tournament["totalMatches"].toString(),
                      "Total\nMatches", Colors.blue),
                  SizedBox(width: width * 0.02),
                  _buildStatCard(tournament["totalTeams"].toString(),
                      "Teams\nParticipating", Colors.purple),
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
          imageUrl: tournament['imageUrl'] ?? 'default_image_url',
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
          tournament['name'] ?? 'Tournament Name',
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
              tournament['location'] ?? 'Location not specified',
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
              "${tournament['startDate']?.split('T')[0]} - ${tournament['endDate']?.split('T')[0]}",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01, // Reduced from 0.015
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.008), // Reduced from 0.01
        Text(
          "Overs : ${tournament['totalOver'].toString()}" ?? "Overs not specified",
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: width * 0.01, // Reduced from 0.015
          ),
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

  // Add this method at the end of the class
  void _showAddTournamentDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    // Form controllers
    final descriptionController = TextEditingController();
    final organizerController = TextEditingController();
    final venueController = TextEditingController();
    final prizeController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final websiteController = TextEditingController();

    // Rules list
    List<String> rules = [''];

    // Timeline list
    List<Map<String, String>> timeline = [
      {'date': '', 'event': ''}
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: Text(
          'Add Tournament Information',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: width * 0.6,
          height: height * 0.8,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogSectionTitle('Basic Information'),
                  _buildDialogTextField(
                    controller: descriptionController,
                    label: 'Tournament Description',
                    maxLines: 3,
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField(
                          controller: organizerController,
                          label: 'Organizer',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: venueController,
                          label: 'Venue',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: prizeController,
                          label: 'Prize Pool',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.03),
                  _buildDialogSectionTitle('Tournament Rules'),

                  // Dynamic rules list
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          for (int i = 0; i < rules.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDialogTextField(
                                    label: 'Rule ${i + 1}',
                                    onChanged: (value) {
                                      rules[i] = value;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (rules.length > 1) {
                                        rules.removeAt(i);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: height * 0.01),
                          TextButton.icon(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            label: Text(
                              'Add Rule',
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                            onPressed: () {
                              setState(() {
                                rules.add('');
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: height * 0.03),
                  _buildDialogSectionTitle('Tournament Timeline'),

                  // Dynamic timeline list
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          for (int i = 0; i < timeline.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildDialogTextField(
                                    label: 'Date',
                                    onChanged: (value) {
                                      timeline[i]['date'] = value;
                                    },
                                  ),
                                ),
                                SizedBox(width: width * 0.01),
                                Expanded(
                                  flex: 3,
                                  child: _buildDialogTextField(
                                    label: 'Event',
                                    onChanged: (value) {
                                      timeline[i]['event'] = value;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (timeline.length > 1) {
                                        timeline.removeAt(i);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: height * 0.01),
                          TextButton.icon(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            label: Text(
                              'Add Timeline Event',
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                            onPressed: () {
                              setState(() {
                                timeline.add({'date': '', 'event': ''});
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: height * 0.03),
                  _buildDialogSectionTitle('Contact Information'),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField(
                          controller: emailController,
                          label: 'Email',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: phoneController,
                          label: 'Phone',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: websiteController,
                          label: 'Website',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Here you would save the tournament data
                // For now, we'll just print it
                print('Tournament data saved:');
                print('Description: ${descriptionController.text}');
                print('Organizer: ${organizerController.text}');
                print('Venue: ${venueController.text}');
                print('Prize: ${prizeController.text}');
                print('Rules: $rules');
                print('Timeline: $timeline');
                print('Email: ${emailController.text}');
                print('Phone: ${phoneController.text}');
                print('Website: ${websiteController.text}');

                Navigator.pop(context);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tournament information added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.01),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.blue,
          fontSize: width * 0.012,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDialogTextField({
    TextEditingController? controller,
    required String label,
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.01),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
