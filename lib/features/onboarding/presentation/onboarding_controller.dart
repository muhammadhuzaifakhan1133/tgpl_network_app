import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/features/onboarding/models/onboarding_model.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

final onboardingCompletedProvider = Provider<bool>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return prefs.getBool(SharedPrefsKeys.onboardingCompleted) ?? false;
});

final onboardingEntryAnimationProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final onboardingDataProvider = Provider<List<OnboardingModel>>((ref) {
  return [
    OnboardingModel(
      imagePath: AppImages.onboarding1,
      title: 'Welcome to TGPL Field App',
      description:
          'Streamline your field operations with our comprehensive mobile solution',
      buttonText: 'Next',
    ),
    OnboardingModel(
      imagePath: AppImages.onboarding2,
      title: 'Fill Site Screening Surveys On-Site',
      description:
          'Complete surveys digitally with real-time data validation and sync',
      buttonText: 'Next',
    ),
    OnboardingModel(
      imagePath: AppImages.onboarding3,
      title: 'Upload Photos, Location & Documents Easily',
      description:
          'Complete surveys digitally with real-time data validation and sync',
      buttonText: 'Get Started',
    ),
  ];
});

final onboardingControllerProvider =
    NotifierProvider.autoDispose<OnboardingController, OnboardingState>(() {
      return OnboardingController();
    });

class OnboardingState {
  final int currentPageIndex;

  OnboardingState({required this.currentPageIndex});

  OnboardingState copyWith({int? currentPageIndex}) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}

class OnboardingController extends Notifier<OnboardingState> {
  late PageController _pageController;

  @override
  OnboardingState build() {
    _pageController = PageController();

    ref.onDispose(() {
      _pageController.dispose();
    });

    return OnboardingState(currentPageIndex: 0);
  }

  void setCurrentPage(int index) {
    state = state.copyWith(currentPageIndex: index);
  }

  void jumpToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setCurrentPage(index);
  }

  List<OnboardingModel> get _data => ref.read(onboardingDataProvider);

  void completeOnboarding() {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setBool(SharedPrefsKeys.onboardingCompleted, true);
    ref.read(goRouterProvider).go(AppRoutes.welcome);
  }

  void onActionButtonPressed() {
    if (state.currentPageIndex < _data.length - 1) {
      jumpToPage(state.currentPageIndex + 1);
    } else {
      completeOnboarding();
    }
  }

  int get dataLength => _data.length;

  PageController get pageController => _pageController;

  OnboardingModel getData(int index) => _data[index];
}
