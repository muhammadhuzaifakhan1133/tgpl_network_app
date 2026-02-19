// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/interceptors/logging_interceptor.dart';
import 'interceptors/auth_interceptor.dart';
import 'network_exceptions.dart';

class DioClient {
  late final Dio _dio;
  final Ref ref;

  DioClient(
    this.ref, {
    Dio? dio,
    required String baseUrl,
    required SharedPreferences sharedPreferences,
  }) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(
        milliseconds: AppApis.connectionTimeout,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: AppApis.receiveTimeout,
      );
    _dio.options.headers = {'Accept': 'application/json'};

    // Add interceptors with SharedPreferences
    _dio.interceptors.addAll([
      AuthInterceptor(ref, sharedPreferences),
      LoggingInterceptor(),
    ]);
  }

  Dio get dio => _dio;

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling
  NetworkException _handleError(DioException error) {
    if (kDebugMode) {
      print('DIO ERROR TYPE: ${error.type}');
      print('DIO ERROR MESSAGE: ${error.message}');
      print('DIO ERROR RESPONSE: ${error.response}');
      print('DIO ERROR: $error');
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'Connection timeout',
          error.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 401:
            return UnauthorizedException('Unauthorized access');
          case 404:
            return NotFoundException('Resource not found');
          case 500:
            return ServerException('Internal server error');
          default:
            return NetworkException(
              error.response?.data['error_description'] ??
                  'Something went wrong',
              statusCode,
            );
        }

      case DioExceptionType.cancel:
        return NetworkException('Request cancelled');

      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return NetworkException('No internet connection');
        }
        return NetworkException('Unexpected error occurred');

      default:
        return NetworkException('Something went wrong');
    }
  }
}

// Updated Riverpod provider
final dioClientProvider = Provider<DioClient>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return DioClient(
    ref,
    baseUrl: AppApis.baseUrl,
    sharedPreferences: sharedPrefs,
  );
});
