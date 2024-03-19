import 'package:flutter/material.dart';
import 'package:notes/models/note_database.dart';
import 'package:notes/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData = darkMode; 
  ThemeData get themedata => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  ThemeProvider() {
    initializeThemeMode();
  }

  set themeData(ThemeData themedata) {
    _themeData = themedata;
    notifyListeners();
  }

  void toggleTheme() async {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    // Update the theme mode in the database
    final noteDatabase = NoteDatabase();
    await noteDatabase.updateThemeMode(isDarkMode);
  }

  Future<void> initializeThemeMode() async {
    final noteDatabase = NoteDatabase();
    final isDarkMode = await noteDatabase.getThemeMode();
    themeData = isDarkMode ? darkMode : lightMode;
  }

}
