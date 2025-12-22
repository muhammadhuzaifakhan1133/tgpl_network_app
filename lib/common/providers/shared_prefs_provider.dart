import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefsKeys {
  static const String onboardingCompleted = 'onboarding_completed';
}

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
