import 'dart:core';
import 'dart:developer';

import 'package:cricket_management/controllers/page_controller.dart';
import 'package:cricket_management/screens/Tournament/tournament_detail_screen.dart';
import 'package:cricket_management/screens/Tournament/tournament_screen.dart';
import 'package:cricket_management/service/tournament/matches_service.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const List<String> tabs = ['Live', 'Upcoming', 'Completed'];

class MatchesPage extends StatefulWidget {
  const MatchesPage({
    super.key,
  });

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with SingleTickerProviderStateMixin {
  PageNavigationController pageController =
      Get.find<PageNavigationController>();
  late TabController _tabController;
  double width = 0;
  double height = 0;
  bool isLoading = false;

  List<Map<String, dynamic>> completedMatches = [];
  List<Map<String, dynamic>> liveMatches = [];
  List<Map<String, dynamic>> upcomingMatches = [];

  void filterAndSortMatches(List<Map<String, dynamic>> allMatches) {
    final now = DateTime.now();
    completedMatches.clear();
    liveMatches.clear();
    upcomingMatches.clear();

    for (var match in allMatches) {
      final matchTimeParts = match["matchTime"].toString().split(" To ");
      final matchTime = matchTimeParts.isNotEmpty ? matchTimeParts[0] : "00:00";
      final matchDateTime = DateTime.parse('${match["matchDate"]} $matchTime');

      if (isSameDay(matchDateTime, now)) {
        if (matchDateTime.isBefore(now) ||
            matchDateTime.isAtSameMomentAs(now)) {
          // Match is today and time has already started or exactly now
          liveMatches.add(match);
        } else {
          // Match is today but time is in the future
          upcomingMatches.add(match);
        }
      } else if (matchDateTime.isBefore(now)) {
        // Match is before today
        completedMatches.add(match);
      } else {
        // Match is after today
        upcomingMatches.add(match);
      }
    }

    sortMatchesByDateAndTime(completedMatches);
    sortMatchesByDateAndTime(liveMatches);
    sortMatchesByDateAndTime(upcomingMatches);
  }

// Helper to check if two DateTimes are on the same day
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void initState() {
    super.initState();
    _fetchMatchesSlot();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void _fetchMatchesSlot() async {
    setState(() {
      isLoading = true;
    });
    MatchesService().getMatches(tournamentId!).then((value) {
      setState(() {
        filterAndSortMatches(value);
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  void sortMatchesByDateAndTime(List<Map<String, dynamic>> matches) {
    matches.sort((a, b) {
      // Parse date and time strings
      DateTime dateTimeA = DateTime.parse(
          '${a["matchDate"]} ${a["matchTime"].toString().split(" To ")[0]}');
      DateTime dateTimeB = DateTime.parse(
          '${b["matchDate"]} ${b["matchTime"].toString().split(" To ")[0]}');
      // For completed matches, sort in reverse chronological order (newest first)
      if (a["matchStatus"] == "COMPLETED" && b["matchStatus"] == "COMPLETED") {
        return dateTimeB.compareTo(dateTimeA);
      }
      // For other matches, sort in chronological order
      return dateTimeA.compareTo(dateTimeB);
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: (isLoading)
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue, size: 20),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      child: (!tournament["generated"])
                          ? ElevatedButton.icon(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Generate Match',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.015,
                                ),
                              ),
                              onPressed: () {
                                _showGenerateMatchDialog(context);
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  _buildTabBar(),
                  SizedBox(height: height * 0.02),
                  Builder(
                    builder: (context) {
                      final currentMatches = _tabController.index == 0
                          ? liveMatches
                          : _tabController.index == 1
                              ? upcomingMatches
                              : completedMatches;

                      if (currentMatches.isEmpty) {
                        return Center(
                          child: Text(
                            'No matches available',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: width * 0.015,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: width * 0.02,
                          mainAxisSpacing: height * 0.02,
                          childAspectRatio: 1.7,
                        ),
                        itemBuilder: (context, index) {
                          return _buildLiveMatchCard(currentMatches[index]);
                        },
                        itemCount: currentMatches.length,
                      );
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  const Footer()
                ],
              ),
      ),
    );
  }

  Widget _buildTabBar() {
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

  Widget _buildLiveMatchCard(Map<String, dynamic> match) {
    bool isLiveMatch = _tabController.index == 0;
    bool isUpcomingMatch = _tabController.index == 1;
    bool isCompletedMatch = _tabController.index == 2;

    final team1 = match['team1'] as Map<String, dynamic>;
    final team2 = match['team2'] as Map<String, dynamic>;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.15),
              Colors.purple.withOpacity(0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.01,
                    vertical: height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tournament['type'] ?? 'T20I',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.01,
                    vertical: height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: isLiveMatch
                        ? Colors.green.withOpacity(0.2)
                        : isUpcomingMatch
                            ? Colors.orange.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isLiveMatch
                          ? Colors.green.withOpacity(0.3)
                          : isUpcomingMatch
                              ? Colors.orange.withOpacity(0.3)
                              : Colors.blue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    isLiveMatch
                        ? 'Live'
                        : isUpcomingMatch
                            ? 'Upcoming'
                            : 'Completed',
                    style: GoogleFonts.poppins(
                      color: isLiveMatch
                          ? Colors.green
                          : isUpcomingMatch
                              ? Colors.orange
                              : Colors.blue,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.01,
                vertical: height * 0.005,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                match['venue'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.01,
                ),
              ),
            ),
            if (isUpcomingMatch) ...[
              SizedBox(height: height * 0.015),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                  vertical: height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white70,
                      size: width * 0.012,
                    ),
                    SizedBox(width: width * 0.005),
                    Text(
                      "${match['matchDate'] ?? ''} | ${match['matchTime'] ?? ''}",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: width * 0.01,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.08,
                        width: height * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: team1['teamLogo'] ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white70,
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.sports_cricket,
                              size: height * 0.04,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Text(
                        team1['teamName'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: width * 0.011,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!isUpcomingMatch) ...[
                        SizedBox(height: height * 0.01),
                        Text(
                          '${match['score1'] ?? ''} (${match['overs1'] ?? ''})',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: width * 0.01,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Text(
                    'VS',
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.014,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.08,
                        width: height * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: team2['teamLogo'] ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white70,
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.sports_cricket,
                              size: height * 0.04,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Text(
                        team2['teamName'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: width * 0.011,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!isUpcomingMatch) ...[
                        SizedBox(height: height * 0.01),
                        Text(
                          '${match['score2'] ?? ''} (${match['overs2'] ?? ''})',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: width * 0.01,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.01,
                vertical: height * 0.008,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Text(
                isCompletedMatch && match['result'] != null
                    ? match['result']
                    : isLiveMatch
                        ? 'Match in progress'
                        : isUpcomingMatch
                            ? 'Match starts soon'
                            : '',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.009,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showGenerateMatchDialog(BuildContext context) {
  bool localIsLoading = false;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2A2A2A),
            title: Text(
              'Generate Matches',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Do you want to generate match slots?',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                if (localIsLoading) ...[
                  const SizedBox(height: 20),
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: localIsLoading ? null : () => Navigator.pop(context),
                child: Text(
                  'No',
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: localIsLoading
                    ? null
                    : () async {
                        setState(() {
                          localIsLoading = true;
                        });
                        try {
                          await MatchesService()
                              .generateSlots(tournamentId!)
                              .then((value) {
                            Navigator.pop(context);
                            context
                                .findAncestorStateOfType<_MatchesPageState>()
                                ?.setState(() {
                              tournament["generated"] = true;
                            });
                          });
                        } catch (e) {
                          setState(() {
                            localIsLoading = false;
                          });
                          Get.snackbar(
                            'Error',
                            'Error while generating slots',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                child: Text(
                  'Yes',
                  style: GoogleFonts.poppins(color: Colors.blue),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          );
        },
      );
    },
  );
}
