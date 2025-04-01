import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // Add this package

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Batsmen', 'Bowlers', 'Fielders', 'MVP'];
  String? selectedTeam;
  String? selectedStyle;

  final List<String> teams = [
    'All Teams',
    'Mumbai Indians',
    'Chennai Super Kings',
    'Royal Challengers',
    'Gujarat Titans',
    'Rajasthan Royals',
  ];

  final List<String> styles = [
    'All Styles',
    'Right-handed',
    'Left-handed',
    'Fast Bowler',
    'Spin Bowler',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    selectedTeam = teams[0];
    selectedStyle = styles[0];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and dropdowns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: _buildTabBar(width, height),
              ),

              // Dropdowns container
              Row(
                children: [
                  // Style filter dropdown
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 100),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Style',
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.01,
                            color: Colors.white70,
                          ),
                        ),
                        items: styles
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.poppins(
                                      fontSize: width * 0.01,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedStyle,
                        onChanged: (value) {
                          setState(() {
                            selectedStyle = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: height * 0.05,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.2),
                                Colors.blue.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: height * 0.3,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.8),
                          ),
                          offset: const Offset(0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          height: height * 0.05,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.01),

                  // Team filter dropdown
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Team',
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.01,
                            color: Colors.white70,
                          ),
                        ),
                        items: teams
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.poppins(
                                      fontSize: width * 0.01,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedTeam,
                        onChanged: (value) {
                          setState(() {
                            selectedTeam = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: height * 0.05,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.2),
                                Colors.blue.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: height * 0.3,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.8),
                          ),
                          offset: const Offset(0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          height: height * 0.05,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Add spacing
          SizedBox(height: height * 0.03),

          // Add TabBarView with player cards - use Flexible instead of Expanded

          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: width * 0.02,
                mainAxisSpacing: height * 0.02,
              ),
              shrinkWrap: true,
              itemCount: _getBatsmenData().length,
              itemBuilder: (context, index) {
                return _buildPlayerCard(
                    width, height, _getBatsmenData()[index], index);
              }),

          // Add spacing
          SizedBox(height: height * 0.03),
          // Footer
          const Footer()
        ],
      ),
    );
  }

  Widget _buildTabBar(double width, double height) {
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

  // Individual player card
  Widget _buildPlayerCard(
      double width, double height, Map<String, String> player, int index) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.blue.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Rank indicator
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: width * 0.02,
                height: width * 0.02,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 0
                      ? Colors.amber.withOpacity(0.2)
                      : index == 1
                          ? Colors.grey.withOpacity(0.2)
                          : index == 2
                              ? Colors.brown.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.1),
                  border: Border.all(
                    color: index == 0
                        ? Colors.amber
                        : index == 1
                            ? Colors.grey
                            : index == 2
                                ? Colors.brown
                                : Colors.blue.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: EdgeInsets.all(width * 0.015),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Player image
                  Container(
                    width: width * 0.05,
                    height: width * 0.05,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: player['image'] ?? "",
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          color: Colors.white,
                          size: width * 0.03,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.01),

                  // Player name
                  Text(
                    player['name'] ?? "Player",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Team name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shield,
                        color: Colors.blue.withOpacity(0.7),
                        size: width * 0.008,
                      ),
                      SizedBox(width: 4),
                      Text(
                        player['team'] ?? "Team",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: width * 0.008,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Stats
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          player['stat'] ?? "0",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          player['detail'] ?? "No details",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: width * 0.008,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

  // Data providers for each tab
  List<Map<String, String>> _getBatsmenData() {
    return [
      {
        'name': 'Virat Kohli',
        'team': 'Royal Challengers',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/2.png',
        'stat': '264 runs',
        'detail': 'Avg: 52.80 | SR: 147.32',
      },
      {
        'name': 'Rohit Sharma',
        'team': 'Mumbai Indians',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/6.png',
        'stat': '228 runs',
        'detail': 'Avg: 45.60 | SR: 142.50',
      },
      {
        'name': 'KL Rahul',
        'team': 'Lucknow Super Giants',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/19.png',
        'stat': '215 runs',
        'detail': 'Avg: 43.00 | SR: 139.61',
      },
      {
        'name': 'Shubman Gill',
        'team': 'Gujarat Titans',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/62.png',
        'stat': '190 runs',
        'detail': 'Avg: 38.00 | SR: 141.79',
      },
      {
        'name': 'Jos Buttler',
        'team': 'Rajasthan Royals',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/637.png',
        'stat': '175 runs',
        'detail': 'Avg: 35.00 | SR: 155.75',
      },
      //add three more players
      {
        'name': 'Sachin Tendulkar',
        'team': 'Royal Challengers',
        'image':
            'URL_ADDRESScciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/1.png',
        'stat': '264 runs',
        'detail': 'Avg: 52.80 | SR: 147.32',
      },
      {
        'name': 'Rishabh Pant',
        'team': 'Lucknow Super Giants',
        'image':
            'URL_ADDRESScciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/19.png',
        'stat': '215 runs',
        'detail': 'Avg: 43.00 | SR: 139.61',
      },
      {
        'name': 'Hardik Pandya',
        'team': 'Royal Challengers',
        'image':
            'URL_ADDRESScciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/2.png',
        'stat': '264 runs',
        'detail': 'Avg: 52.80 | SR: 147.32',
      }
    ];
  }

  List<Map<String, String>> _getBowlersData() {
    return [
      {
        'name': 'Jasprit Bumrah',
        'team': 'Mumbai Indians',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/1.png',
        'stat': '12 wickets',
        'detail': 'Econ: 6.25 | Avg: 15.33',
      },
      {
        'name': 'Mohammed Shami',
        'team': 'Gujarat Titans',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/47.png',
        'stat': '10 wickets',
        'detail': 'Econ: 7.15 | Avg: 18.40',
      },
      {
        'name': 'Yuzvendra Chahal',
        'team': 'Rajasthan Royals',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/10.png',
        'stat': '9 wickets',
        'detail': 'Econ: 7.85 | Avg: 20.11',
      },
      {
        'name': 'Rashid Khan',
        'team': 'Gujarat Titans',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/218.png',
        'stat': '8 wickets',
        'detail': 'Econ: 6.90 | Avg: 22.50',
      },
      {
        'name': 'Trent Boult',
        'team': 'Rajasthan Royals',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/969.png',
        'stat': '7 wickets',
        'detail': 'Econ: 8.10 | Avg: 24.71',
      },
    ];
  }

  List<Map<String, String>> _getFieldersData() {
    return [
      {
        'name': 'Ravindra Jadeja',
        'team': 'Chennai Super Kings',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/9.png',
        'stat': '6 catches',
        'detail': '2 run outs | 98% success',
      },
      {
        'name': 'Faf du Plessis',
        'team': 'Royal Challengers',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/94.png',
        'stat': '5 catches',
        'detail': '1 run out | 96% success',
      },
      {
        'name': 'Suryakumar Yadav',
        'team': 'Mumbai Indians',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/48.png',
        'stat': '4 catches',
        'detail': '2 run outs | 95% success',
      },
      {
        'name': 'David Warner',
        'team': 'Delhi Capitals',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/214.png',
        'stat': '4 catches',
        'detail': '1 run out | 94% success',
      },
      {
        'name': 'Kane Williamson',
        'team': 'Gujarat Titans',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/440.png',
        'stat': '3 catches',
        'detail': '2 run outs | 93% success',
      },
    ];
  }

  List<Map<String, String>> _getMVPData() {
    return [
      {
        'name': 'Hardik Pandya',
        'team': 'Gujarat Titans',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/54.png',
        'stat': '180 pts',
        'detail': '220 runs | 8 wickets',
      },
      {
        'name': 'Andre Russell',
        'team': 'Kolkata Knight Riders',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/141.png',
        'stat': '165 pts',
        'detail': '185 runs | 10 wickets',
      },
      {
        'name': 'Marcus Stoinis',
        'team': 'Lucknow Super Giants',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/23.png',
        'stat': '155 pts',
        'detail': '175 runs | 7 wickets',
      },
      {
        'name': 'Ravindra Jadeja',
        'team': 'Chennai Super Kings',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/9.png',
        'stat': '145 pts',
        'detail': '120 runs | 9 wickets',
      },
      {
        'name': 'Glenn Maxwell',
        'team': 'Royal Challengers',
        'image':
            'https://bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/28.png',
        'stat': '135 pts',
        'detail': '165 runs | 5 wickets',
      },
    ];
  }
}
