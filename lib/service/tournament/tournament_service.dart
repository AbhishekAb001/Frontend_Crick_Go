import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/model/tournament_add_model.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:http/http.dart' as http;

class TournamentService {
  Future<Map<String, dynamic>> createTournament(
      TournamentAddModel tournament) async {
    String? token = await AuthSharedP().getToken();
    log("token: $token");

    try {
      http.Response response = await http.post(
        Uri.parse('http://localhost:8080/tournament/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(tournament.toJson()),
      );
      if (response.statusCode == 200) {
        log("Tournament created successfully");
        log(response.body);
        return json.decode(response.body);
      } else {
        log("Failed to create tournament");
        log(response.body);
      }
    } catch (e) {
      log("Exception while creating tournament: $e");
    }

    return {}; // Return an empty model or handle error
  }

  Future<List<Map<String, dynamic>>> fetchTournaments() async {
    String? token = await AuthSharedP().getToken();

    try {
      http.Response response = await http.get(
        Uri.parse('http://localhost:8080/tournament/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        log("Fetched tournaments successfully");
        List<dynamic> jsonList = jsonDecode(response.body);
        log("tournaments: $jsonList");
        return List<Map<String, dynamic>>.from(
            jsonList.map((item) => Map<String, dynamic>.from(item)));
      } else {
        log("Failed to fetch tournaments");
        log(response.body);
      }
    } catch (e) {
      log("Exception while fetching tournaments: $e");
    }

    return []; // Return empty list in case of error
  }
}
