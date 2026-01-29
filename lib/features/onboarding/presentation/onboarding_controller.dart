import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/pref_keys.dart';
import 'package:tgpl_network/features/onboarding/models/onboarding_model.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

// Provider to check if onboarding is completed
final onboardingCompletedProvider = Provider<bool>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return prefs.getBool(SharedPrefsKeys.onboardingCompleted) ?? false;
});

// Provider for entry animation state
final onboardingEntryAnimationProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

// Provider for onboarding data
final onboardingDataProvider = Provider<List<OnboardingModel>>((ref) {
  return [
    const OnboardingModel(
      imagePath: AppImages.onboarding1,
      title: 'Welcome to TGPL Field App',
      description: 'Streamline your field operations with our comprehensive mobile solution',
      buttonText: 'Next',
    ),
    const OnboardingModel(
      imagePath: AppImages.onboarding2,
      title: 'Fill Site Screening Surveys On-Site',
      description: 'Complete surveys digitally with real-time data validation and sync',
      buttonText: 'Next',
    ),
    const OnboardingModel(
      imagePath: AppImages.onboarding3,
      title: 'Upload Photos, Location & Documents Easily',
      description: 'Complete surveys digitally with real-time data validation and sync',
      buttonText: 'Get Started',
    ),
  ];
});

// Main onboarding controller - manages only the current page index
final onboardingControllerProvider =
    NotifierProvider.autoDispose<OnboardingController, int>(
  OnboardingController.new,
);

class OnboardingController extends Notifier<int> {
  @override
  int build() {
    return 0; // Start at page 0
  }

  /// Get onboarding data
  List<OnboardingModel> get data => ref.read(onboardingDataProvider);

  /// Get total number of pages
  int get totalPages => data.length;

  /// Get current page data
  OnboardingModel get currentPageData => data[state];

  /// Set current page
  void setCurrentPage(int index) {
    if (index >= 0 && index < totalPages) {
      state = index;
    }
  }

  /// Navigate to next page
  void nextPage() {
    if (state < totalPages - 1) {
      state = state + 1;
    }
  }

  /// Navigate to previous page
  void previousPage() {
    if (state > 0) {
      state = state - 1;
    }
  }

  /// Jump to specific page
  void jumpToPage(int index) {
    setCurrentPage(index);
  }

  /// Check if current page is the last page
  bool get isLastPage => state == totalPages - 1;

  /// Complete onboarding and navigate to welcome screen
  void completeOnboarding() {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setBool(SharedPrefsKeys.onboardingCompleted, true);
    ref.read(goRouterProvider).go(AppRoutes.welcome);
  }

  /// Handle action button press (Next or Get Started)
  void onActionButtonPressed() {
    if (isLastPage) {
      completeOnboarding();
    } else {
      nextPage();
    }
  }

  /// Skip onboarding
  void skipOnboarding() {
    completeOnboarding();
  }
}