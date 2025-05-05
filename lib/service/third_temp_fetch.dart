import 'dart:developer';

import 'package:http/http.dart' as http;
import 'auth_sharedP_service.dart'; // Import your AuthSharedP service

class ThirdTempFetch {
  final AuthSharedP _authSharedP = AuthSharedP(); // Initialize AuthSharedP

  Future<void> fetchUsers() async {
    // Retrieve the stored JWT token
    String? token = await _authSharedP.getToken();
    String? username = await _authSharedP.getUsername();

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://localhost:8080/user/profile?username=$username'),
        headers: {
          'Authorization': 'Bearer $token', // Include the token here
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    } else {
      print('No token found');
    }
  }
}
