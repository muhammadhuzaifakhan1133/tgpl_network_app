// lib/core/constants/shared_prefs_keys.dart (or update your existing file)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String onboardingCompleted = 'onboarding_completed';
  static const String authToken = 'auth_token';
  static const String isLoggedIn = 'is_logged_in';
  static const String username = 'username';
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});