// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgpl_network/dialogs/refresh_token_login_dialog.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;
  final SharedPreferences _prefs;

  AuthInterceptor(this.ref, this._prefs);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains('/token')) {
      final token = _prefs.getString('auth_token');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('Request error: ${err.response?.statusCode} ${err.requestOptions.path}');
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/token')) {
      refreshTokenLoginDialog(ref);
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
