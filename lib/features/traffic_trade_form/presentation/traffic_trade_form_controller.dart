import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/features/application_detail/data/application_detail_data_source.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
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

final trafficTradeFormStatusChangedProvider = StateProvider.autoDispose
    .family<bool, String>((ref, applicationId) {
      return false;
    });

class TrafficTradeFormController extends AsyncNotifier<TrafficTradeFormModel> {
  final String applicationId;

  TrafficTradeFormController(this.applicationId);

  @override
  Future<TrafficTradeFormModel> build() async {
    final application = await ref
        .read(applicationDetailDataSourceProvider)
        .getApplicationDetail(applicationId);

    // if ("$_alias.trafficTradeDone = 0 AND $_alias.statusId < 13")
    if (application.trafficTradeDone == 1 ||
        (application.statusId ?? 0) >= 13) {
      // Mark status as changed so UI can navigate back
      Future.microtask(() {
        ref
                .read(
                  trafficTradeFormStatusChangedProvider(applicationId).notifier,
                )
                .state =
            true;
      });
      throw Exception(
        'Application status has changed. Traffic Trade form is no longer available.',
      );
    }
    final trafficTradeForm = await ref
        .read(trafficTradeFormLocalDataSourceProvider)
        .getSingleTrafficTradeForm(applicationId);
    if (trafficTradeForm == null) {
      // Prefill all form controllers from application data

      TrafficTradeFormAssembler.dessembleFromApp(
        ref,
        application,
      ); // fill all form controllers
      return TrafficTradeFormAssembler.assemble(ref, applicationId);
    } else {
      // Refill form controllers with updated application data
      // (in case data changed but status is still valid)
      TrafficTradeFormAssembler.dessembleFromApp(ref, application);

      // Prefill all form controllers from saved traffic trade form
      TrafficTradeFormAssembler.dessembleFromTrafficTradeFormModel(
        ref,
        trafficTradeForm,
      );
      return trafficTradeForm;
    }
  }

  Future<bool> isStatusValid() async {
    try {
      final application = await ref
          .read(applicationDetailDataSourceProvider)
          .getApplicationDetail(applicationId);
      return (application.trafficTradeDone == 0) &&
          ((application.statusId ?? 0) < 13);
    } catch (e) {
      return false;
    }
  }

  Future<int> submitTrafficTradeForm() async {
    clearError();
    try {
      if (!await isStatusValid()) {
        state = AsyncValue.data(
          state.requireValue.copyWith(
            errorMessage: 'Application status has changed. Cannot submit form.',
          ),
        );
        ref
                .read(
                  trafficTradeFormStatusChangedProvider(applicationId).notifier,
                )
                .state =
            true;
        return 0;
      }
      // Gather all form data
      final trafficTradeFormData = TrafficTradeFormAssembler.assemble(
        ref,
        applicationId,
      );
      debugPrint(
        'Traffic Trade Form Data: ${trafficTradeFormData.toDatabaseMap()}',
      );
      final validateMessage = trafficTradeFormData.validate;
      if (validateMessage != null) {
        state = AsyncValue.data(
          state.requireValue.copyWith(errorMessage: validateMessage),
        );
        return 0;
      }
      state = AsyncValue.data(
        state.requireValue.copyWith(isSubmitting: true, errorMessage: null),
      );
        if (await InternetConnectivity.hasInternet()) {
          final user = ref.read(userProvider).value;
        final response = await ref
            .read(trafficTradeFormRemoteDataSourceProvider)
            .submitTrafficTradeForms(trafficTradeForms: [trafficTradeFormData], userPositionId: user?.positionId, userName: user?.userName);
        if (response.first.success) {
          return 1;
        } else {
          state = AsyncValue.data(
            state.requireValue.copyWith(
              errorMessage: 'Submission failed: ${response.first.message}',
              isSubmitting: false,
            ),
          );
          return 0;
        }
      } else {
        // Save locally if no internet
        await ref
            .read(trafficTradeFormLocalDataSourceProvider)
            .saveTrafficTradeForm(trafficTradeFormData);
        // ignore: unused_result
        ref.refresh(dataSyncControllerProvider);
      }
      return 2;
    } catch (e, _) {
      state = AsyncValue.data(
        state.requireValue.copyWith(
          isSubmitting: false,
          errorMessage: 'An error occurred: $e',
        ),
      );
      return 0;
    }
  }

  void clearError() {
    if (state.value?.errorMessage != null) {
      state = AsyncValue.data(
        state.requireValue.copyWith(errorMessage: null),
      );
    }
  }
}
