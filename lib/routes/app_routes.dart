class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String stationForm = '/station_form';
  static const String stationFormConfirmation = '/station_form_confirmation';
  static const String login = '/login';
  static const String dashboard = "/dashboard";
  static const String applications = "/applications";
  static const String map = "/map";
  static const String profile = "/profile";
  static const String changePassword = "/change_password";
  static String moduleApplications([String moduleId = ":module", String subModule = ":subModule"]) => "/module_applications/$moduleId/$subModule";
  static const String siteLocationSelection = "/site_location_selection";
  static String applicationDetail([String appId = ":appId"]) => "/application_detail/$appId";
  static String surveyForm([String appId = ":appId"]) => "/survey_form/$appId";
  static String trafficTradeForm([String appId = ":appId"]) => "/traffic_trade_form/$appId";
  static String syncData = "/sync_data";
}