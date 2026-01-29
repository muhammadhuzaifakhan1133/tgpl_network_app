import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/application_form/models/app_form_dropdown_values_model.dart';

class AppFormDropdownsRemoteDataSource {
  final DioClient _dioClient;
  AppFormDropdownsRemoteDataSource(this._dioClient);

  Future<AppFormDropdownsValuesModel> fetchAppFormDropdownValues() async {
    final response = await _dioClient.get(
      AppApis.appFormDropdownValuesEndpoint,
    );
    return AppFormDropdownsValuesModel.fromAPIResponse(response.data);
  }
}

final appFormDropdownsRemoteDataSourceProvider =
    Provider.autoDispose<AppFormDropdownsRemoteDataSource>((ref) {
      final dioClient = ref.read(dioClientProvider);
      return AppFormDropdownsRemoteDataSource(dioClient);
    });
