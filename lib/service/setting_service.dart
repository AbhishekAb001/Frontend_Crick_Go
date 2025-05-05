import 'dart:convert';
import 'dart:developer';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:http/http.dart' as http;

class SettingService {
  Future<Map<String, dynamic>> updateUserProfile(
      Map<String, dynamic> userProfile) async {
    String? token = await AuthSharedP().getToken();

    try {
      http.Response response = await http.patch(
        Uri.parse('http://localhost:8080/user/patch'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(userProfile),
      );

      if (response.statusCode == 200) {
        log("Profile updated successfully");
        return json.decode(response.body);
      } else {
        log("Failed to update profile");
        log(response.body); 
      }
    } catch (e) {
      log("Exception while updating profile: $e");
    }
    return {};
  }
}
