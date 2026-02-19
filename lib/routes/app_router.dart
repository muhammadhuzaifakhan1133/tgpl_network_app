import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/features/change_password/presentation/change_password_view.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_view.dart';
import 'package:tgpl_network/features/application_detail/application_detail_view.dart';
import 'package:tgpl_network/features/applications_filter/appplications_filter_view.dart';
import 'package:tgpl_network/features/applications/presentation/applications_view.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_search/dashboard_search_view.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_view.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_view.dart';
import 'package:tgpl_network/features/login/presentation/login_view.dart';
import 'package:tgpl_network/features/map/presentation/map_view.dart';
import 'package:tgpl_network/features/module_applications/presentation/module_applications_view.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_view.dart';
import 'package:tgpl_network/features/profile/presentation/profile_view.dart';
import 'package:tgpl_network/features/splash/presentation/splash_view.dart';
import 'package:tgpl_network/features/application_form/presentation/confirmation/app_form_confirmation_view.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_view.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_view.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_view.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_view.dart';
import 'package:tgpl_network/features/welcome/presentation/welcome_view.dart';
import 'package:tgpl_network/routes/app_routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
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
        builder: (context, state) => SiteLocationSelectionView(
          initialPosition: state.extra != null ? state.extra as LatLng : null,
        ),
      ),
      GoRoute(
        path: AppRoutes.stationFormConfirmation(),
        builder: (context, state) {
          return AppFormConfirmationView(
            applicationId: state.pathParameters['applicationId'] ?? '',
          );
        },
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
                path: AppRoutes.syncData,
                builder: (context, state) => const DataSyncView(),
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
        path: AppRoutes.moduleApplications,
        builder: (context, state) =>
            ModuleApplicationsView(subModule: state.extra as SubModuleModel),
      ),
      GoRoute(
        path: AppRoutes.applicationDetail(),
        builder: (context, state) {
          return ApplicationDetailView(
            applicationId: state.pathParameters['appId'] ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.surveyForm(),
        builder: (context, state) {
          return SurveyFormView(appId: state.pathParameters['appId'] ?? '');
        },
      ),
      GoRoute(
        path: AppRoutes.trafficTradeForm(),
        builder: (context, state) {
          return TrafficTradeFormView(
            appId: state.pathParameters['appId'] ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.applicationsFilter,
        builder: (context, state) => const FilterScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboardSearch,
        builder: (context, state) => const DashboardSearchView(),
      ),
    ],
  );
});
