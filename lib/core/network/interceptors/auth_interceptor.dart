// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  AuthInterceptor(this._prefs);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get token from SharedPreferences
    final token = _prefs.getString('auth_token');
    
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token refresh or logout
      // Clear the token from SharedPreferences
      await _prefs.remove('auth_token');
      
      // You can implement token refresh logic here
      // Example:
      // final refreshToken = _prefs.getString('refresh_token');
      // if (refreshToken != null) {
      //   try {
      //     final newToken = await _refreshToken(refreshToken);
      //     await _prefs.setString('auth_token', newToken);
      //     // Retry the original request
      //     return handler.resolve(await _retry(err.requestOptions));
      //   } catch (e) {
      //     // Refresh failed, logout user
      //   }
      // }
    }
    super.onError(err, handler);
  }

  // Optional: Method to retry failed request after token refresh
  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return Dio().request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }
}