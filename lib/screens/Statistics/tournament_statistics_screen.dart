import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class TournamentStatisticsScreen extends StatelessWidget {
  final Map<String, dynamic> tournamentStats = {
    'totalTournaments': 24,
    'activeTournaments': 3,
    'completedTournaments': 18,
    'upcomingTournaments': 3,
    'totalTeams': 156,
    'totalMatches': 486,
    'popularTournaments': [
      {'name': 'IPL 2024', 'viewCount': 25000},
      {'name': 'World Cup 2023', 'viewCount': 22000},
      {'name': 'Asia Cup 2023', 'viewCount': 18000},
      {'name': 'BBL 2023', 'viewCount': 15000},
    ],
    'tournamentsByMonth': [
      {'month': 'Jan', 'count': 2},
      {'month': 'Feb', 'count': 3},
      {'month': 'Mar', 'count': 4},
      {'month': 'Apr', 'count': 2},
      {'month': 'May', 'count': 1},
      {'month': 'Jun', 'count': 2},
    ],
  };

  TournamentStatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: _buildHeader(),
            ),
            const SizedBox(height: 30),
            FadeInLeft(
              duration: const Duration(milliseconds: 800),
              child: _buildStatCards(),
            ),
            const SizedBox(height: 30),
            FadeInRight(
              duration: const Duration(milliseconds: 800),
              child: _buildCharts(),
            ),
            const SizedBox(height: 30),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: _buildPopularTournaments(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularTournaments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Tournaments',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        ...tournamentStats['popularTournaments']
            .asMap()
            .entries
            .map<Widget>((entry) {
          final tournament = entry.value;
          return FadeInUp(
            duration: Duration(milliseconds: 400 + ((entry.key * 100) as int)),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tournament['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${tournament['viewCount']} views',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Text(
      'Tournament Statistics',
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildStatCards() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Total Tournaments', tournamentStats['totalTournaments'],
            Icons.emoji_events),
        _buildStatCard('Active Tournaments',
            tournamentStats['activeTournaments'], Icons.sports_cricket),
        _buildStatCard(
            'Total Teams', tournamentStats['totalTeams'], Icons.group),
        _buildStatCard(
            'Total Matches', tournamentStats['totalMatches'], Icons.sports),
      ],
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.purple.withOpacity(0.2)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(height: 10),
          Text(
            value.toString(),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCharts() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >=
                      tournamentStats['tournamentsByMonth'].length) {
                    return const Text('');
                  }
                  return Text(
                    tournamentStats['tournamentsByMonth'][value.toInt()]
                        ['month'],
                    style: const TextStyle(color: Colors.white70),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                tournamentStats['tournamentsByMonth'].length,
                (index) => FlSpot(
                  index.toDouble(),
                  tournamentStats['tournamentsByMonth'][index]['count']
                      .toDouble(),
                ),
              ),
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
