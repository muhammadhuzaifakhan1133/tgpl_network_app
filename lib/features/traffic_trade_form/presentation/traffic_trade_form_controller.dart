import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_detail/data/application_detail_data_source.dart';
import 'package:tgpl_network/features/traffic_trade_form/data/traffic_trade_form_local_data_source.dart';
import 'package:tgpl_network/features/traffic_trade_form/data/traffic_trade_form_remote_data_source.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_assembler.dart';
import 'package:tgpl_network/utils/internet_connectivity.dart';

final trafficTradeFormControllerProvider = AsyncNotifierProvider.family
    .autoDispose<TrafficTradeFormController, TrafficTradeFormModel, String>((
      applicationId,
    ) {
      return TrafficTradeFormController(applicationId);
    });

class TrafficTradeFormController extends AsyncNotifier<TrafficTradeFormModel> {
  final String applicationId;

  TrafficTradeFormController(this.applicationId);

  @override
  Future<TrafficTradeFormModel> build() async {
    final trafficTradeForm = await ref
        .read(trafficTradeFormLocalDataSourceProvider)
        .getSingleTrafficTradeForm(applicationId);
    if (trafficTradeForm == null) {
      // Prefill all form controllers from application data
      final application = await ref
          .read(applicationDetailDataSourceProvider)
          .getApplicationDetail(applicationId);
      TrafficTradeFormAssembler.dessembleFromApp(
        ref,
        application,
      ); // fill all form controllers
      return TrafficTradeFormAssembler.assemble(ref);
    } else {
      // Prefill all form controllers from saved traffic trade form
      TrafficTradeFormAssembler.dessembleFromTrafficTradeFormModel(
        ref,
        trafficTradeForm,
      );
      return trafficTradeForm;
    }
  }

  Future<bool> submitTrafficTradeForm() async {
    try {
      // Gather all form data
      final trafficTradeFormData = TrafficTradeFormAssembler.assemble(ref);
      debugPrint(
        'Traffic Trade Form Data: ${trafficTradeFormData.toDatabaseMap()}',
      );
      final validateMessage = trafficTradeFormData.validate;
      if (validateMessage != null) {
        state = AsyncValue.data(
          state.requireValue.copyWith(errorMessage: validateMessage),
        );
        return false;
      }
      state = AsyncValue.data(
        state.requireValue.copyWith(isSubmitting: true, errorMessage: null),
      );
      if (await InternetConnectivity.hasInternet()) {
        final response = await ref
            .read(trafficTradeFormRemoteDataSourceProvider)
            .submitTrafficTradeForm(trafficTradeFormData);
        if (response.success) {
          return true;
        } else {
          state = AsyncValue.data(
            state.requireValue.copyWith(
              errorMessage: 'Submission failed: ${response.message}',
              isSubmitting: false,
            ),
          );
          return false;
        }
      } else {
        // Save locally if no internet
        await ref
            .read(trafficTradeFormLocalDataSourceProvider)
            .saveTrafficTradeForm(trafficTradeFormData);
      }
      return true;
    } catch (e, _) {
      state = AsyncValue.data(
        state.requireValue.copyWith(
          isSubmitting: false,
          errorMessage: 'An error occurred: $e',
        ),
      );
      return false;
    }
  }
}
