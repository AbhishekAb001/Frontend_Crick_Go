import 'dart:developer';

import 'package:cricket_management/screens/Tournament/subpages/teams_page.dart';
import 'package:cricket_management/screens/Tournament/tournament_screen.dart';
import 'package:cricket_management/service/tournament/teams_service.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class PointsTable {
  static List<Map<String, dynamic>> teamStats = [];

  static Future<void> _fetchTeams() async {
    try {
      await TeamsService().getTeams(tournamentId!).then((value) {
        teamStats.clear();
        teamStats.addAll(value);
      });
    } on Exception catch (e) {
      log("Excption while : ${e.toString()}");
    }
  }

  static Widget buildPointsTable(BuildContext context) {
    // Hardcoded data for the points table

    if (teams.isEmpty) {
      _fetchTeams();
      log("Teams from if $teamStats");
    } else {
      teamStats = teams;
      log("Teams from else $teamStats");
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Container(
              width:
                  MediaQuery.of(context).size.width, // Changed from width - 16
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.blue.withOpacity(0.1),
                    dataTableTheme: const DataTableThemeData(
                      headingTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      dataTextStyle: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(
                      Colors.blue.withOpacity(0.2),
                    ),
                    dataRowColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blue.withOpacity(0.1);
                        }
                        return Colors.transparent;
                      },
                    ),
                    columns: const [
                      DataColumn(label: Text('#')),
                      DataColumn(label: Text('Team')),
                      DataColumn(label: Text('M')),
                      DataColumn(label: Text('W')),
                      DataColumn(label: Text('L')),
                      DataColumn(label: Text('D')),
                      DataColumn(label: Text('T')),
                      DataColumn(label: Text('NR')),
                      DataColumn(label: Text('NRR')),
                      DataColumn(label: Text('For')),
                      DataColumn(label: Text('Against')),
                      DataColumn(label: Text('Pt.')),
                      DataColumn(label: Text('Last 5')),
                    ],
                    rows: List.generate(
                      teamStats.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          )),
                          // Team Name
                          DataCell(
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        teamStats[index]['teamLogo'] ??
                                            'https://via.placeholder.com/24',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    teamStats[index]['teamName'] ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: index < 4
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Matches
                          DataCell(Text(
                            (teamStats[index]['matchesPlayed']?.toString() ??
                                '0'),
                            style: const TextStyle(color: Colors.white70),
                          )),
                          // Wins
                          DataCell(Text(
                            (teamStats[index]['wins']?.toString() ?? '0'),
                            style: const TextStyle(color: Colors.green),
                          )),
                          // Losses
                          DataCell(Text(
                            (teamStats[index]['losses']?.toString() ?? '0'),
                            style: const TextStyle(color: Colors.red),
                          )),
                          // Draws
                          DataCell(Text(
                            (teamStats[index]['draws']?.toString() ?? '0'),
                            style: const TextStyle(color: Colors.white70),
                          )),
                          // Ties
                          DataCell(Text(
                            (teamStats[index]['ties']?.toString() ?? '0'),
                            style: const TextStyle(color: Colors.white70),
                          )),
                          // No Results
                          DataCell(Text(
                            (teamStats[index]['noResults']?.toString() ?? '0'),
                            style: const TextStyle(color: Colors.white70),
                          )),
                          // Net Run Rate
                          DataCell(Text(
                            teamStats[index]['netRunRate']?.toString() ??
                                '0.00',
                            style: TextStyle(
                              color:
                                  (teamStats[index]['netRunRate']?.toString() ??
                                              '0.00')
                                          .startsWith('-')
                                      ? Colors.red
                                      : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          // For
                          DataCell(Text(
                            teamStats[index]['runsFor']?.toString() ?? '0',
                            style: const TextStyle(color: Colors.white70),
                          )),
                          // Against
                          DataCell(Text(
                            teamStats[index]['runsAgainst']?.toString() ?? '0',
                            style: const TextStyle(color: Colors.white70),
                          )),
                          // Points
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.006,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.03),
                              ),
                              child: Text(
                                teamStats[index]['points']?.toString() ?? '0',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Last 5
                          DataCell(Text(
                            teamStats[index]['resultHistory']?.toString() ??
                                '-',
                            style: const TextStyle(color: Colors.white70),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Footer moved outside the table
          const SizedBox(height: 10),
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: const Footer(),
          ),
        ],
      ),
    );
  }
}
