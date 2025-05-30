import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable lists
  final RxList<Map<String, dynamic>> news = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> topTeams = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> liveMatches = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> upcomingMatches =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> playerStats = <Map<String, dynamic>>[].obs;
  final RxString selectedTournament = 'IPL 2024'.obs;

  // Top run-scorers (Most Runs)
  final RxList<Map<String, dynamic>> topRunScorers = [
    {
      'rank': 1,
      'name': 'Virat Kohli',
      'matches': 11,
      'innings': 11,
      'runs': 505,
      'average': 63.12,
      'strike_rate': 143.47,
      'fours': 44,
      'sixes': 18,
    },
    {
      'rank': 2,
      'name': 'Sai Sudharsan',
      'matches': 10,
      'innings': 10,
      'runs': 504,
      'average': 50.40,
      'strike_rate': 154.13,
      'fours': 55,
      'sixes': 16,
    },
    {
      'rank': 3,
      'name': 'Suryakumar Yadav',
      'matches': 11,
      'innings': 11,
      'runs': 475,
      'average': 67.86,
      'strike_rate': 172.73,
      'fours': 46,
      'sixes': 26,
    },
    {
      'rank': 4,
      'name': 'Yashasvi Jaiswal',
      'matches': 12,
      'innings': 12,
      'runs': 473,
      'average': 43.00,
      'strike_rate': 154.58,
      'fours': 46,
      'sixes': 25,
    },
    {
      'rank': 5,
      'name': 'Jos Buttler',
      'matches': 10,
      'innings': 10,
      'runs': 470,
      'average': 78.33,
      'strike_rate': 169.06,
      'fours': 46,
      'sixes': 21,
    },
  ].obs;

  // Top wicket-takers (Most Wickets)
  final RxList<Map<String, dynamic>> topWicketTakers = [
    {
      'rank': 1,
      'name': 'Prasidh Krishna',
      'matches': 10,
      'overs': 39.0,
      'balls': 234,
      'wickets': 19,
      'average': 15.37,
      'runs': 292,
      'four_fers': 1,
      'five_fers': '-',
    },
    {
      'rank': 2,
      'name': 'Josh Hazlewood',
      'matches': 10,
      'overs': 36.5,
      'balls': 221,
      'wickets': 18,
      'average': 17.28,
      'runs': 311,
      'four_fers': 1,
      'five_fers': '-',
    },
    {
      'rank': 3,
      'name': 'Arshdeep Singh',
      'matches': 11,
      'overs': 36.2,
      'balls': 218,
      'wickets': 16,
      'average': 18.19,
      'runs': 291,
      'four_fers': '-',
      'five_fers': '-',
    },
    {
      'rank': 4,
      'name': 'Noor Ahmad',
      'matches': 11,
      'overs': 39.0,
      'balls': 234,
      'wickets': 16,
      'average': 19.62,
      'runs': 314,
      'four_fers': '-',
      'five_fers': '-',
    },
    {
      'rank': 5,
      'name': 'Trent Boult',
      'matches': 11,
      'overs': 38.1,
      'balls': 229,
      'wickets': 16,
      'average': 21.00,
      'runs': 336,
      'four_fers': 1,
      'five_fers': '-',
    },
  ].obs;

  // Tournament list with realistic data
  final List<Map<String, dynamic>> tournaments = [
    {
      'name': 'IPL 2025',
      'icon': '🏆',
      'color': '#FF9933',
      'stats': {
        'totalMatches': 74,
        'liveMatches': 2,
        'upcomingMatches': 8,
        'completedMatches': 64,
      }
    },
    {
      'name': 'LPL 2025',
      'icon': '🦁',
      'color': '#1A8F29',
      'stats': {
        'totalMatches': 34,
        'liveMatches': 1,
        'upcomingMatches': 5,
        'completedMatches': 28,
      }
    },
    {
      'name': 'BBL 2025',
      'icon': '🔥',
      'color': '#1976D2',
      'stats': {
        'totalMatches': 56,
        'liveMatches': 0,
        'upcomingMatches': 7,
        'completedMatches': 49,
      }
    }
  ];

  // Dashboard stats
  final RxMap<String, dynamic> dashboardStats = {
    'totalMatches': 74,
    'liveMatches': 2,
    'upcomingMatches': 8,
    'completedMatches': 64,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void changeTournament(String tournamentName) {
    selectedTournament.value = tournamentName;
    final tournament =
        tournaments.firstWhere((t) => t['name'] == tournamentName);
    dashboardStats.value = tournament['stats'];
    loadMockData();
  }

  void loadMockData() {
    // IPL 2025
    if (selectedTournament.value == 'IPL 2025') {
      // Points Table
      topTeams.value = [
        {
          'rank': 1,
          'name': 'Royal Challengers Bengaluru',
          'matches': 11,
          'won': 8,
          'lost': 3,
          'points': 16,
          'nrr': '+0.482',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 2,
          'name': 'Punjab Kings',
          'matches': 11,
          'won': 7,
          'lost': 3,
          'points': 15,
          'nrr': '+0.376',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 3,
          'name': 'Mumbai Indians',
          'matches': 11,
          'won': 7,
          'lost': 4,
          'points': 14,
          'nrr': '+1.274',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 4,
          'name': 'Gujarat Titans',
          'matches': 10,
          'won': 7,
          'lost': 3,
          'points': 14,
          'nrr': '+0.867',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 5,
          'name': 'Delhi Capitals',
          'matches': 10,
          'won': 6,
          'lost': 4,
          'points': 12,
          'nrr': '+0.362',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 6,
          'name': 'Kolkata Knight Riders',
          'matches': 11,
          'won': 5,
          'lost': 5,
          'points': 11,
          'nrr': '+0.249',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 7,
          'name': 'Lucknow Super Giants',
          'matches': 11,
          'won': 5,
          'lost': 6,
          'points': 10,
          'nrr': '-0.469',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 8,
          'name': 'Rajasthan Royals',
          'matches': 12,
          'won': 3,
          'lost': 9,
          'points': 6,
          'nrr': '-0.718',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 9,
          'name': 'Sunrisers Hyderabad',
          'matches': 10,
          'won': 3,
          'lost': 7,
          'points': 6,
          'nrr': '-1.192',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 10,
          'name': 'Chennai Super Kings',
          'matches': 11,
          'won': 2,
          'lost': 9,
          'points': 4,
          'nrr': '-1.117',
          'image_path': 'assets/batball.jpg',
        },
      ];
      // Upcoming Matches
      upcomingMatches.value = [
        {
          'date': 'May 05, Mon',
          'match': 'Sunrisers Hyderabad vs Delhi Capitals, 55th Match',
          'venue': 'Rajiv Gandhi International Stadium, Hyderabad',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 06, Tue',
          'match': 'Mumbai Indians vs Gujarat Titans, 56th Match',
          'venue': 'Wankhede Stadium, Mumbai',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 07, Wed',
          'match': 'Kolkata Knight Riders vs Chennai Super Kings, 57th Match',
          'venue': 'Eden Gardens, Kolkata',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 08, Thu',
          'match': 'Punjab Kings vs Delhi Capitals, 58th Match',
          'venue': 'Himachal Pradesh Cricket Association Stadium, Dharamsala',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 09, Fri',
          'match':
              'Lucknow Super Giants vs Royal Challengers Bengaluru, 59th Match',
          'venue':
              'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium, Lucknow',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 10, Sat',
          'match': 'Sunrisers Hyderabad vs Kolkata Knight Riders, 60th Match',
          'venue': 'Rajiv Gandhi International Stadium, Hyderabad',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 11, Sun',
          'match': 'Punjab Kings vs Mumbai Indians, 61st Match',
          'venue': 'Himachal Pradesh Cricket Association Stadium, Dharamsala',
          'time_local': '3:30 PM',
          'time_gmt': '10:00 AM GMT / 03:30 PM LOCAL',
        },
        {
          'date': 'May 11, Sun',
          'match': 'Delhi Capitals vs Gujarat Titans, 62nd Match',
          'venue': 'Arun Jaitley Stadium, Delhi',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 12, Mon',
          'match': 'Chennai Super Kings vs Rajasthan Royals, 63rd Match',
          'venue': 'MA Chidambaram Stadium, Chennai',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 13, Tue',
          'match':
              'Royal Challengers Bengaluru vs Sunrisers Hyderabad, 64th Match',
          'venue': 'M.Chinnaswamy Stadium, Bengaluru',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 14, Wed',
          'match': 'Gujarat Titans vs Lucknow Super Giants, 65th Match',
          'venue': 'Narendra Modi Stadium, Ahmedabad',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 15, Thu',
          'match': 'Mumbai Indians vs Delhi Capitals, 66th Match',
          'venue': 'Wankhede Stadium, Mumbai',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 16, Fri',
          'match': 'Rajasthan Royals vs Punjab Kings, 67th Match',
          'venue': 'Sawai Mansingh Stadium, Jaipur',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 17, Sat',
          'match':
              'Royal Challengers Bengaluru vs Kolkata Knight Riders, 68th Match',
          'venue': 'M.Chinnaswamy Stadium, Bengaluru',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 18, Sun',
          'match': 'Gujarat Titans vs Chennai Super Kings, 69th Match',
          'venue': 'Narendra Modi Stadium, Ahmedabad',
          'time_local': '3:30 PM',
          'time_gmt': '10:00 AM GMT / 03:30 PM LOCAL',
        },
        {
          'date': 'May 18, Sun',
          'match': 'Lucknow Super Giants vs Sunrisers Hyderabad, 70th Match',
          'venue':
              'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium, Lucknow',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 20, Tue',
          'match': 'TBC vs TBC, Qualifier 1',
          'venue': 'Rajiv Gandhi International Stadium, Hyderabad',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 21, Wed',
          'match': 'TBC vs TBC, Eliminator',
          'venue': 'Rajiv Gandhi International Stadium, Hyderabad',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 23, Fri',
          'match': 'TBC vs TBC, Qualifier 2',
          'venue': 'Eden Gardens, Kolkata',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'May 25, Sun',
          'match': 'TBC vs TBC, Final',
          'venue': 'Eden Gardens, Kolkata',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
      ];
      // Most Runs
      topRunScorers.value = [
        {
          'rank': 1,
          'name': 'Avishka Fernando',
          'matches': 8,
          'innings': 8,
          'runs': 350,
          'average': 43.75,
          'strike_rate': 145.2,
          'fours': 38,
          'sixes': 12,
        },
        {
          'rank': 2,
          'name': 'Kusal Mendis',
          'matches': 8,
          'innings': 8,
          'runs': 330,
          'average': 41.25,
          'strike_rate': 138.7,
          'fours': 34,
          'sixes': 10,
        },
        {
          'rank': 3,
          'name': 'Bhanuka Rajapaksa',
          'matches': 8,
          'innings': 8,
          'runs': 310,
          'average': 38.75,
          'strike_rate': 132.5,
          'fours': 30,
          'sixes': 11,
        },
        {
          'rank': 4,
          'name': 'Dinesh Chandimal',
          'matches': 8,
          'innings': 8,
          'runs': 295,
          'average': 36.87,
          'strike_rate': 128.9,
          'fours': 28,
          'sixes': 9,
        },
        {
          'rank': 5,
          'name': 'Rahmanullah Gurbaz',
          'matches': 8,
          'innings': 8,
          'runs': 280,
          'average': 35.0,
          'strike_rate': 130.0,
          'fours': 25,
          'sixes': 8,
        },
      ];
      // Most Wickets
      topWicketTakers.value = [
        {
          'rank': 1,
          'name': 'Wanindu Hasaranga',
          'matches': 8,
          'overs': 32.0,
          'balls': 192,
          'wickets': 18,
          'average': 13.5,
          'runs': 243,
          'four_fers': 1,
          'five_fers': '-',
        },
        {
          'rank': 2,
          'name': 'Nuwan Pradeep',
          'matches': 8,
          'overs': 31.0,
          'balls': 186,
          'wickets': 15,
          'average': 15.2,
          'runs': 228,
          'four_fers': 1,
          'five_fers': '-',
        },
        {
          'rank': 3,
          'name': 'Dushmantha Chameera',
          'matches': 8,
          'overs': 30.0,
          'balls': 180,
          'wickets': 13,
          'average': 17.0,
          'runs': 221,
          'four_fers': '-',
          'five_fers': '-',
        },
        {
          'rank': 4,
          'name': 'Akila Dananjaya',
          'matches': 8,
          'overs': 29.0,
          'balls': 174,
          'wickets': 12,
          'average': 18.5,
          'runs': 222,
          'four_fers': '-',
          'five_fers': '-',
        },
        {
          'rank': 5,
          'name': 'Suranga Lakmal',
          'matches': 8,
          'overs': 28.0,
          'balls': 168,
          'wickets': 11,
          'average': 20.0,
          'runs': 220,
          'four_fers': '-',
          'five_fers': '-',
        },
      ];
      // News
      news.value = [
        {
          'title': 'IPL 2025: RCB on Top of the Table',
          'description':
              'RCB leads the points table after a thrilling win over MI.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        },
        {
          'title': 'Virat Kohli Scores Another Fifty',
          'description': 'Kohli continues his form with another half-century.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        },
        {
          'title': 'Bumrah Takes 4 Wickets',
          'description': 'Jasprit Bumrah shines with the ball for MI.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        }
      ];
    }
    // LPL 2025
    else if (selectedTournament.value == 'LPL 2025') {
      topTeams.value = [
        {
          'rank': 1,
          'name': 'Jaffna Kings',
          'matches': 8,
          'won': 6,
          'lost': 2,
          'points': 12,
          'nrr': '+1.123',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 2,
          'name': 'Galle Gladiators',
          'matches': 8,
          'won': 5,
          'lost': 3,
          'points': 10,
          'nrr': '+0.876',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 3,
          'name': 'Colombo Stars',
          'matches': 8,
          'won': 4,
          'lost': 4,
          'points': 8,
          'nrr': '+0.321',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 4,
          'name': 'Kandy Warriors',
          'matches': 8,
          'won': 3,
          'lost': 5,
          'points': 6,
          'nrr': '-0.456',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 5,
          'name': 'Dambulla Giants',
          'matches': 8,
          'won': 2,
          'lost': 6,
          'points': 4,
          'nrr': '-1.234',
          'image_path': 'assets/batball.jpg',
        },
      ];
      upcomingMatches.value = [
        {
          'date': 'July 10, Thu',
          'match': 'Jaffna Kings vs Galle Gladiators, 29th Match',
          'venue': 'R. Premadasa Stadium, Colombo',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'July 11, Fri',
          'match': 'Colombo Stars vs Kandy Warriors, 30th Match',
          'venue': 'R. Premadasa Stadium, Colombo',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'July 13, Sun',
          'match': 'Qualifier 1',
          'venue': 'R. Premadasa Stadium, Colombo',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'July 14, Mon',
          'match': 'Eliminator',
          'venue': 'R. Premadasa Stadium, Colombo',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'July 16, Wed',
          'match': 'Final',
          'venue': 'R. Premadasa Stadium, Colombo',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
      ];
      topRunScorers.value = [
        {
          'rank': 1,
          'name': 'Avishka Fernando',
          'matches': 8,
          'innings': 8,
          'runs': 350,
          'average': 43.75,
          'strike_rate': 145.2,
          'fours': 38,
          'sixes': 12,
        },
        {
          'rank': 2,
          'name': 'Kusal Mendis',
          'matches': 8,
          'innings': 8,
          'runs': 330,
          'average': 41.25,
          'strike_rate': 138.7,
          'fours': 34,
          'sixes': 10,
        },
        {
          'rank': 3,
          'name': 'Bhanuka Rajapaksa',
          'matches': 8,
          'innings': 8,
          'runs': 310,
          'average': 38.75,
          'strike_rate': 132.5,
          'fours': 30,
          'sixes': 11,
        },
        {
          'rank': 4,
          'name': 'Dinesh Chandimal',
          'matches': 8,
          'innings': 8,
          'runs': 295,
          'average': 36.87,
          'strike_rate': 128.9,
          'fours': 28,
          'sixes': 9,
        },
        {
          'rank': 5,
          'name': 'Rahmanullah Gurbaz',
          'matches': 8,
          'innings': 8,
          'runs': 280,
          'average': 35.0,
          'strike_rate': 130.0,
          'fours': 25,
          'sixes': 8,
        },
      ];
      topWicketTakers.value = [
        {
          'rank': 1,
          'name': 'Wanindu Hasaranga',
          'matches': 8,
          'overs': 32.0,
          'balls': 192,
          'wickets': 18,
          'average': 13.5,
          'runs': 243,
          'four_fers': 1,
          'five_fers': '-',
        },
        {
          'rank': 2,
          'name': 'Nuwan Pradeep',
          'matches': 8,
          'overs': 31.0,
          'balls': 186,
          'wickets': 15,
          'average': 15.2,
          'runs': 228,
          'four_fers': 1,
          'five_fers': '-',
        },
        {
          'rank': 3,
          'name': 'Dushmantha Chameera',
          'matches': 8,
          'overs': 30.0,
          'balls': 180,
          'wickets': 13,
          'average': 17.0,
          'runs': 221,
          'four_fers': '-',
          'five_fers': '-',
        },
        {
          'rank': 4,
          'name': 'Akila Dananjaya',
          'matches': 8,
          'overs': 29.0,
          'balls': 174,
          'wickets': 12,
          'average': 18.5,
          'runs': 222,
          'four_fers': '-',
          'five_fers': '-',
        },
        {
          'rank': 5,
          'name': 'Suranga Lakmal',
          'matches': 8,
          'overs': 28.0,
          'balls': 168,
          'wickets': 11,
          'average': 20.0,
          'runs': 220,
          'four_fers': '-',
          'five_fers': '-',
        },
      ];
      news.value = [
        {
          'title': 'LPL 2025: Jaffna Kings Dominate',
          'description': 'Jaffna Kings secure a playoff spot with a big win.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        },
        {
          'title': 'Hasaranga Takes 5-fer',
          'description': 'Wanindu Hasaranga delivers a match-winning spell.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        },
        {
          'title': 'Avishka Fernando Hits Century',
          'description': 'Avishka Fernando scores a brilliant hundred.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        }
      ];
    }
    // BBL 2025
    else if (selectedTournament.value == 'BBL 2025') {
      topTeams.value = [
        {
          'rank': 1,
          'name': 'Sydney Sixers',
          'matches': 14,
          'won': 10,
          'lost': 4,
          'points': 20,
          'nrr': '+1.234',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 2,
          'name': 'Melbourne Stars',
          'matches': 14,
          'won': 9,
          'lost': 5,
          'points': 18,
          'nrr': '+0.876',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 3,
          'name': 'Adelaide Strikers',
          'matches': 14,
          'won': 8,
          'lost': 6,
          'points': 16,
          'nrr': '+0.321',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 4,
          'name': 'Brisbane Heat',
          'matches': 14,
          'won': 7,
          'lost': 7,
          'points': 14,
          'nrr': '-0.456',
          'image_path': 'assets/batball.jpg',
        },
        {
          'rank': 5,
          'name': 'Perth Scorchers',
          'matches': 14,
          'won': 6,
          'lost': 8,
          'points': 12,
          'nrr': '-1.234',
          'image_path': 'assets/batball.jpg',
        },
      ];
      upcomingMatches.value = [
        {
          'date': 'October 1, Sat',
          'match': 'Sydney Sixers vs Melbourne Stars, 1st Match',
          'venue': 'Sydney Cricket Ground, Sydney',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 2, Sun',
          'match': 'Adelaide Strikers vs Brisbane Heat, 2nd Match',
          'venue': 'Adelaide Oval, Adelaide',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 3, Mon',
          'match': 'Perth Scorchers vs Sydney Sixers, 3rd Match',
          'venue': 'Perth Stadium, Perth',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 4, Tue',
          'match': 'Melbourne Stars vs Adelaide Strikers, 4th Match',
          'venue': 'Melbourne Cricket Ground, Melbourne',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 5, Wed',
          'match': 'Brisbane Heat vs Perth Scorchers, 5th Match',
          'venue': 'Gabba, Brisbane',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 6, Thu',
          'match': 'Adelaide Strikers vs Melbourne Stars, 6th Match',
          'venue': 'Adelaide Oval, Adelaide',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 7, Fri',
          'match': 'Sydney Sixers vs Perth Scorchers, 7th Match',
          'venue': 'Sydney Cricket Ground, Sydney',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 8, Sat',
          'match': 'Brisbane Heat vs Adelaide Strikers, 8th Match',
          'venue': 'Gabba, Brisbane',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 9, Sun',
          'match': 'Sydney Sixers vs Melbourne Stars, 9th Match',
          'venue': 'Sydney Cricket Ground, Sydney',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 10, Mon',
          'match': 'Adelaide Strikers vs Brisbane Heat, 10th Match',
          'venue': 'Adelaide Oval, Adelaide',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 11, Tue',
          'match': 'Perth Scorchers vs Sydney Sixers, 11th Match',
          'venue': 'Perth Stadium, Perth',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 12, Wed',
          'match': 'Melbourne Stars vs Adelaide Strikers, 12th Match',
          'venue': 'Melbourne Cricket Ground, Melbourne',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 13, Thu',
          'match': 'Brisbane Heat vs Perth Scorchers, 13th Match',
          'venue': 'Gabba, Brisbane',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 14, Fri',
          'match': 'Sydney Sixers vs Melbourne Stars, 14th Match',
          'venue': 'Sydney Cricket Ground, Sydney',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 15, Sat',
          'match': 'Adelaide Strikers vs Brisbane Heat, 15th Match',
          'venue': 'Adelaide Oval, Adelaide',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 16, Sun',
          'match': 'Perth Scorchers vs Sydney Sixers, 16th Match',
          'venue': 'Perth Stadium, Perth',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 17, Mon',
          'match': 'Melbourne Stars vs Adelaide Strikers, 17th Match',
          'venue': 'Melbourne Cricket Ground, Melbourne',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 18, Tue',
          'match': 'Brisbane Heat vs Perth Scorchers, 18th Match',
          'venue': 'Gabba, Brisbane',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 19, Wed',
          'match': 'Sydney Sixers vs Melbourne Stars, 19th Match',
          'venue': 'Sydney Cricket Ground, Sydney',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 20, Thu',
          'match': 'Adelaide Strikers vs Brisbane Heat, 20th Match',
          'venue': 'Adelaide Oval, Adelaide',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 21, Fri',
          'match': 'Perth Scorchers vs Sydney Sixers, 21st Match',
          'venue': 'Perth Stadium, Perth',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
        {
          'date': 'October 22, Sat',
          'match': 'Melbourne Stars vs Adelaide Strikers, 22nd Match',
          'venue': 'Melbourne Cricket Ground, Melbourne',
          'time_local': '7:30 PM',
          'time_gmt': '02:00 PM GMT / 07:30 PM LOCAL',
        },
      ];
      topRunScorers.value = [
        {
          'rank': 1,
          'name': 'Avishka Fernando',
          'matches': 8,
          'innings': 8,
          'runs': 350,
          'average': 43.75,
          'strike_rate': 145.2,
          'fours': 38,
          'sixes': 12,
        },
        {
          'rank': 2,
          'name': 'Kusal Mendis',
          'matches': 8,
          'innings': 8,
          'runs': 330,
          'average': 41.25,
          'strike_rate': 138.7,
          'fours': 34,
          'sixes': 10,
        },
        {
          'rank': 3,
          'name': 'Bhanuka Rajapaksa',
          'matches': 8,
          'innings': 8,
          'runs': 310,
          'average': 38.75,
          'strike_rate': 132.5,
          'fours': 30,
          'sixes': 11,
        },
        {
          'rank': 4,
          'name': 'Dinesh Chandimal',
          'matches': 8,
          'innings': 8,
          'runs': 295,
          'average': 36.87,
          'strike_rate': 128.9,
          'fours': 28,
          'sixes': 9,
        },
        {
          'rank': 5,
          'name': 'Rahmanullah Gurbaz',
          'matches': 8,
          'innings': 8,
          'runs': 280,
          'average': 35.0,
          'strike_rate': 130.0,
          'fours': 25,
          'sixes': 8,
        },
      ];
      topWicketTakers.value = [
        {
          'rank': 1,
          'name': 'Wanindu Hasaranga',
          'matches': 8,
          'overs': 32.0,
          'balls': 192,
          'wickets': 18,
          'average': 13.5,
          'runs': 243,
          'four_fers': 1,
          'five_fers': '-',
        },
        {
          'rank': 2,
          'name': 'Nuwan Pradeep',
          'matches': 8,
          'overs': 31.0,
          'balls': 186,
          'wickets': 15,
          'average': 15.2,
          'runs': 228,
          'four_fers': 1,
          'five_fers': '-',
        },
        {
          'rank': 3,
          'name': 'Dushmantha Chameera',
          'matches': 8,
          'overs': 30.0,
          'balls': 180,
          'wickets': 13,
          'average': 17.0,
          'runs': 221,
          'four_fers': '-',
          'five_fers': '-',
        },
        {
          'rank': 4,
          'name': 'Akila Dananjaya',
          'matches': 8,
          'overs': 29.0,
          'balls': 174,
          'wickets': 12,
          'average': 18.5,
          'runs': 222,
          'four_fers': '-',
          'five_fers': '-',
        },
        {
          'rank': 5,
          'name': 'Suranga Lakmal',
          'matches': 8,
          'overs': 28.0,
          'balls': 168,
          'wickets': 11,
          'average': 20.0,
          'runs': 220,
          'four_fers': '-',
          'five_fers': '-',
        },
      ];
      news.value = [
        {
          'title': 'BBL 2025: Sixers Clinch Top Spot',
          'description': 'Sydney Sixers finish league stage at the top.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        },
        {
          'title': 'Sean Abbott Stars with the Ball',
          'description': 'Sean Abbott takes 4 wickets for the Sixers.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        },
        {
          'title': 'Maxwell Powers Stars to Win',
          'description': 'Glenn Maxwell smashes 80* in a run chase.',
          'imageUrl': 'assets/batball.jpg',
          'link': '#'
        }
      ];
    }
  }
}
