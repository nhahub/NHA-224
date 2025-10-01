// import 'package:flutter/material.dart';

// class ThemeManager extends ChangeNotifier {
//   static const _themeKey = 'isDarkMode';

//   late ThemeMode _themeMode;

//   ThemeMode get themeMode => _themeMode;

//   ThemeManager() {
//     _loadThemeFromPrefs();
//   }

//   // تحميل الثيم المحفوظ من SharedPreferences
//   void _loadThemeFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isDark = prefs.getBool(_themeKey) ?? false;
//     _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }

//   // حفظ الثيم في SharedPreferences
//   Future<void> _saveThemeToPrefs(bool isDark) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_themeKey, isDark);
//   }

//   // تبديل بين الوضع الليلي والوضع العادي
//   void toggleTheme() {
//     if (_themeMode == ThemeMode.light) {
//       _themeMode = ThemeMode.dark;
//       _saveThemeToPrefs(true);
//     } else {
//       _themeMode = ThemeMode.light;
//       _saveThemeToPrefs(false);
//     }
//     notifyListeners();
//   }

//   // فرض الوضع الليلي أو العادي
//   void setTheme(ThemeMode mode) {
//     _themeMode = mode;
//     _saveThemeToPrefs(mode == ThemeMode.dark);
//     notifyListeners();
//   }
// }
