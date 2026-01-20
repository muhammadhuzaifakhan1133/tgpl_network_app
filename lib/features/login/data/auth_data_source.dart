// lib/features/login/data/datasources/auth_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import '../../../../core/network/dio_client.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthDataSource {
  final DioClient _dioClient;
  final SharedPrefsDataSource _sharedPrefsDataSource;

  AuthRemoteDataSourceImpl(this._dioClient, this._sharedPrefsDataSource);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _dioClient.post(
      AppApis.loginEndpoint,
      data: request.toJson(),
      options: Options(
        headers: {'Content-Type': Headers.formUrlEncodedContentType},
      ),
    );
    final loginResponse = LoginResponseModel.fromJson(response.data);
    _sharedPrefsDataSource.saveAuthToken(loginResponse.accessToken);
    return loginResponse;
  }
}

// Provider
final authRemoteDataSourceProvider = Provider<AuthDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final sharedPrefsDataSource = ref.watch(sharedPrefsDataSourceProvider);
  return AuthRemoteDataSourceImpl(dioClient, sharedPrefsDataSource);
});
