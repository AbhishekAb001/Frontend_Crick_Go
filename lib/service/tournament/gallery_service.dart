import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  Future<bool> addImages(Map<String, dynamic> imageData) async {
    String? token = await AuthSharedP().getToken();
    try {
      http.Response response = await http.post(
        Uri.parse("http://localhost:8080/tournament/gallary/add"),
        headers: {
          "Authorization": "Bearer $token",
          'content-type': 'application/json'
        },
        body: jsonEncode(imageData),
      );

      if (response.statusCode == 200) {
        log("Images added successfully");
        return true;
      } else {
        log("Failed to add images");
        log(response.body);
        return false;
      }
    } catch (e) {
      log("Exception while adding images: $e");
      return false;
    }
  }

  Future<List<String>> fetchGalleryImages(String tournamentId) async {
    String? token = await AuthSharedP().getToken();
    try {
      http.Response response = await http.get(
        Uri.parse(
            "http://localhost:8080/tournament/gallary/all?tournamentId=$tournamentId"),
        headers: {
          "Authorization": "Bearer $token",
          'content-type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> photos = responseData['body']['photos'] ?? [];
        List<String> images = photos.cast<String>().toList();
        log("Gallery images fetched successfully $images");
        return images;
      } else {
        log("Failed to fetch gallery images");
        log(response.body);
        return [];
      }
    } catch (e) {
      log("Exception while fetching gallery images $e");
      return [];
    }
  }
}
