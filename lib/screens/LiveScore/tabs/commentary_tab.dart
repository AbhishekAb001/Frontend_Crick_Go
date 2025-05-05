import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cricket_management/widgets/footer.dart';

class CommentaryTab extends StatefulWidget {
  const CommentaryTab({super.key});

  @override
  State<CommentaryTab> createState() => _CommentaryTabState();
}

class _CommentaryTabState extends State<CommentaryTab> {
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
            _buildSectionTitle('Live Commentary'),
            SizedBox(height: height * 0.01),

            // Commentary items
            _buildCommentaryItem(
              '0.2',
              'FOUR! Rohit Sharma finds the gap through covers. Excellent timing!',
              isHighlight: true,
              highlightType: 'boundary',
            ),
            _buildCommentaryItem(
              '0.1',
              'Dot ball. Good length delivery, Rohit defends it solidly.',
            ),
            _buildOverSeparator('End of Over 0 - 4 runs, 0 wickets'),
            _buildCommentaryItem(
              '0.0',
              'Mitchell Starc to Rohit Sharma, match begins!',
              isHighlight: true,
              highlightType: 'start',
            ),

            SizedBox(height: height * 0.02),

            // Key events section
            _buildSectionTitle('Key Events'),
            SizedBox(height: height * 0.01),

            _buildKeyEventItem(
              'Toss',
              'Wizards won the toss and elected to bat first',
              Icons.sports_cricket,
            ),
            _buildKeyEventItem(
              'Match Start',
              '10:17 PM',
              Icons.access_time,
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

  Widget _buildCommentaryItem(String over, String commentary,
      {bool isHighlight = false, String highlightType = ''}) {
    Color bgColor = Colors.white.withOpacity(0.05);
    Color borderColor = Colors.transparent;

    if (isHighlight) {
      switch (highlightType) {
        case 'boundary':
          bgColor = Colors.blue.withOpacity(0.1);
          borderColor = Colors.blue.withOpacity(0.3);
          break;
        case 'wicket':
          bgColor = Colors.red.withOpacity(0.1);
          borderColor = Colors.red.withOpacity(0.3);
          break;
        case 'six':
          bgColor = Colors.green.withOpacity(0.1);
          borderColor = Colors.green.withOpacity(0.3);
          break;
        case 'start':
          bgColor = Colors.purple.withOpacity(0.1);
          borderColor = Colors.purple.withOpacity(0.3);
          break;
        default:
          bgColor = Colors.amber.withOpacity(0.1);
          borderColor = Colors.amber.withOpacity(0.3);
      }
    }

    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.01),
        padding: EdgeInsets.all(width * 0.015),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.04,
              height: width * 0.04,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                over,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.01,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: width * 0.01),
            Expanded(
              child: Text(
                commentary,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.012,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverSeparator(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      padding: EdgeInsets.symmetric(vertical: height * 0.008),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: width * 0.01,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildKeyEventItem(String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01),
      padding: EdgeInsets.all(width * 0.015),
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
          Container(
            width: width * 0.04,
            height: width * 0.04,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: width * 0.02,
            ),
          ),
          SizedBox(width: width * 0.01),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: width * 0.012,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: width * 0.01,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
