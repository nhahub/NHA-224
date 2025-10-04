import 'package:shared_preferences/shared_preferences.dart';

class ThemeCacheHelper {
  // استخدام مفتاح ثابت لتخزين مؤشر الثيم
  static const String _themeIndexKey = "THEME_INDEX";

  /// تخزين مؤشر الثيم في SharedPreferences.
  Future<void> cacheThemeIndex(int themeIndex) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(_themeIndexKey, themeIndex);
  }
  
  /// استرجاع مؤشر الثيم المخزن، وإذا لم يكن موجودًا، يعيد القيمة الافتراضية 0.
  Future<int> getCachedThemeIndex() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    // استخدام المفتاح _themeIndexKey
    final cachedThemeIndex = sharedPreferences.getInt(_themeIndexKey);
    return cachedThemeIndex ?? 0;
  }
}
