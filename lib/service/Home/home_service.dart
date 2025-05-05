import 'dart:convert';
import 'dart:developer' as log;

import 'dart:math';

import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:http/http.dart' as http;

class HomeService {
  String? apiKey = "pub_83402f14a74b3fc1dde2341998eda24196ca2";
  List<String> queries = [
    "IPL", // Indian Premier League
    "Indian Cricket Team", // India National Team
    "BCCI", // Governing body (Board of Control for Cricket in India)
    "Virat Kohli", // Famous player (gets tons of news)
    "Rohit Sharma", // Current important player
    "MS Dhoni", // Legend, still popular
    "Indian Premier League 2025", // Specific IPL season
    "India vs Pakistan", // Big matches
    "Asia Cup", // Major tournament India plays
    "World Cup Cricket", // World Cups
    "T20 World Cup", // T20 tournaments
    "Indian domestic cricket", // Ranji Trophy, Syed Mushtaq Ali, etc.
    "Ranji Trophy", // Important domestic tournament
    "Women's Cricket India", // Indian women’s team
    "U19 Indian Cricket", // Under-19 matches
    "India cricket tour", // Useful when India tours other countries
  ];

  Future<List<Map<String, dynamic>>> getNews() async {
    try {
      final random = Random();
      final randomQuery = queries[random.nextInt(queries.length)];
      http.Response response = await http.get(
          Uri.parse(
              "https://newsdata.io/api/1/news?apikey=$apiKey&q=$randomQuery"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
        return List<Map<String, dynamic>>.from(decodedBody['results']);
      } else {
        log.log("Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log.log("Exception while Fetching News $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTopTeams() async {
    String? token = await AuthSharedP().getToken();
    try {
      http.Response response = await http
          .get(Uri.parse("http://localhost:8080/api/get-top-teams"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedBody is List) {
          return List<Map<String, dynamic>>.from(decodedBody.map((item) => {
                'id': item['id'] ?? 0,
                'name': item['name'] ?? 'Unknown',
                'image_path': item['logo'] ?? '',
                'ranking': item['ranking'] ?? 0,
                'type': item['type'] ?? 'Team',
              }));
        }
        return [];
      } else {
        log.log("Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log.log("Exception while Fetching Top Teams: $e");
      return [];
    }
  }
}
