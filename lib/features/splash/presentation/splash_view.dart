import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/pref_keys.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  bool _imagesPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_imagesPrecached) return;
    _imagesPrecached = true;

    Future.wait([
      precacheImage(const AssetImage(AppImages.onboarding1), context),
      precacheImage(const AssetImage(AppImages.onboarding2), context),
      precacheImage(const AssetImage(AppImages.onboarding3), context),
    ]).then((_) {
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          _handleStartup();
        }
      });
    });
  }

  Future<void> _handleStartup() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final goRouter = ref.read(goRouterProvider);
    final isOnboardingCompleted =
        prefs.getBool(SharedPrefsKeys.onboardingCompleted) ?? false;
    // await ref.read(sharedPrefsDataSourceProvider).clearAuthData(); // temp
    final isLoggedIn = ref.read(sharedPrefsDataSourceProvider).isLoggedIn();

    if (!isOnboardingCompleted) {
      goRouter.go(AppRoutes.onboarding);
    } else if (!isLoggedIn) {
      goRouter.go(AppRoutes.welcome);
    } else {
      goRouter.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.logoGif),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
