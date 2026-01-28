import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_submission_response_model.dart';

class TrafficTradeFormRemoteDataSource {
  final DioClient _dioClient;
  TrafficTradeFormRemoteDataSource(this._dioClient);

  Future<TrafficTradeFormSubmissionResponseModel?> submitTrafficTradeForm(
    TrafficTradeFormModel trafficTradeForm,
  ) async {
    final response = await _dioClient.post(
      AppApis.submitTrafficTradeFormEndpoint,
      data: trafficTradeForm.toApiMap(),
    );
    if (response.statusCode == 200) {
      return TrafficTradeFormSubmissionResponseModel.fromJson(response.data);
    }
    return null;
  }
}

final trafficTradeFormRemoteDataSourceProvider = Provider<TrafficTradeFormRemoteDataSource>(
  (ref) {
    final dioClient = ref.watch(dioClientProvider);
    return TrafficTradeFormRemoteDataSource(dioClient);
  },
);
