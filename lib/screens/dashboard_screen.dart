// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cricket_management/controllers/page_controller.dart';
import 'package:cricket_management/controllers/profile_controller.dart';
import 'package:cricket_management/screens/HomeScreens/HomeScreen.dart';
import 'package:cricket_management/screens/LiveScore/live_score_page.dart';
import 'package:cricket_management/screens/LiveScore/match_detail_screen.dart';
import 'package:cricket_management/screens/Notification/notification_screen.dart';
import 'package:cricket_management/screens/Settings/settings_page.dart';
import 'package:cricket_management/screens/Statistics/tournament_statistics_screen.dart';
import 'package:cricket_management/screens/Tournament/tournament_detail_screen.dart';
import 'package:cricket_management/screens/Tournament/tournament_screen.dart';
import 'package:cricket_management/screens/login_screen.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// Update controller initialization
class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final PageNavigationController pageController =
      Get.put(PageNavigationController());
  final ProfileController profileController = Get.put(ProfileController());

  int selectedPageIndex = 0;

  // Animation Controller
  late AnimationController _controller;
  // Fade Animation
  late Animation<double> _fadeAnimation;

  List<List> subPages = [
    [],
    [
      const MatchDetailScreen(matchInfo: {
        "match_id": "1",
        "match_type": "ODI",
      })
    ],
    [
      const TournamentDetailScreen(),
      const MatchDetailScreen(matchInfo: {}),
    ],
    [], // NotificationScreen
    [], // TournamentStatisticsScreen
    [],
  ];

  List<Widget> pages = [
    Homescreen(),
    const LiveScorePage(),
    const TournamentScreen(),
    const NotificationScreen(), // Add this line
    TournamentStatisticsScreen(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    initParts();
    // Initialize the page controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _controller.forward();
  }

  void initParts() async {
    await AuthSharedP().getAdminStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0D14),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0A0D14),
                const Color(0xFF1B1E25).withOpacity(0.9),
              ],
            ),
          ),
          child: Row(
            children: [
              _buildNavigationBar(mq),
              // Update the Expanded widget in build method
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(() => (pageController.subIndex.value == -1)
                          ? pages[pageController.index.value]
                          : subPages[pageController.index.value]
                              [pageController.subIndex.value]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// BUILD: Left Navigation Bar
  Widget _buildNavigationBar(MediaQueryData mq) {
    return Container(
      width: mq.size.width * 0.15,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B1E25),
            Color(0xFF242730),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.baseballBall,
                  color: Colors.white,
                  size: mq.size.width * 0.02,
                ),
                SizedBox(width: mq.size.width * 0.01),
                Text(
                  "Cric.Go",
                  style: GoogleFonts.poppins(
                    fontSize: mq.size.width * 0.018,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // Nav Items
          // Update the nav items section
          Column(
            children: [
              Obx(() => _buildNavItem(
                    icon: FontAwesomeIcons.home,
                    label: "Home",
                    selected: pageController.index.value == 0,
                    onTap: () => pageController.navigateToMain(0),
                  )),
              Obx(() => _buildNavItem(
                    icon: FontAwesomeIcons.chartLine,
                    label: "Live Scores",
                    selected: pageController.index.value == 1,
                    onTap: () => pageController.navigateToMain(1),
                  )),
              Obx(() => _buildNavItem(
                    icon: FontAwesomeIcons.gamepad,
                    label: "Tournaments",
                    selected: pageController.index.value == 2,
                    onTap: () => pageController.navigateToMain(2),
                  )),
              Obx(() => _buildNavItem(
                    icon: FontAwesomeIcons.bell,
                    label: "Notifications",
                    selected: pageController.index.value == 3,
                    onTap: () => pageController.navigateToMain(3),
                    badge: "3",
                  )),
              Obx(() => _buildNavItem(
                    icon: FontAwesomeIcons.envelope,
                    label: "Statistics ",
                    selected: pageController.index.value == 4,
                    onTap: () => pageController.navigateToMain(4),
                  )),
              Obx(() => _buildNavItem(
                    icon: FontAwesomeIcons.cog,
                    label: "Settings",
                    selected: pageController.index.value == 5,
                    onTap: () => pageController.navigateToMain(5),
                  )),
            ],
          ),

          // Bottom Profile/Logout
          Container(
            margin: EdgeInsets.all(mq.size.width * 0.01),
            padding: EdgeInsets.all(mq.size.width * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              children: [
                Builder(builder: (context) {
                  return Obx(
                    () => CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white24,
                      backgroundImage: NetworkImage(
                        profileController.profileData["imgUrl"] ?? "",
                      ),
                    ),
                  );
                }),
                SizedBox(height: mq.size.height * 0.015),
                Obx(() => Text(
                      profileController.profileData["name"] ?? "Guest",
                      style: GoogleFonts.poppins(
                        fontSize: mq.size.width * 0.011,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(height: mq.size.height * 0.01),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () async {
                        AuthSharedP authSharedP = AuthSharedP();
                        authSharedP.clear();
                        log("Admin status : ${await authSharedP.getAdminStatus()}");
                        log("Admin status : ${AuthSharedP.isAdmin}");

                        if (mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: mq.size.width * 0.01,
                          vertical: mq.size.height * 0.008,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.withOpacity(0.4),
                              Colors.red.withOpacity(0.2),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.signOutAlt,
                              color: Colors.white.withOpacity(0.9),
                              size: mq.size.width * 0.01,
                            ),
                            SizedBox(width: mq.size.width * 0.005),
                            Text(
                              "Logout",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: mq.size.width * 0.009,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: mq.size.height * 0.02),
        ],
      ),
    );
  }

  /// BUILD: Single Nav Item
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool selected = false,
    VoidCallback? onTap,
    String? badge,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.7),
                      Colors.blue.withOpacity(0.4),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 30,
                height: 24,
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      icon,
                      color: selected ? Colors.white : Colors.white70,
                      size: 22,
                    ),
                    if (badge != null)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            badge,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              title: Text(
                label,
                style: GoogleFonts.poppins(
                  color: selected ? Colors.white : Colors.white70,
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
