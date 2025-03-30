import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:data_table_2/data_table_2.dart';

class PointsTablePage extends StatelessWidget {
  const PointsTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> teamStats = [
      {
        'team': 'Red Dragons',
        'matches': 2,
        'won': 2,
        'lost': 0,
        'draw': 0,
        'tied': 0,
        'nr': 0,
        'points': 4,
        'nrr': '+2.097',
        'for': '154/11.5',
        'against': '131/12',
        'last5': 'W-W',
      },
      {
        'team': 'Mumbai Indians',
        'matches': 5,
        'won': 4,
        'lost': 1,
        'points': 8,
        'nrr': '+0.825',
      },
      {
        'team': 'Chennai Super Kings',
        'matches': 5,
        'won': 3,
        'lost': 2,
        'points': 6,
        'nrr': '+0.456',
      },
      // {
      //   'team': 'Royal Challengers',
      //   'matches': 5,
      //   'won': 3,
      //   'lost': 2,
      //   'points': 6,
      //   'nrr': '+0.123',
      // },
      // {
      //   'team': 'Rajasthan Royals',
      //   'matches': 5,
      //   'won': 2,
      //   'lost': 3,
      //   'points': 4,
      //   'nrr': '-0.234',
      // },
      // {
      //   'team': 'Kolkata Knight Riders',
      //   'matches': 5,
      //   'won': 2,
      //   'lost': 3,
      //   'points': 4,
      //   'nrr': '-0.345',
      // },
      // {
      //   'team': 'Delhi Capitals',
      //   'matches': 5,
      //   'won': 2,
      //   'lost': 3,
      //   'points': 4,
      //   'nrr': '-0.456',
      // }
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Points Table',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable2(
                      columnSpacing: 20,
                      horizontalMargin: 20,
                      minWidth: 1000,
                      headingRowHeight: 60,
                      dataRowHeight: 56,
                      headingRowColor: MaterialStateProperty.all(
                          Colors.teal.withOpacity(0.2)),
                      border: TableBorder(
                        borderRadius: BorderRadius.circular(10),
                        horizontalInside:
                            BorderSide(color: Colors.teal.withOpacity(0.2)),
                      ),
                      columns: [
                        DataColumn2(label: Text('#'), size: ColumnSize.S),
                        DataColumn2(label: Text('Team'), size: ColumnSize.L),
                        DataColumn2(label: Text('M'), size: ColumnSize.S),
                        DataColumn2(label: Text('W'), size: ColumnSize.S),
                        DataColumn2(label: Text('L'), size: ColumnSize.S),
                        DataColumn2(label: Text('D'), size: ColumnSize.S),
                        DataColumn2(label: Text('NRR'), size: ColumnSize.M),
                        DataColumn2(label: Text('Pts'), size: ColumnSize.S),
                        DataColumn2(label: Text('Last 5'), size: ColumnSize.L),
                      ],
                      rows: List<DataRow>.generate(
                        teamStats.length,
                        (index) => DataRow2(
                          color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return index.isEven
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.transparent;
                            },
                          ),
                          cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(teamStats[index]['team'])),
                            DataCell(
                                Text(teamStats[index]['matches'].toString())),
                            DataCell(Text(teamStats[index]['won'].toString())),
                            DataCell(Text(teamStats[index]['lost'].toString())),
                            DataCell(Text(
                                teamStats[index]['draw']?.toString() ?? '0')),
                            DataCell(
                                _buildNRRText(teamStats[index]['nrr'], width)),
                            DataCell(_buildPointsText(
                                teamStats[index]['points'].toString(), width)),
                            DataCell(_buildLast5Widget(
                                teamStats[index]['last5'] ?? '-', width)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _headerStyle(double width) {
    return GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _cellStyle(double width) {
    return GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 15,
    );
  }

  TextStyle _teamStyle(double width) {
    return GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildNRRText(String text, double width) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: text.startsWith('+') ? Colors.green[300] : Colors.red[300],
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPointsText(String text, double width) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.blue[300],
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLast5Widget(String text, double width) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: text.split('-').map((result) {
        Color color = result == 'W'
            ? Colors.green[300]!
            : result == 'L'
                ? Colors.red[300]!
                : Colors.grey[300]!;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            result,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
