// ignore_for_file: deprecated_member_use

import 'dart:developer';

// First run: flutter pub add carousel_slider
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cricket_management/service/Home/home_service.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cricket_management/controllers/live_score_controller.dart';
import 'package:get/get.dart';
import 'package:cricket_management/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final HomeController _controller = Get.put(HomeController());
  bool isLoading = true;

  // Theme colors
  final Color primaryColor = const Color(0xFF1A237E);
  final Color secondaryColor = const Color(0xFF0D47A1);
  final Color accentColor = const Color(0xFF03A9F4);
  final Color backgroundColor = const Color(0xFF121212);
  final Color cardColor = const Color(0xFF1E1E1E);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    _buildShimmer(mq),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTournamentSelector(mq),
                    SizedBox(height: mq.size.height * 0.02),
                    _buildHeroSection(mq),
                    SizedBox(height: mq.size.height * 0.03),
                    _buildDashboardGrid(mq),
                    SizedBox(height: mq.size.height * 0.03),
                    _buildLiveMatchesSection(mq),
                    SizedBox(height: mq.size.height * 0.03),
                    _buildPointsTableSection(mq),
                    SizedBox(height: mq.size.height * 0.03),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // If wide screen, show side by side; else stack
                        bool isWide = constraints.maxWidth > 900;
                        return isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: _buildMostRunsTableSection(mq)),
                                  SizedBox(width: mq.size.width * 0.02),
                                  Expanded(
                                      child: _buildMostWicketsTableSection(mq)),
                                ],
                              )
                            : Column(
                                children: [
                                  _buildMostRunsTableSection(mq),
                                  SizedBox(height: mq.size.height * 0.02),
                                  _buildMostWicketsTableSection(mq),
                                ],
                              );
                      },
                    ),
                    SizedBox(height: mq.size.height * 0.03),
                    _buildUpcomingMatchesSection(mq),
                    SizedBox(height: mq.size.height * 0.03),
                    _buildPlayerStatsSection(mq),
                    SizedBox(height: mq.size.height * 0.03),
                    const Footer(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildShimmer(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tournament Selector Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.02,
              vertical: mq.size.height * 0.01),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[500]!,
            child: Container(
              height: mq.size.height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        // Hero Section Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.02,
              vertical: mq.size.height * 0.01),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[500]!,
            child: Container(
              height: mq.size.height * 0.32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        // Dashboard Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.02,
              vertical: mq.size.height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (i) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[500]!,
                    child: Container(
                      height: mq.size.height * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Points Table Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.02,
              vertical: mq.size.height * 0.01),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[500]!,
            child: Column(
              children: List.generate(
                  7,
                  (i) => Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        height: 28,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
            ),
          ),
        ),
        // Most Runs & Most Wickets Shimmer (side by side)
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.02,
              vertical: mq.size.height * 0.01),
          child: Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[500]!,
                  child: Column(
                    children: List.generate(
                        7,
                        (i) => Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              height: 28,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                  ),
                ),
              ),
              SizedBox(width: mq.size.width * 0.02),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[500]!,
                  child: Column(
                    children: List.generate(
                        7,
                        (i) => Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              height: 28,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Upcoming Matches Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.02,
              vertical: mq.size.height * 0.01),
          child: Column(
            children: List.generate(
                4,
                (i) => Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[500]!,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        height: mq.size.height * 0.10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  Widget _buildTournamentSelector(MediaQueryData mq) {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(
            horizontal: mq.size.width * 0.02,
            vertical: mq.size.height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _controller.tournaments.map((tournament) {
              final isSelected =
                  tournament['name'] == _controller.selectedTournament.value;
              return GestureDetector(
                onTap: () => _controller.changeTournament(tournament['name']),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mq.size.width * 0.02,
                    vertical: mq.size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(int.parse(
                            tournament['color'].replaceAll('#', '0xFF')))
                        : cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? Color(int.parse(tournament['color']
                                    .replaceAll('#', '0xFF')))
                                .withOpacity(0.3)
                            : Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        tournament['icon'],
                        style: TextStyle(fontSize: mq.size.width * 0.02),
                      ),
                      SizedBox(width: mq.size.width * 0.01),
                      Text(
                        tournament['name'],
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: mq.size.width * 0.012,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }

  Widget _buildHeroSection(MediaQueryData mq) {
    return Obx(() => FadeIn(
          child: CarouselSlider(
            options: CarouselOptions(
              height: mq.size.height * 0.45,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.85,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
            ),
            items: _controller.news.map((article) {
              return _buildHeroCard(
                mq,
                article['title'] ?? 'No Title',
                article['imageUrl'] ?? '',
                article['description'] ?? 'No Description',
                article['link'] ?? '#',
              );
            }).toList(),
          ),
        ));
  }

  Widget _buildDashboardGrid(MediaQueryData mq) {
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dashboard",
                    style: GoogleFonts.lato(
                      fontSize: mq.size.width * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.01,
                      vertical: mq.size.height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "IPL 2024",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mq.size.height * 0.01),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: mq.size.width * 0.015,
                crossAxisSpacing: mq.size.width * 0.015,
                children: [
                  _buildDashboardCard(
                    mq,
                    "Matches",
                    _controller.dashboardStats['totalMatches'].toString(),
                    FontAwesomeIcons.baseballBatBall,
                    Colors.blue,
                  ),
                  _buildDashboardCard(
                    mq,
                    "Live",
                    _controller.dashboardStats['liveMatches'].toString(),
                    FontAwesomeIcons.circlePlay,
                    Colors.red,
                  ),
                  _buildDashboardCard(
                    mq,
                    "Upcoming",
                    _controller.dashboardStats['upcomingMatches'].toString(),
                    FontAwesomeIcons.calendar,
                    Colors.green,
                  ),
                  _buildDashboardCard(
                    mq,
                    "Results",
                    _controller.dashboardStats['completedMatches'].toString(),
                    FontAwesomeIcons.trophy,
                    Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildLiveMatchesSection(MediaQueryData mq) {
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Live Matches",
                style: GoogleFonts.lato(
                  fontSize: mq.size.width * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: mq.size.height * 0.01),
              SizedBox(
                height: mq.size.height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _controller.liveMatches.length,
                  itemBuilder: (context, index) {
                    final match = _controller.liveMatches[index];
                    return _buildLiveMatchCard(mq, match);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildLiveMatchCard(MediaQueryData mq, Map<String, dynamic> match) {
    return Container(
      width: mq.size.width * 0.3,
      margin: EdgeInsets.only(right: mq.size.width * 0.015),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(mq.size.width * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mq.size.width * 0.01,
                    vertical: mq.size.height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color:
                        match['status'] == 'Live' ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      if (match['status'] == 'Live')
                        Icon(Icons.live_tv, color: Colors.white, size: 12),
                      SizedBox(width: 4),
                      Text(
                        match['status'] ?? 'Live',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  match['result'] ?? '',
                  style: GoogleFonts.lato(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: mq.size.height * 0.01),
            Row(
              children: [
                _buildTeamLogo(match['team1_logo'], match['team1_color']),
                SizedBox(width: mq.size.width * 0.01),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match['team1'] ?? '',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${match['score1']} (${match['overs1']})",
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: mq.size.height * 0.01),
            Row(
              children: [
                _buildTeamLogo(match['team2_logo'], match['team2_color']),
                SizedBox(width: mq.size.width * 0.01),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match['team2'] ?? '',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${match['score2']} (${match['overs2']})",
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogo(String? logoUrl, String? teamColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: teamColor != null
              ? Color(int.parse(teamColor.replaceAll('#', '0xFF')))
              : Colors.white24,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: logoUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.sports_cricket,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildPointsTableSection(MediaQueryData mq) {
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "IPL 2025 - Points Table",
                style: GoogleFonts.lato(
                  fontSize: mq.size.width * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: mq.size.height * 0.01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: mq.size.width,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(cardColor),
                    dataRowColor:
                        MaterialStateProperty.all(cardColor.withOpacity(0.85)),
                    columnSpacing: 16,
                    columns: [
                      DataColumn(
                          label: Text('Rank',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Team',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Mat',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Won',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Lost',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Tied',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('NR',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Pts',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('NRR',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                    rows: _controller.topTeams
                        .map((team) => DataRow(
                              cells: [
                                DataCell(Text(team['rank'].toString(),
                                    style:
                                        GoogleFonts.lato(color: Colors.white))),
                                DataCell(Row(
                                  children: [
                                    Image.asset(
                                      team['image_path'],
                                      width: 28,
                                      height: 28,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 8),
                                    Text(team['name'],
                                        style: GoogleFonts.lato(
                                            color: Colors.white)),
                                  ],
                                )),
                                DataCell(Text(team['matches'].toString(),
                                    style:
                                        GoogleFonts.lato(color: Colors.white))),
                                DataCell(Text(team['won'].toString(),
                                    style:
                                        GoogleFonts.lato(color: Colors.white))),
                                DataCell(Text(team['lost'].toString(),
                                    style:
                                        GoogleFonts.lato(color: Colors.white))),
                                DataCell(Text('0',
                                    style: GoogleFonts.lato(
                                        color: Colors.white))), // Tied
                                DataCell(Text('0',
                                    style: GoogleFonts.lato(
                                        color: Colors.white))), // NR
                                DataCell(Text(team['points'].toString(),
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                                DataCell(Text(team['nrr'].toString(),
                                    style:
                                        GoogleFonts.lato(color: Colors.white))),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildMostRunsTableSection(MediaQueryData mq) {
    final controller = _controller;
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Most Runs",
                style: GoogleFonts.lato(
                  fontSize: mq.size.width * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: mq.size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                          cardColor.withOpacity(0.95)),
                      dataRowColor: MaterialStateProperty.all(
                          cardColor.withOpacity(0.85)),
                      columnSpacing: 18,
                      columns: [
                        DataColumn(
                            label: Text(' ',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Player',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Matches',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Inns',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Runs',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Avg',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Sr',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('4s',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('6s',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: controller.topRunScorers
                          .map((player) => DataRow(
                                cells: [
                                  DataCell(Text(player['rank'].toString(),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                  DataCell(Text(player['name'],
                                      style: GoogleFonts.lato(
                                          color: Colors.blue[200],
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.underline))),
                                  DataCell(Text(player['matches'].toString(),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                  DataCell(Text(player['innings'].toString(),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                  DataCell(Text(player['runs'].toString(),
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                                  DataCell(Text(
                                      player['average'].toStringAsFixed(2),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                  DataCell(Text(
                                      player['strike_rate'].toStringAsFixed(2),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                  DataCell(Text(player['fours'].toString(),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                  DataCell(Text(player['sixes'].toString(),
                                      style: GoogleFonts.lato(
                                          color: Colors.white))),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildMostWicketsTableSection(MediaQueryData mq) {
    final controller = _controller;
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Most Wickets",
                style: GoogleFonts.lato(
                  fontSize: mq.size.width * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: mq.size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  width: 1000,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                            cardColor.withOpacity(0.95)),
                        dataRowColor: MaterialStateProperty.all(
                            cardColor.withOpacity(0.85)),
                        columnSpacing: 18,
                        columns: [
                          DataColumn(
                              label: Text(' ',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Player',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Matches',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Overs',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Balls',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Wkts',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Avg',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Runs',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('4-fers',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('5-fers',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: controller.topWicketTakers
                            .map((player) => DataRow(
                                  cells: [
                                    DataCell(Text(player['rank'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(player['name'],
                                        style: GoogleFonts.lato(
                                            color: Colors.blue[200],
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline))),
                                    DataCell(Text(player['matches'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(player['overs'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(player['balls'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(player['wickets'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                                    DataCell(Text(
                                        player['average'].toStringAsFixed(2),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(player['runs'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(
                                        player['four_fers'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                    DataCell(Text(
                                        player['five_fers'].toString(),
                                        style: GoogleFonts.lato(
                                            color: Colors.white))),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildUpcomingMatchesSection(MediaQueryData mq) {
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Matches",
                style: GoogleFonts.lato(
                  fontSize: mq.size.width * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: mq.size.height * 0.01),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _controller.upcomingMatches.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: mq.size.height * 0.01),
                itemBuilder: (context, index) {
                  final match = _controller.upcomingMatches[index];
                  return Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.02,
                        vertical: mq.size.height * 0.015,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date
                          Container(
                            width: mq.size.width * 0.10,
                            child: Text(
                              match['date'] ?? '',
                              style: GoogleFonts.lato(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: mq.size.width * 0.012,
                              ),
                            ),
                          ),
                          SizedBox(width: mq.size.width * 0.01),
                          // Match Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  match['match'] ?? '',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: mq.size.width * 0.012,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  match['venue'] ?? '',
                                  style: GoogleFonts.lato(
                                    color: Colors.white70,
                                    fontSize: mq.size.width * 0.010,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Match starts at ${match['date'].split(',')[0]} ${match['time_gmt'].split('/')[0].trim()}',
                                  style: GoogleFonts.lato(
                                    color: Colors.orangeAccent,
                                    fontSize: mq.size.width * 0.010,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: mq.size.width * 0.01),
                          // Time
                          Container(
                            width: mq.size.width * 0.10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  match['time_local'] ?? '',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: mq.size.width * 0.012,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  match['time_gmt'] ?? '',
                                  style: GoogleFonts.lato(
                                    color: Colors.white70,
                                    fontSize: mq.size.width * 0.009,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildPlayerStatsSection(MediaQueryData mq) {
    return Obx(() => Padding(
          padding: EdgeInsets.all(mq.size.width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Top Performers",
                style: GoogleFonts.lato(
                  fontSize: mq.size.width * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: mq.size.height * 0.01),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: mq.size.width * 0.015,
                  mainAxisSpacing: mq.size.height * 0.015,
                ),
                itemCount: _controller.playerStats.length,
                itemBuilder: (context, index) {
                  return _buildPlayerStatsCard(
                      mq, _controller.playerStats[index]);
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildPlayerStatsCard(MediaQueryData mq, Map<String, dynamic> player) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(mq.size.width * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: player['team_color'] != null
                          ? Color(int.parse(
                              player['team_color'].replaceAll('#', '0xFF')))
                          : Colors.white24,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: player['image_url'] ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: mq.size.width * 0.015),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player['name'] ?? 'Unknown',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${player['role']} • ${player['team']}",
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: mq.size.height * 0.01),
            Container(
              padding: EdgeInsets.all(mq.size.width * 0.01),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildStatRow(
                    mq,
                    'Recent',
                    player['recent_performance'] ?? '',
                    player['role'] == 'Batsman' ? Colors.green : Colors.blue,
                  ),
                  SizedBox(height: 5),
                  if (player['role'] == 'Batsman') ...[
                    _buildStatRow(
                        mq, 'Matches', player['stats']['matches'] ?? ''),
                    _buildStatRow(mq, 'Runs', player['stats']['runs'] ?? ''),
                    _buildStatRow(
                        mq, 'Average', player['stats']['average'] ?? ''),
                    _buildStatRow(
                        mq, 'S/R', player['stats']['strike_rate'] ?? ''),
                  ] else ...[
                    _buildStatRow(
                        mq, 'Matches', player['stats']['matches'] ?? ''),
                    _buildStatRow(
                        mq, 'Wickets', player['stats']['wickets'] ?? ''),
                    _buildStatRow(
                        mq, 'Economy', player['stats']['economy'] ?? ''),
                    _buildStatRow(mq, 'Best', player['stats']['best'] ?? ''),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(MediaQueryData mq, String label, String value,
      [Color? valueColor]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lato(
            color: valueColor ?? Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard(MediaQueryData mq, String title, String value,
      IconData icon, Color color) {
    final tournament = _controller.tournaments.firstWhere(
      (t) => t['name'] == _controller.selectedTournament.value,
      orElse: () => _controller.tournaments.first,
    );

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(int.parse(tournament['color'].replaceAll('#', '0xFF')))
                .withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(mq.size.width * 0.01),
            decoration: BoxDecoration(
              color:
                  Color(int.parse(tournament['color'].replaceAll('#', '0xFF')))
                      .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color:
                  Color(int.parse(tournament['color'].replaceAll('#', '0xFF'))),
              size: mq.size.width * 0.03,
            ),
          ),
          SizedBox(height: mq.size.height * 0.01),
          Text(
            value,
            style: GoogleFonts.lato(
              fontSize: mq.size.width * 0.02,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: mq.size.width * 0.012,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(
    MediaQueryData mq,
    String title,
    String imageUrl,
    String description,
    String link,
    bool isApiLimitReached, // Add this flag to determine API limit
  ) {
    final tournament = _controller.tournaments.isNotEmpty
        ? _controller.tournaments.firstWhere(
            (t) => t['name'] == _controller.selectedTournament.value,
            orElse: () => _controller.tournaments.first,
          )
        : null;

    if (isApiLimitReached) {
      // If API limit is reached, show a message
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: Icon(Icons.sports_cricket,
                        size: 50, color: Colors.white70),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(mq.size.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'API Limit Reached. Please try again later.',
                      style: GoogleFonts.lato(
                        fontSize: mq.size.width * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(Icons.sports_cricket,
                      size: 50, color: Colors.white70),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(mq.size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.01,
                      vertical: mq.size.height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      tournament?['name'] ?? '',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.01),
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: mq.size.width * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.01),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: mq.size.width * 0.012,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      final uri = Uri.tryParse(link);
                      if (uri != null && await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.02,
                        vertical: mq.size.height * 0.015,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Read More",
                          style: GoogleFonts.lato(
                            fontSize: mq.size.width * 0.012,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward, size: 16),
                      ],
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

  Widget _buildTeamCard(MediaQueryData mq, Map<String, dynamic> team) {
    return Container(
      width: mq.size.width * 0.2,
      margin: EdgeInsets.only(right: mq.size.width * 0.015),
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: team['image_path'] ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.sports_cricket,
                      size: 50, color: Colors.white70)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(mq.size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    team['name'] ?? 'No Name',
                    style: GoogleFonts.lato(
                      fontSize: mq.size.width * 0.015,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mq.size.height * 0.01),
                  Row(
                    children: [
                      Icon(Icons.emoji_events,
                          color: Colors.amber, size: mq.size.width * 0.015),
                      SizedBox(width: 4),
                      Text(
                        "Rank #${team['ranking']}",
                        style: GoogleFonts.notoSans(
                          fontSize: mq.size.width * 0.010,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    team['type'] ?? 'Team',
                    style: GoogleFonts.notoSans(
                      fontSize: mq.size.width * 0.009,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
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
}
