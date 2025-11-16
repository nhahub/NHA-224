import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  static const String _themeModeKey = 'THEME_MODE';

  /// حفظ وضع الثيم في SharedPreferences
  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
  }

  /// استرجاع وضع الثيم المخزن
  Future<ThemeMode?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_themeModeKey);

    if (modeIndex == null) return null;

    // التحقق من القيم الصالحة
    if (modeIndex >= ThemeMode.values.length) return null;

    return ThemeMode.values[modeIndex];
  }
}
