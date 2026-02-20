class AppApis {
  static const String baseUrl = "http://ecoservice.babarmoin.com:8087"; // Local Test Server
  // static const String baseUrl = "http://202.141.227.196:8086"; // Live Production Server
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const String loginEndpoint = "/token";
  static String masterDataEndpoint(String userName) =>
      "/api/DataForApp/GetMasterData/$userName";
  static const String appFormDropdownValuesEndpoint =
      "/api/DataForApp/newapplicationlists";
  static const String submitSurveyFormEndpoint =
      "/api/DataForApp/SaveAndPostSurvey";
  static const String submitTrafficTradeFormsEndpoint =
      "/api/DataForApp/SaveAndPostTrafficTrade";
  static const String submitApplicationFormsEndpoint =
      "/api/DataForApp/SaveNewApplication";
  static String getApplicationDetailEndpoint(String applicationId) =>
      "/api/DataForApp/SurveyById/$applicationId";
  static String getApplicationDocumentsEndpoint(String applicationId) =>
      "/api/DataForApp/SurveyAttachmentList/$applicationId";
  static const String uploadDocumentEndpoint =
      "/api/DataForApp/UploadActivityImage";
  static const String changePasswordEndpoint = "/api/DataForApp/ChangePassword";
}
