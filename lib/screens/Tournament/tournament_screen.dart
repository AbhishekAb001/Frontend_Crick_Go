import 'package:cricket_management/screens/Tournament/tournament_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class TournamentScreen extends StatefulWidget {
  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  String selectedFilter = 'Ongoing';
  late double width;
  late double height;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> tournaments = [
    {
      'name': 'IPL 2024',
      'image':
          'https://assets.bcci.tv/bcci/photos/7000/04453927-87d4-4e7e-b938-d0e6c463bca8.jpg',
      'teams': '10 ',
      'duration': '2 Months'
    },
    {
      'name': 'T20 World Cup 2030 between India and Australia',
      'image':
          'https://assets.bcci.tv/bcci/photos/1041/9f053e47-8870-4fb3-8394-fd09082c8e59.jpg',
      'teams': '16 ',
      'duration': '1 Month'
    },
    {
      'name': 'Asia Cup',
      'image':
          'https://assets.bcci.tv/bcci/photos/1042/c2bb1f9e-051d-4cfa-b9cd-0322b1c9851f.jpg',
      'teams': '6 ',
      'duration': '2 Weeks'
    },
    {
      'name': 'Test Series',
      'image':
          'https://assets.bcci.tv/bcci/photos/1039/b7493d77-7791-4592-b722-3fdd9e64eba2.jpg',
      'teams': '2 ',
      'duration': '1 Month'
    },
  ];

  // Track hover state for each card
  late List<bool> _isHovering;

  @override
  void initState() {
    super.initState();
    _isHovering = List<bool>.filled(tournaments.length, false);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Container(
        padding: EdgeInsets.all(width * 0.015),
        child: Column(
          children: [
            // Search bar on top
            SlideInRight(
              duration: Duration(milliseconds: 600),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: width * 0.3,
                  height: width * 0.03,
                  margin: EdgeInsets.only(bottom: width * 0.01),
                  child: TextField(
                    controller: _searchController,
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.01),
                    decoration: InputDecoration(
                      hintText: 'Search tournaments...',
                      hintStyle: TextStyle(
                          color: Colors.white60, fontSize: width * 0.01),
                      prefixIcon: Icon(Icons.search,
                          color: Colors.white60, size: width * 0.015),
                      filled: true,
                      fillColor: Colors.blue[900]?.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Main content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories Column
                  SlideInLeft(
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900]?.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: width * 0.01, horizontal: width * 0.02),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildFilterOption('All'),
                          _buildFilterOption('Past'),
                          _buildFilterOption('Ongoing'),
                          _buildFilterOption('Upcoming'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  // Tournament Cards
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3.2,
                      ),
                      itemCount: tournaments.length,
                      itemBuilder: (context, index) {
                        final tournament = tournaments[index];
                        // Filter tournaments based on search query
                        if (_searchQuery.isNotEmpty &&
                            !tournament['name']!
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())) {
                          return const SizedBox.shrink();
                        }
                        return _buildTournamentCard(index);
                      },
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

  Widget _buildFilterOption(String filter) {
    bool isSelected = selectedFilter == filter;
    return Bounce(
      duration: Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = filter),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: width * 0.01,
            horizontal: width * 0.02,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[900] : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            filter,
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentCard(int index) {
    final tournament = tournaments[index];
    return FadeInUp(
        delay: Duration(milliseconds: 100 * index),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovering[index] = true),
          onExit: (_) => setState(() => _isHovering[index] = false),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TournamentDetailScreen(
                    tournament: tournament,
                  ),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: _isHovering[index]
                  ? (Matrix4.identity()..scale(1.03))
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF242730),
                boxShadow: _isHovering[index]
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ]
                    : const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
              ),
              child: ElasticIn(
                duration: Duration(milliseconds: 800),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * 0.01,
                        horizontal: width * 0.008,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.08,
                            clipBehavior: Clip.antiAlias,
                            height: width * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: tournament['image']!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(width: width * 0.01),

                          ///Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.15,
                                child: Text(
                                  tournament['name']!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: width * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.01),

                              ///Date
                              Text(
                                "28-Mar-2022 To 30-Apr-2022",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.008,
                                ),
                              ),
                              SizedBox(height: height * 0.01),

                              ///Location
                              Text(
                                "Location: India",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.008,
                                ),
                              ),
                              SizedBox(height: height * 0.01),

                              ///Teams
                              Text(
                                "Teams :${tournament['teams']!} / 20",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.008,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(width * 0.008),
                      height: width * 0.03,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: Colors.lightBlue,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Upcomming",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.01,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
