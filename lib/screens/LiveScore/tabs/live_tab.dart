import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cricket_management/widgets/footer.dart';

class LiveTab extends StatefulWidget {
  const LiveTab({super.key});

  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
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
            _buildSectionTitle('Current Batsmen'),
            SizedBox(height: height * 0.01),
            _buildBatsmanRow('Rohit Sharma', '22', '18', '2', '1', '122.22'),
            _buildBatsmanRow('Virat Kohli', '15', '12', '1', '1', '125.00'),
            SizedBox(height: height * 0.02),
            _buildSectionTitle('Current Bowler'),
            SizedBox(height: height * 0.01),
            _buildBowlerRow('Jasprit Bumrah', '2.3', '0', '15', '1', '6.00'),
            SizedBox(height: height * 0.02),
            _buildSectionTitle('Last 6 Balls'),
            SizedBox(height: height * 0.01),
            _buildLastBallsRow(['1', 'W', '0', '4', '2', '6']),
            SizedBox(height: height * 0.02),
            _buildSectionTitle('Partnership'),
            SizedBox(height: height * 0.01),
            _buildStatCard('5', 'runs, 0.2 overs, RR: 15.00'),
            SizedBox(height: height * 0.04),
            // Add late animation with Footer
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

  Widget _buildBatsmanRow(String name, String runs, String balls, String fours,
      String sixes, String strikeRate) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.008),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.012,
          vertical: height * 0.008,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                runs,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                balls,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                fours,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                sixes,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                strikeRate,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBowlerRow(String name, String overs, String maidens, String runs,
      String wickets, String economy) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.all(width * 0.01),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                overs,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                maidens,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                runs,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                wickets,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                economy,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: width * 0.012,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastBallsRow(List<String> balls) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: balls.map((ball) {
        Color ballColor;
        Color textColor;
        if (ball == 'W') {
          ballColor = Colors.red.withOpacity(0.3);
          textColor = Colors.red;
        } else if (ball == '4') {
          ballColor = Colors.blue.withOpacity(0.3);
          textColor = Colors.blue;
        } else if (ball == '6') {
          ballColor = Colors.green.withOpacity(0.3);
          textColor = Colors.green;
        } else if (ball == '0') {
          ballColor = Colors.grey.withOpacity(0.3);
          textColor = Colors.grey;
        } else {
          ballColor = Colors.amber.withOpacity(0.3);
          textColor = Colors.amber;
        }

        return Bounce(
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: width * 0.025,
            height: width * 0.025,
            margin: EdgeInsets.only(right: width * 0.008),
            decoration: BoxDecoration(
              color: ballColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: textColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              ball,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: width * 0.012,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return ElasticIn(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.all(width * 0.012),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.035,
              height: width * 0.035,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: width * 0.01),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: width * 0.012,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
