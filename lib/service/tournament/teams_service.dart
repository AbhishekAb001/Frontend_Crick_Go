import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/model/teams_model.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:http/http.dart' as http;

class TeamsService {
  Future<List<Map<String, dynamic>>> getMembers() async {
    String? token = await AuthSharedP().getToken();

    try {
      http.Response response = await http
          .get(Uri.parse("http://localhost:8080/user/getAll"), headers: {
        "Authorization": "Bearer $token",
        'content-type': 'application/json'
      });
      if (response.statusCode == 200) {
        log("Successfully getting members");
        final decodedResponse = json.decode(response.body);
        return List<Map<String, dynamic>>.from(decodedResponse);
      } else {
        log("Error while getting members ${response.statusCode}");
      }
    } catch (e) {
      log("Exception while getting members $e");
    }
    return [];
  }

  Future<Map<String, dynamic>> addTeam(Map<String, dynamic> team) async {
    String? token = await AuthSharedP().getToken();

    try {
      http.Response response = await http.post(
        Uri.parse("http://localhost:8080/tournament/team/add"),
        headers: {
          "Authorization": "Bearer $token",
          'content-type': 'application/json'
        },
        body: json.encode(team),
      );
      return json.decode(response.body);
    } catch (e) {
      log("Exception while adding team $e");
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getTeams(String tournamentId) async {
    String? token = await AuthSharedP().getToken();

    try {
      http.Response response = await http.get(
        Uri.parse(
            "http://localhost:8080/tournament/team/getAll?tournamentId=$tournamentId"),
        headers: {
          "Authorization": "Bearer $token",
          'content-type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        if (decodedResponse is List) {
          return decodedResponse
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
        }

        if (decodedResponse is Map) {
          final Map<String, dynamic> typedMap =
              Map<String, dynamic>.from(decodedResponse);
          return [typedMap];
        }

        log("Unexpected response type: ${decodedResponse.runtimeType}");
        return [];
      } else {
        log("Error while getting teams: Status ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      log("Exception while getting teams: $e");
      return [];
    }
  }
}
