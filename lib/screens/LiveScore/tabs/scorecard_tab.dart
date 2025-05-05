import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class ScorecardTab extends StatelessWidget {
  late double width;
  late double height;

   ScorecardTab({super.key});

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
            _buildSectionTitle('WIZARDS Innings'),
            SizedBox(height: height * 0.01),
            
            // Batting header
            Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(flex: 4, child: Text('BATSMAN', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('R', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('B', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('4s', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('6s', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('SR', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                ],
              ),
            ),
            
            // Batsmen list
            _buildBatsmanDetailRow('Rohit Sharma', 'c Maxwell b Starc', '22', '18', '2', '1', '122.22'),
            _buildBatsmanDetailRow('Virat Kohli', 'not out', '15', '12', '1', '1', '125.00'),
            _buildBatsmanDetailRow('KL Rahul', 'b Cummins', '8', '6', '1', '0', '133.33'),
            _buildBatsmanDetailRow('Rishabh Pant', 'lbw b Hazlewood', '0', '1', '0', '0', '0.00'),
            
            SizedBox(height: height * 0.02),
            
            // Extras and total
            Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Extras', style: GoogleFonts.poppins(color: Colors.white70, fontSize: width * 0.012)),
                  Text('2 (b 0, lb 1, w 1, nb 0, p 0)', style: GoogleFonts.poppins(color: Colors.white, fontSize: width * 0.012)),
                ],
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(top: height * 0.01),
              padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: GoogleFonts.poppins(color: Colors.white, fontSize: width * 0.014, fontWeight: FontWeight.bold)),
                  Text('47/3 (5.0 Ov, RR: 9.40)', style: GoogleFonts.poppins(color: Colors.white, fontSize: width * 0.014, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            SizedBox(height: height * 0.02),
            
            // Bowling header
            _buildSectionTitle('Bowling'),
            SizedBox(height: height * 0.01),
            
            Container(
              padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text('BOWLER', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text('O', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('M', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('R', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('W', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                  Expanded(flex: 1, child: Text('ECON', style: GoogleFonts.poppins(color: Colors.blue, fontSize: width * 0.012, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                ],
              ),
            ),
            
            // Bowlers list
            _buildBowlerRow('Mitchell Starc', '2.0', '0', '18', '1', '9.00'),
            _buildBowlerRow('Pat Cummins', '2.0', '0', '15', '1', '7.50'),
            _buildBowlerRow('Josh Hazlewood', '1.0', '0', '14', '1', '14.00'),
            
            SizedBox(height: height * 0.02),
            
            // Fall of wickets
            _buildSectionTitle('Fall of Wickets'),
            SizedBox(height: height * 0.01),
            
            Container(
              padding: EdgeInsets.all(width * 0.015),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1-30 (Rohit Sharma, 3.2 ov), 2-45 (KL Rahul, 4.4 ov), 3-45 (Rishabh Pant, 4.5 ov)',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: width * 0.012,
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

  Widget _buildBatsmanDetailRow(String name, String dismissal, String runs, String balls, String fours,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: width * 0.012,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        dismissal,
                        style: GoogleFonts.poppins(
                          color: Colors.white60,
                          fontSize: width * 0.01,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
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
        margin: EdgeInsets.only(bottom: height * 0.008),
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
}