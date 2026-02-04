class AppApis {
  static const String baseUrl = "http://202.141.227.196:8086";
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const String loginEndpoint = "/token";
  static String masterDataEndpoint(String userName) =>
      "/api/DataForApp/GetMasterData/$userName";
  static const String appFormDropdownValuesEndpoint =
      "/api/DataForApp/newapplicationlists";
  // TODO: Update form endpoints with actual endpoints
  static const String submitSurveyFormEndpoint =
      "/api/SurveyForm/SubmitSurveyForm";
  static const String submitTrafficTradeFormEndpoint =
      "/api/TrafficTradeForm/SubmitTrafficTradeForm";
  static const String submitApplicationFormEndpoint =
      "/api/ApplicationForm/SubmitApplicationForm";
}
