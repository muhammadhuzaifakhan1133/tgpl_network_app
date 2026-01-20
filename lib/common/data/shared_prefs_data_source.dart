// lib/features/login/data/datasources/auth_local_data_source.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';

abstract class SharedPrefsDataSource {
  Future<void> saveAuthToken(String token);
  String? getAuthToken();
  Future<void> clearAuthData();
  bool isLoggedIn();
}

class SharedPrefsDataSourceImpl implements SharedPrefsDataSource {
  final SharedPreferences _prefs;

  SharedPrefsDataSourceImpl(this._prefs);

  @override
  Future<void> saveAuthToken(String token) async {
    await _prefs.setString(SharedPrefsKeys.authToken, token);
    await _prefs.setBool(SharedPrefsKeys.isLoggedIn, true);
  }

  // @override
  // Future<void> saveRefreshToken(String token) async {
  //   await _prefs.setString(SharedPrefsKeys.refreshToken, token);
  // }

  // @override
  // Future<void> saveUserId(String userId) async {
  //   await _prefs.setString(SharedPrefsKeys.userId, userId);
  // }

  @override
  String? getAuthToken() {
    return _prefs.getString(SharedPrefsKeys.authToken);
  }

  @override
  Future<void> clearAuthData() async {
    await _prefs.remove(SharedPrefsKeys.authToken);
    // await _prefs.remove(SharedPrefsKeys.refreshToken);
    // await _prefs.remove(SharedPrefsKeys.userId);
    await _prefs.setBool(SharedPrefsKeys.isLoggedIn, false);
  }

  @override
  bool isLoggedIn() {
    return _prefs.getBool(SharedPrefsKeys.isLoggedIn) ?? false;
  }
}

// Provider
final sharedPrefsDataSourceProvider = Provider<SharedPrefsDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPrefsDataSourceImpl(prefs);
});