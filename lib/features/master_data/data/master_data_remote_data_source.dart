import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/master_data/models/master_data_response_model.dart';

abstract class MasterDataRemoteDataSource {
  Future<MasterDataResponseModel> getMasterDataFromApi({required String username});
}

class MasterDataRemoteDataSourceImpl implements MasterDataRemoteDataSource {
  final DioClient _dioClient;

  MasterDataRemoteDataSourceImpl(this._dioClient);

  @override
  Future<MasterDataResponseModel> getMasterDataFromApi({required String username}) async {
    final response = await _dioClient.get(AppApis.masterDataEndpoint(username));
    return MasterDataResponseModel.fromAPIResponseMap(response.data);
  }
}

// Provider
final masterDataRemoteDataSourceProvider = Provider<MasterDataRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MasterDataRemoteDataSourceImpl(dioClient);
});