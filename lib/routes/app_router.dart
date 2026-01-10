import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tgpl_network/common/presentation/home_shell_view.dart';
import 'package:tgpl_network/features/application_detail/application_detail_view.dart';
import 'package:tgpl_network/features/applications/presentation/applications_view.dart';
import 'package:tgpl_network/features/change_password/change_password_view.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_view.dart';
import 'package:tgpl_network/features/login/presentation/login_view.dart';
import 'package:tgpl_network/features/map/presentation/map_view.dart';
import 'package:tgpl_network/features/module_applications/module_applications_view.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_view.dart';
import 'package:tgpl_network/features/profile/presentation/profile_view.dart';
import 'package:tgpl_network/features/splash/presentation/splash_view.dart';
import 'package:tgpl_network/features/station_form/presentation/confirmation/station_form_confirmation_view.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step3/site_location_selection/site_location_selection_view.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_view.dart';
import 'package:tgpl_network/features/survey_form/survey_form_view.dart';
import 'package:tgpl_network/features/welcome/presentation/welcome_view.dart';
import 'package:tgpl_network/routes/app_routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
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
        path: AppRoutes.siteLocationSelection,
        builder: (context, state) => const SiteLocationSelectionView(),
      ),
      GoRoute(
        path: AppRoutes.stationFormConfirmation,
        builder: (context, state) => const StationFormConfirmationView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeShellView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                builder: (context, state) => DashboardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.applications,
                builder: (context, state) => ApplicationsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.map,
                builder: (context, state) => MapView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => ProfileView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => ChangePasswordView(),
      ),
      GoRoute(
        path: AppRoutes.moduleApplications(),
        builder: (context, state) => ModuleApplicationsView(
          module: state.pathParameters['module'] ?? '',
          subModule: state.pathParameters['subModule'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.applicationDetail(),
        builder: (context, state) {
          return ApplicationDetailView(
            appId: state.pathParameters['appId'] ?? '',
            statusId: state.extra as int? ?? 0,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.surveyForm(),
        builder: (context, state) {
          return SurveyFormView(
            appId: state.pathParameters['appId'] ?? '',
          );
        },
      ),
    ],
  );
});
