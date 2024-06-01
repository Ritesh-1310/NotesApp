import 'package:flutter/material.dart';

// Enum to represent different theme types
enum ThemeType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light(); // Default theme is set to light

  // Getter to retrieve the current theme
  ThemeData getTheme() => _themeData;

  // Function to set the theme based on the provided theme type
  void setTheme(ThemeType themeType) {
    _themeData = themeType == ThemeType.light ? ThemeData.light() : ThemeData.dark();
    notifyListeners(); // Notify listeners about the theme change
  }

  // Function to toggle between light and dark themes
  void toggleTheme() {
    _themeData = _themeData == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    notifyListeners(); // Notify listeners about the theme change
  }
}
