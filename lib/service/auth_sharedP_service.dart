// ignore: file_names
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedP {
  static String? token;
  static String? username;
  static bool? isLoggedIn;
  static bool? isAdmin = false;

  SharedPreferences? sharedPreferences;

  Future<void> setValues(String token, String username) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('token', token);
    sharedPreferences!.setString('username', username);
  }

  Future<void> setProfileData(Map<String, dynamic> data) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("profile", jsonEncode(data));
  }

  Future<Map<String, dynamic>> getProfileData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences!.getString("profile");
    return jsonDecode(data!);
  }

  Future<void> setAdminStatus(bool isAdmin) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool("isAdmin", isAdmin);
  }

  Future<String?> getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString('token');
    return token;
  }

  Future<bool?> getAdminStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isAdmin = sharedPreferences!.getBool("isAdmin");
    return isAdmin;
  }

  Future<String?> getUsername() async {
    sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences!.getString('username');
    return username;
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> isLogged() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLoggedIn = sharedPreferences!.getBool('isLoggedIn');
    return isLoggedIn!;
  }

  Future<void> clear() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.clear();
  }
}
