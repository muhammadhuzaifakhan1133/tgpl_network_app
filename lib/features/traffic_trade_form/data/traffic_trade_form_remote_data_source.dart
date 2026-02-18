import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_submission_response_model.dart';

class TrafficTradeFormRemoteDataSource {
  final DioClient _dioClient;
  TrafficTradeFormRemoteDataSource(this._dioClient);

  Future<List<TrafficTradeFormSubmissionResponseModel>>
  submitTrafficTradeForms({
    required List<TrafficTradeFormModel> trafficTradeForms,
    required int? userPositionId,
    required String? userName,
  }) async {
    final data = trafficTradeForms.map((form) => form.toApiMap()).toList();
    for (var item in data) {
      item["userpositionId"] = userPositionId.toString();
      item["UserName"] = userName;
    }
    final response = await _dioClient.post(
      AppApis.submitTrafficTradeFormsEndpoint,
      data: data,
    );
    List<TrafficTradeFormSubmissionResponseModel> responses = [];
    for (var item in response.data) {
      responses.add(TrafficTradeFormSubmissionResponseModel.fromJson(item));
    }
    return responses;
  }
}

final trafficTradeFormRemoteDataSourceProvider =
    Provider<TrafficTradeFormRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return TrafficTradeFormRemoteDataSource(dioClient);
    });
