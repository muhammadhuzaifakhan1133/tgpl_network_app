import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_submission_response_model.dart';

class TrafficTradeFormRemoteDataSource {
  final DioClient _dioClient;
  TrafficTradeFormRemoteDataSource(this._dioClient);

  Future<TrafficTradeFormSubmissionResponseModel> submitTrafficTradeForm(
    TrafficTradeFormModel trafficTradeForm,
  ) async {
    // Simulate network call with a delay
    await Future.delayed(const Duration(seconds: 3));
    return TrafficTradeFormSubmissionResponseModel(
      success: true,
      message: 'Traffic Trade Form submitted successfully',
    );
    // final response = await _dioClient.post(
    //   AppApis.submitTrafficTradeFormEndpoint,
    //   data: trafficTradeForm.toApiMap(),
    // );
    // return TrafficTradeFormSubmissionResponseModel.fromJson(response.data);
  }
}

final trafficTradeFormRemoteDataSourceProvider =
    Provider<TrafficTradeFormRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return TrafficTradeFormRemoteDataSource(dioClient);
    });
