import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cricket_management/widgets/footer.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({super.key});

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Run Rate Analysis'),
            SizedBox(height: height * 0.01),

            // Run rate chart
            Container(
              height: height * 0.2,
              padding: EdgeInsets.all(width * 0.01),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildRunRateChart(),
            ),

            SizedBox(height: height * 0.02),

            // Batting stats
            _buildSectionTitle('Batting Analysis'),
            SizedBox(height: height * 0.01),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Dot Balls', '12', '40%', Colors.red),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child:
                      _buildStatCard('Boundaries', '8', '26.7%', Colors.blue),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: _buildStatCard('Sixes', '2', '6.7%', Colors.green),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Bowling stats
            _buildSectionTitle('Bowling Analysis'),
            SizedBox(height: height * 0.01),

            Row(
              children: [
                Expanded(
                  child:
                      _buildStatCard('Dot Balls', '10', '33.3%', Colors.green),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: _buildStatCard('Wickets', '3', '10%', Colors.red),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: _buildStatCard('Economy', '9.4', '', Colors.amber),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),

            // Wagon wheel
            _buildSectionTitle('Wagon Wheel'),
            SizedBox(height: height * 0.01),

            Container(
              height: height * 0.25,
              padding: EdgeInsets.all(width * 0.01),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildWagonWheel(),
            ),

            SizedBox(height: height * 0.04),

            // Add Footer with animation
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 800),
              child: const Footer(),
            ),
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

  Widget _buildStatCard(
      String title, String value, String percentage, Color color) {
    return ElasticIn(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.all(width * 0.015),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01,
              ),
            ),
            SizedBox(height: height * 0.005),
            Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: width * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.005),
                if (percentage.isNotEmpty)
                  Text(
                    '($percentage)',
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: width * 0.01,
                    ),
                  ),
              ],
            ),
            SizedBox(height: height * 0.005),
            Container(
              height: height * 0.005,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.7), color.withOpacity(0.3)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRunRateChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.white10,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Colors.white10,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8.0,
                  child: Text(
                    'Over ${value.toInt()}',
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.008,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8.0,
                  child: Text(
                    value.toInt().toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: width * 0.008,
                    ),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.white10),
        ),
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: 12,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 0),
              const FlSpot(1, 8),
              const FlSpot(2, 10),
              const FlSpot(3, 7),
              const FlSpot(4, 11),
              const FlSpot(5, 9.4),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.5),
                Colors.purple.withOpacity(0.5),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Colors.blue,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.purple.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWagonWheel() {
    return Stack(
      children: [
        // Cricket field background
        Center(
          child: Container(
            width: width * 0.3,
            height: width * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withOpacity(0.2),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
          ),
        ),

        // Inner circle (30 yard)
        Center(
          child: Container(
            width: width * 0.15,
            height: width * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
          ),
        ),

        // Pitch
        Center(
          child: Container(
            width: width * 0.05,
            height: width * 0.12,
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),

        // Shot lines
        CustomPaint(
          size: Size(width * 0.4, height * 0.25),
          painter: ShotLinesPainter(),
        ),

        // Legend
        Positioned(
          bottom: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildLegendItem('Fours', Colors.blue),
              const SizedBox(height: 5),
              _buildLegendItem('Sixes', Colors.green),
              const SizedBox(height: 5),
              _buildLegendItem('Other', Colors.amber),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: width * 0.008,
          ),
        ),
      ],
    );
  }
}

class ShotLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Define shot lines
    final shots = [
      // angle, length (% of radius), color
      [30.0, 0.9, Colors.blue], // Four
      [60.0, 1.0, Colors.green], // Six
      [120.0, 0.7, Colors.amber], // Two
      [180.0, 0.8, Colors.blue], // Four
      [240.0, 1.0, Colors.green], // Six
      [300.0, 0.6, Colors.amber], // Single
    ];

    for (var shot in shots) {
      final angle = (shot[0] as double) * (3.14159 / 180); // Convert to radians
      final length = (shot[1] as double) * radius;
      final color = shot[2] as Color;

      final dx = center.dx + length * cos(angle);
      final dy = center.dy + length * sin(angle);

      final paint = Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawLine(center, Offset(dx, dy), paint);

      // Draw dot at the end
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
