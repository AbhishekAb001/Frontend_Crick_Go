import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_management/widgets/footer.dart'; // Add this import

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  double width = 0;
  double height = 0;
  int? hoveredIndex;

  final List<Map<String, dynamic>> teams = [
    {
      'name': 'Mumbai Indians',
      'captain': 'Hardik Pandya',
      'logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/MI/Logos/Roundbig/MIroundbig.png',
    },
    {
      'name': 'Chennai Super Kings',
      'captain': 'MS Dhoni',
      'logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/CSK/logos/Roundbig/CSKroundbig.png',
    },
    {
      'name': 'Royal Challengers',
      'captain': 'Faf du Plessis',
      'logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RCB/Logos/Roundbig/RCBroundbig.png',
    },
    {
      'name': 'Rajasthan Royals',
      'captain': 'Sanju Samson',
      'logo':
          'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/RR/Logos/Roundbig/RRroundbig.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.95, // Adjusted ratio
                crossAxisSpacing: width * 0.02,
                mainAxisSpacing: height * 0.025,
              ),
              itemCount: teams.length,
              itemBuilder: (context, index) => _buildTeamCard(index),
            ),
            SizedBox(height: width * 0.02),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 400 + (index * 100)),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = null),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(width * 0.015),
          // margin: EdgeInsets.all(width * 0.02),
          decoration: BoxDecoration(
            color: hoveredIndex == index
                ? Colors.white.withOpacity(0.15)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: hoveredIndex == index
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.blue.withOpacity(0.3),
              width: hoveredIndex == index ? 2 : 1,
            ),
            boxShadow: hoveredIndex == index
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Team Logo
              Hero(
                tag: 'team_${teams[index]['name']}',
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1531415074968-036ba1b575da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y3JpY2tldHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
                  height: height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                ),
              ),
              SizedBox(height: height * 0.02),

              // Team Name
              Text(
                teams[index]['name']!,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.01),

              // Captain Info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sports_cricket,
                    color: Colors.blue.withOpacity(0.7),
                    size: width * 0.015,
                  ),
                  SizedBox(width: width * 0.005),
                  Text(
                    teams[index]['captain']!,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: width * 0.012,
                    ),
                  ),
                ],
              ),

              // Additional Stats
              Container(
                margin: EdgeInsets.only(top: height * 0.02),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('Players', '25'),
                    _buildStatItem('Titles', '5'),
                    _buildStatItem('Rank', '#3'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.012,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: width * 0.01,
          ),
        ),
      ],
    );
  }
}
