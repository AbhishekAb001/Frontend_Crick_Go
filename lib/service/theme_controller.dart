import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'isDarkMode';
  late SharedPreferences _prefs;
  final _isDarkMode = true.obs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = _prefs.getBool(_themeKey) ?? true;
  }

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    await _prefs.setBool(_themeKey, _isDarkMode.value);
    Get.changeTheme(_isDarkMode.value ? darkTheme : lightTheme);
  }

  ThemeData get currentTheme => _isDarkMode.value ? darkTheme : lightTheme;

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0A0A0A),
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.blue,
      secondary: Colors.purple,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF0A0A0A),
    ),
    cardColor: Colors.grey[900],
    dividerColor: Colors.grey[800],
    textTheme: const TextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return Colors.grey;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.withOpacity(0.5);
          }
          return Colors.grey.withOpacity(0.5);
        },
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.blue,
      secondary: Colors.purple,
    ),
    cardColor: Colors.white,
    dividerColor: Colors.grey[200],
    textTheme: const TextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return Colors.grey;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.withOpacity(0.5);
          }
          return Colors.grey.withOpacity(0.5);
        },
      ),
    ),
  );
}
