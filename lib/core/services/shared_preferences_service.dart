import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  late SharedPreferences _prefs;
  bool _initialized = false;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  /// Initialize SharedPreferences
  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  /// Keys
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserRole = 'userRole';
  static const String _keyUserId = 'userId';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserName = 'userName';
  static const String _keyProfileImageUrl = 'profileImageUrl';

  /// Save login state
  Future<void> saveLoginState({
    required String userId,
    required String email,
    required String role,
    String? name,
    String? profileImageUrl,
  }) async {
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserId, userId);
    await _prefs.setString(_keyUserEmail, email);
    await _prefs.setString(_keyUserRole, role);
    if (name != null) {
      await _prefs.setString(_keyUserName, name);
    }
    if (profileImageUrl != null) {
      await _prefs.setString(_keyProfileImageUrl, profileImageUrl);
    }
  }

  /// Get login state
  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;

  /// Get user role ('user' or 'admin')
  String get userRole => _prefs.getString(_keyUserRole) ?? 'user';

  /// Get user ID
  String get userId => _prefs.getString(_keyUserId) ?? '';

  /// Get user email
  String get userEmail => _prefs.getString(_keyUserEmail) ?? '';

  /// Get user name
  String get userName => _prefs.getString(_keyUserName) ?? '';

  /// Get profile image URL
  String get profileImageUrl => _prefs.getString(_keyProfileImageUrl) ?? '';

  /// Check if user is admin
  bool get isAdmin => userRole == 'admin';

  /// Logout and clear data
  Future<void> clearLoginState() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyUserRole);
    await _prefs.remove(_keyUserName);
    await _prefs.remove(_keyProfileImageUrl);
  }
}


