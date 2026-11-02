import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/theme_preferences.dart';

part 'theme_viewmodel.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  @override
  Color build() {
    _loadColor();
    return ThemePreferences.defaultColor;
  }

  Future<void> _loadColor() async {
    final color = await ThemePreferences.getColor();
    state = color;
  }

  Future<void> setColor(Color color) async {
    state = color;
    await ThemePreferences.saveColor(color);
  }
}
