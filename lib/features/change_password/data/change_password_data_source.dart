import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/change_password/models/change_password_response_model.dart';

class ChangePasswordDataSource {
  final DioClient _dioClient;
  ChangePasswordDataSource(this._dioClient);

  Future<ChangePasswordResponseModel> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final data =  {
        'UserId': userId,
        'OldPassword': currentPassword,
        'NewPassword': newPassword,
        'ConfirmPassword': confirmPassword,
      };
    String body = "";
    for (var entry in data.entries) {
      body += '&${entry.key}=${Uri.encodeComponent(entry.value)}';
    }
    body = body.substring(1); // Remove the leading '&'
    final response = await _dioClient.post(
      AppApis.changePasswordEndpoint,
      data: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return ChangePasswordResponseModel.fromJson(response.data);
  }
}

final changePasswordDataSourceProvider = Provider<ChangePasswordDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return ChangePasswordDataSource(dioClient);
});