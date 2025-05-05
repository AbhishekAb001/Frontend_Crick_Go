import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:http/http.dart' as http;

class MatchesService {
  Future<List<Map<String, dynamic>>> generateSlots(String tournamentId) async {
    String? token = await AuthSharedP().getToken();
    try {
      http.Response response = await http.get(
          Uri.parse(
              "http://localhost:8080/matches/generate?tournamentId=$tournamentId"),
          headers: {
            "Authorization": "Bearer $token",
            'content-type': 'application/json'
          });

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        log("MatchesSLots: $decodedResponse");
        return List<Map<String, dynamic>>.from(decodedResponse);
      }
    } catch (e) {
      log("Exception while generating slots $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getMatches(String tournamentId) async {
    String? token = await AuthSharedP().getToken();
    try {
      http.Response response = await http.get(
          Uri.parse(
              "http://localhost:8080/matches/get?tournamentId=$tournamentId"),
          headers: {
            "Authorization": "Bearer $token",
            'content-type': 'application/json'
          });

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        log("Matches: $decodedResponse");
        return List<Map<String, dynamic>>.from(decodedResponse);
      } else {
        log("Error fetching matches: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception while fetching matches: $e");
    }
    return [];
  }
}
