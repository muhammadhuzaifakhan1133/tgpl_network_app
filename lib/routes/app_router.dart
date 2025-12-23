import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tgpl_network/features/login/presentation/login_view.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_view.dart';
import 'package:tgpl_network/features/splash/presentation/splash_view.dart';
import 'package:tgpl_network/features/station_form/presentation/confirmation/station_form_confirmation_view.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_view.dart';
import 'package:tgpl_network/features/welcome/presentation/welcome_view.dart';
import 'package:tgpl_network/routes/app_routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeView(),
      ),
      GoRoute(
        path: AppRoutes.stationForm,
        builder: (context, state) => const StationFormView(),
      ),
      GoRoute(
        path: AppRoutes.stationFormConfirmation,
        builder: (context, state) => const StationFormConfirmationView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
});