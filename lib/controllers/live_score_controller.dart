import 'package:get/get.dart';

class LiveScoreController extends GetxController {
  // Observable lists for different match states
  final RxList<Map<String, dynamic>> liveMatches = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> upcomingMatches =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> completedMatches =
      <Map<String, dynamic>>[].obs;

  // Current match details
  final Rx<Map<String, dynamic>> currentMatch = Rx<Map<String, dynamic>>({});

  // Current batsmen and bowler
  final RxList<Map<String, dynamic>> currentBatsmen =
      <Map<String, dynamic>>[].obs;
  final Rx<Map<String, dynamic>> currentBowler = Rx<Map<String, dynamic>>({});

  // Last 6 balls
  final RxList<String> lastSixBalls = <String>[].obs;

  // Partnership details
  final Rx<Map<String, dynamic>> partnership =
      Rx<Map<String, dynamic>>({'runs': 0, 'balls': 0, 'runRate': 0.0});

  // Sample match data structure
  final Map<String, dynamic> _matchTemplate = {
    'id': '',
    'team1': '',
    'team2': '',
    'score1': '0',
    'score2': '0',
    'overs1': '0.0',
    'overs2': '0.0',
    'wickets1': 0,
    'wickets2': 0,
    'status': '',
    'venue': '',
    'date': '',
    'time': '',
    'currentInnings': 1, // 1 for team1, 2 for team2
    'battingTeam': '',
    'bowlingTeam': '',
  };

  @override
  void onInit() {
    super.onInit();
    _initializeSampleData();
  }

  void _initializeSampleData() {
    // Add sample live matches
    liveMatches.addAll([
      {
        'id': '1',
        'team1': 'India',
        'team2': 'Australia',
        'score1': '245',
        'score2': '189',
        'overs1': '45.2',
        'overs2': '35.0',
        'wickets1': 6,
        'wickets2': 4,
        'status': 'Live',
        'venue': 'MCG',
        'date': '2024-01-24',
        'time': '14:30',
        'currentInnings': 2,
        'battingTeam': 'Australia',
        'bowlingTeam': 'India',
      },
    ]);

    // Initialize current match details
    if (liveMatches.isNotEmpty) {
      currentMatch.value = liveMatches[0];
      _initializeMatchDetails(liveMatches[0]);
    }
  }

  void _initializeMatchDetails(Map<String, dynamic> match) {
    // Initialize current batsmen
    currentBatsmen.value = [
      {
        'name': 'Rohit Sharma',
        'runs': 22,
        'balls': 18,
        'fours': 2,
        'sixes': 1,
        'strikeRate': 122.22
      },
      {
        'name': 'Virat Kohli',
        'runs': 15,
        'balls': 12,
        'fours': 1,
        'sixes': 1,
        'strikeRate': 125.00
      }
    ];

    // Initialize current bowler
    currentBowler.value = {
      'name': 'Jasprit Bumrah',
      'overs': 2.3,
      'maidens': 0,
      'runs': 15,
      'wickets': 1,
      'economy': 6.00
    };

    // Initialize last 6 balls
    lastSixBalls.value = ['1', 'W', '0', '4', '2', '6'];

    // Initialize partnership
    partnership.value = {'runs': 5, 'balls': 0.2, 'runRate': 15.00};
  }

  // Create new match
  void createMatch(Map<String, dynamic> matchData) {
    final newMatch = Map<String, dynamic>.from(_matchTemplate);
    newMatch.addAll(matchData);
    newMatch['id'] = DateTime.now().millisecondsSinceEpoch.toString();

    if (matchData['status'] == 'Live') {
      liveMatches.add(newMatch);
    } else if (matchData['status'] == 'Upcoming') {
      upcomingMatches.add(newMatch);
    }
  }

  // Read match details
  Map<String, dynamic>? getMatchDetails(String matchId) {
    final match =
        liveMatches.firstWhereOrNull((match) => match['id'] == matchId);
    if (match != null) {
      currentMatch.value = match;
      _initializeMatchDetails(match);
      return match;
    }
    return null;
  }

  // Update match score
  void updateScore(
    String matchId, {
    String? score1,
    String? score2,
    String? overs1,
    String? overs2,
    int? wickets1,
    int? wickets2,
  }) {
    final matchIndex =
        liveMatches.indexWhere((match) => match['id'] == matchId);
    if (matchIndex != -1) {
      final match = Map<String, dynamic>.from(liveMatches[matchIndex]);

      if (score1 != null) match['score1'] = score1;
      if (score2 != null) match['score2'] = score2;
      if (overs1 != null) match['overs1'] = overs1;
      if (overs2 != null) match['overs2'] = overs2;
      if (wickets1 != null) match['wickets1'] = wickets1;
      if (wickets2 != null) match['wickets2'] = wickets2;

      liveMatches[matchIndex] = match;
      if (currentMatch.value['id'] == matchId) {
        currentMatch.value = match;
      }
    }
  }

  // Update current batsmen
  void updateBatsmen(List<Map<String, dynamic>> batsmen) {
    currentBatsmen.value = batsmen;
  }

  // Update current bowler
  void updateBowler(Map<String, dynamic> bowler) {
    currentBowler.value = bowler;
  }

  // Add ball to last 6 balls
  void addBall(String ball) {
    if (lastSixBalls.length >= 6) {
      lastSixBalls.removeAt(0);
    }
    lastSixBalls.add(ball);
  }

  // Update partnership
  void updatePartnership(Map<String, dynamic> partnershipData) {
    partnership.value = partnershipData;
  }

  // Complete match
  void completeMatch(String matchId) {
    final matchIndex =
        liveMatches.indexWhere((match) => match['id'] == matchId);
    if (matchIndex != -1) {
      final match = Map<String, dynamic>.from(liveMatches[matchIndex]);
      match['status'] = 'Completed';
      completedMatches.add(match);
      liveMatches.removeAt(matchIndex);

      if (currentMatch.value['id'] == matchId) {
        currentMatch.value = {};
        currentBatsmen.clear();
        currentBowler.value = {};
        lastSixBalls.clear();
        partnership.value = {'runs': 0, 'balls': 0, 'runRate': 0.0};
      }
    }
  }

  // Delete match
  void deleteMatch(String matchId) {
    liveMatches.removeWhere((match) => match['id'] == matchId);
    upcomingMatches.removeWhere((match) => match['id'] == matchId);
    completedMatches.removeWhere((match) => match['id'] == matchId);

    if (currentMatch.value['id'] == matchId) {
      currentMatch.value = {};
      currentBatsmen.clear();
      currentBowler.value = {};
      lastSixBalls.clear();
      partnership.value = {'runs': 0, 'balls': 0, 'runRate': 0.0};
    }
  }
}
