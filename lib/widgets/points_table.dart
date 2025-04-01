import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class PointsTable {
  static Widget buildPointsTable(BuildContext context) {
    // Hardcoded data for the points table
    final List<Map<String, dynamic>> teamStats = [
      {
        'teamName': 'Astral XI',
        'played': 10,
        'won': 8,
        'lost': 2,
        'drawn': 0,
        'tied': 0,
        'nr': 0,
        'nrr': '+1.684',
        'for': '1507/166',
        'against': '1326/179.2',
        'points': 16,
        'last5': 'W-W-W-W-W',
        'logo':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png',
      },
      {
        'teamName': 'Team Gauravs XI',
        'played': 10,
        'won': 8,
        'lost': 2,
        'drawn': 0,
        'tied': 0,
        'nr': 0,
        'nrr': '+1.593',
        'for': '1533/159.2',
        'against': '1433/178.3',
        'points': 16,
        'last5': 'W-W-W-W-L',
        'logo':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/logos/Roundbig/CSKroundbig.png',
      },
      {
        'teamName': 'Gladiators Cricket Club Vik',
        'played': 10,
        'won': 7,
        'lost': 3,
        'drawn': 0,
        'tied': 0,
        'nr': 0,
        'nrr': '+0.691',
        'for': '1532/165.5',
        'against': '1443/168.5',
        'points': 14,
        'last5': 'W-W-W-L-L',
        'logo':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Logos/Roundbig/RCBroundbig.png',
      },
      {
        'teamName': 'Super Daddy Cricket11',
        'played': 10,
        'won': 6,
        'lost': 4,
        'drawn': 0,
        'tied': 0,
        'nr': 0,
        'nrr': '+0.459',
        'for': '1379/161.1',
        'against': '1409/174',
        'points': 12,
        'last5': 'L-W-L-W-W',
        'logo':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RR/Logos/Roundbig/RRroundbig.png',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Container(
              width: MediaQuery.of(context).size.width - 16,
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
                    dataTableTheme: DataTableThemeData(
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
                    headingRowColor: MaterialStateProperty.all(
                      Colors.blue.withOpacity(0.2),
                    ),
                    dataRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blue.withOpacity(0.1);
                        }
                        return Colors.transparent;
                      },
                    ),
                    columns: [
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
                            style: TextStyle(color: Colors.white),
                          )),
                          DataCell(
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    teamStats[index]['teamName'],
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
                          DataCell(Text(
                            teamStats[index]['played'].toString(),
                            style: TextStyle(color: Colors.white70),
                          )),
                          DataCell(Text(
                            teamStats[index]['won'].toString(),
                            style: TextStyle(color: Colors.green),
                          )),
                          DataCell(Text(
                            teamStats[index]['lost'].toString(),
                            style: TextStyle(color: Colors.red),
                          )),
                          DataCell(Text(
                            teamStats[index]['drawn'].toString(),
                            style: TextStyle(color: Colors.white70),
                          )),
                          DataCell(Text(
                            teamStats[index]['tied'].toString(),
                            style: TextStyle(color: Colors.white70),
                          )),
                          DataCell(Text(
                            teamStats[index]['nr'].toString(),
                            style: TextStyle(color: Colors.white70),
                          )),
                          DataCell(Text(
                            teamStats[index]['nrr'],
                            style: TextStyle(
                              color: teamStats[index]['nrr'].startsWith('+')
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          DataCell(Text(
                            teamStats[index]['for'],
                            style: TextStyle(color: Colors.white70),
                          )),
                          DataCell(Text(
                            teamStats[index]['against'],
                            style: TextStyle(color: Colors.white70),
                          )),
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
                                teamStats[index]['points'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          DataCell(Text(
                            teamStats[index]['last5'],
                            style: TextStyle(color: Colors.white70),
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
