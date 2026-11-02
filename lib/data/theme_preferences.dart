import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _keyColor = 'appbar_color';

  static const Color defaultColor = Color(0xFF2E3842);

  static const List<Color> colors = [
    Color(0xFF2196F3),
    Color(0xFF4CAF50),
    Color(0xFF9C27B0),
    Color(0xFF3F51B5),
    Color(0xFF009688),
    Color(0xFF673AB7),
    Color(0xFF2E3842),
    Color(0xFF607D8B),
  ];

  static Future<void> saveColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyColor, color.toARGB32());
  }

  static Future<Color> getColor() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_keyColor);
    if (value != null) {
      return Color(value);
    }
    return defaultColor;
  }
}
