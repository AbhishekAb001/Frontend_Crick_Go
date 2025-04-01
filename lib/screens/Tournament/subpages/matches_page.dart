import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

const List<String> tabs = ['Live', 'Upcoming', 'Completed'];

// Add hardcoded matches data
final List<Map<String, dynamic>> dummyMatches = [
  {
    'team1': 'India',
    'team1Logo':
        'https://media.istockphoto.com/id/472317739/vector/flag-of-india.jpg',
    'team2': 'Australia',
    'team2Logo':
        'https://media.istockphoto.com/id/1340727526/vector/australia-flag-vector-illustration.jpg',
    'venue': 'MCG, Melboudownrne',
    'score1': '120/6',
    'overs1': '15.2',
    'score2': '85/3',
    'overs2': '10.4',
  },
  {
    'team1': 'England and the United Kingdom',
    'team1Logo':
        'https://media.istockphoto.com/id/1063640060/vector/flag-of-england.jpg',
    'team2': 'Pakistan',
    'team2Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-pakistan.jpg',
    'venue':
        'Lords, London ijiojfdjaojfioajiodjfoiajfoidjaois aoidj fpoijs fiaiojfpoiajoip fpiuh ',
    'score1': '180/4',
    'overs1': '18.0',
    'score2': '120/3',
    'overs2': '12.4',
  },
  {
    'team1': 'South Africa',
    'team1Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-south-africa.jpg',
    'team2': 'New Zealand',
    'team2Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-new-zealand.jpg',
    'venue': 'Eden Park, Auckland',
    'score1': '156/7',
    'overs1': '20.0',
    'score2': '98/5',
    'overs2': '14.2',
  },
];

//upcoming matches
final List<Map<String, dynamic>> upcomingMatches = [
  {
    'team1': 'West Indies',
    'team1Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-west-indies.jpg',
    'team2': 'Sri Lanka',
    'team2Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-sri-lanka.jpg',
    'venue': 'Bridgetown, Barbados',
    'matchTime': '15:30 GMT',
    'matchDate': '25 Dec 2023',
    'matchType': 'Semi Final',
  },
  {
    'team1': 'Zimbabwe',
    'team1Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-zimbabwe.jpg',
    'team2': 'Ireland',
    'team2Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-ireland.jpg',
    'venue': 'Harare Sports Club',
    'matchTime': '13:00 GMT',
    'matchDate': '26 Dec 2023',
    'matchType': 'Quarter Final',
  },
];

//completed matches
final List<Map<String, dynamic>> completedMatches = [
  {
    'team1': 'Bangladesh',
    'team1Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-bangladesh.jpg',
    'team2': 'Afghanistan',
    'team2Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-afghanistan.jpg',
    'venue': 'Dhaka Stadium',
    'score1': '245/6',
    'overs1': '20.0',
    'score2': '240/8',
    'overs2': '20.0',
    'result': 'Bangladesh won by 5 runs',
    'matchType': 'Group Stage',
  },
  {
    'team1': 'Netherlands',
    'team1Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-netherlands.jpg',
    'team2': 'Scotland',
    'team2Logo':
        'https://media.istockphoto.com/id/1063640158/vector/flag-of-scotland.jpg',
    'venue': 'Amsterdam Arena',
    'score1': '189/4',
    'overs1': '20.0',
    'score2': '156/9',
    'overs2': '20.0',
    'result': 'Netherlands won by 33 runs',
    'matchType': 'Group Stage',
  },
];

class MatchesPage extends StatefulWidget {
  const MatchesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            SizedBox(height: height * 0.02),
            GridView.builder(
              shrinkWrap: true, // Add this
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.02,
                mainAxisSpacing: height * 0.02,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final currentMatches = _tabController.index == 0
                    ? dummyMatches
                    : _tabController.index == 1
                        ? upcomingMatches
                        : completedMatches;
                return _buildLiveMatchCard(currentMatches[index]);
              },
              itemCount: _tabController.index == 0
                  ? dummyMatches.length
                  : _tabController.index == 1
                      ? upcomingMatches.length
                      : completedMatches.length,
            ),
            SizedBox(height: height * 0.02),
            const Footer()
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
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

 

  Widget _buildLiveMatchCard(Map<String, dynamic> match) {
    return Container(
      padding: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.purple.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'T20I',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.01,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.008,
                  vertical: height * 0.003,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Live',
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: width * 0.01,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.05),
          Text(
            match['venue'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: width * 0.01,
            ),
          ),
          SizedBox(height: height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: match['team1Logo'],
                      height: height * 0.08, // Increased image size
                      width: height * 0.08,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      match['team1'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.01,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      '${match['score1']} (${match['overs1']})',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: width * 0.01,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Text(
                  'VS',
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: width * 0.012,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: match['team2Logo'],
                      height: height * 0.08, // Increased image size
                      width: height * 0.08,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      match['team2'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.01,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      '${match['score2']} (${match['overs2']})',
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
          SizedBox(height: height * 0.05),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.01,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'India won the toss and elected to bat first',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.009,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
