import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'auth_sharedP_service.dart';

class CloudinaryService {
  final AuthSharedP _authSharedP = AuthSharedP();

  Future<String> uploadImage(Uint8List imageData) async {
    try {
      String? token = await _authSharedP.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }
      // Create multipart request
      var uri = Uri.parse('http://localhost:8080/media/uploadImg');
      var request = http.MultipartRequest('POST', uri);

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add the image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageData,
          filename: 'image.jpg',
        ),
      );

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        log("Upload successful");
        log(response.body);
        return jsonDecode(response.body)['url'];
      } else {
        log("Upload failed: ${response.statusCode}");
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      log("Upload failed: $e");
      throw Exception('Failed to upload image');
    }
  }


  Future<List<String>> uploadMultipleImages(List<Uint8List> imageDataList) async {
    try {
      String? token = await _authSharedP.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Create multipart request
      var uri = Uri.parse('http://localhost:8080/media/uploadMultiple');
      var request = http.MultipartRequest('POST', uri);

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add multiple image files
      for (var i = 0; i < imageDataList.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'images',
            imageDataList[i],
            filename: 'image_$i.jpg',
          ),
        );
      }

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        log("Upload successful");
        log(response.body);
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map<String>((item) => item['url'] as String).toList();
      } else {
        log("Upload failed: ${response.statusCode}");
        throw Exception('Failed to upload images');
      }
    } catch (e) {
      log("Upload failed: $e");
      throw Exception('Failed to upload images');
    }
  }

}
