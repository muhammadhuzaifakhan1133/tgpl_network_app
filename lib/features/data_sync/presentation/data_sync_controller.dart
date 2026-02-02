import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/features/data_sync/data/data_sync_data_source.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'package:tgpl_network/features/survey_form/data/survey_form_local_data_source.dart';
import 'package:tgpl_network/features/survey_form/data/survey_form_remote_data_source.dart';
import 'package:tgpl_network/features/traffic_trade_form/data/traffic_trade_form_local_data_source.dart';
import 'package:tgpl_network/features/traffic_trade_form/data/traffic_trade_form_remote_data_source.dart';
import 'data_sync_state.dart';

final dataSyncControllerProvider =
    AsyncNotifierProvider<DataSyncController, DataSyncState>(
      DataSyncController.new,
    );

final isPendingCollapsedProvider = StateProvider<bool>((ref) => false);

final isSyncedCollapsedProvider = StateProvider<bool>((ref) => true);

class DataSyncController extends AsyncNotifier<DataSyncState> {
  @override
  FutureOr<DataSyncState> build() async {
    await ref.read(dataSyncDataSourceProvider).retainLastMonthSyncedData();
    return DataSyncState(
      pendingItems: await _getPendingForms(),
      syncedItems: await _getSyncedForms(),
    );
  }

  Future<List<SyncItem>> _getPendingForms() async {
    final dataSource = ref.read(dataSyncDataSourceProvider);
    return dataSource.getPendingSyncItems();
  }

  Future<List<SyncItem>> _getSyncedForms() async {
    final dataSource = ref.read(dataSyncDataSourceProvider);
    return dataSource.getSyncedSyncItems();
  }

  Future<void> retryPendingForms({String? applicationId}) async {
    final updatedItems = state.requireValue.pendingItems.map((item) {
      if (applicationId == null) {
        return item.copyWith(status: SyncItemStatus.syncing);
      } else if (item.id == applicationId) {
        return item.copyWith(status: SyncItemStatus.syncing);
      }
      return item;
    }).toList();

    state = AsyncValue.data(
      state.requireValue.copyWith(pendingItems: updatedItems),
    );

    final surveyRemoteDataSource = ref.read(surveyFormRemoteDataSourceProvider);
    final surveyLocalDataSource = ref.read(surveyFormLocalDataSourceProvider);
    final trafficTradeRemoteDataSource = ref.read(
      trafficTradeFormRemoteDataSourceProvider,
    );
    final trafficTradeLocalDataSource = ref.read(
      trafficTradeFormLocalDataSourceProvider,
    );

    for (var item in updatedItems) {
      if (item.status != SyncItemStatus.syncing) continue;
      try {
        if (item.surveyForm != null) {
          final response = await surveyRemoteDataSource.submitSurveyForm(
            item.surveyForm!,
          );
          if (response.success) {
            await surveyLocalDataSource.markSurveyFormAsSynced(item.id);
          } else {
            await surveyLocalDataSource.updateSurveyFormErrorMessage(
              item.id,
              response.message,
            );
          }
        } else if (item.trafficTradeForm != null) {
          final response = await trafficTradeRemoteDataSource
              .submitTrafficTradeForm(item.trafficTradeForm!);
          if (response.success) {
            await trafficTradeLocalDataSource.markTrafficTradeFormAsSynced(
              item.id,
            );
          } else {
            await trafficTradeLocalDataSource
                .updateTrafficTradeFormErrorMessage(item.id, response.message);
          }
        }
      } catch (e) {
        if (item.surveyForm != null) {
          await surveyLocalDataSource.updateSurveyFormErrorMessage(
            item.id,
            e.toString(),
          );
        } else if (item.trafficTradeForm != null) {
          await trafficTradeLocalDataSource.updateTrafficTradeFormErrorMessage(
            item.id,
            e.toString(),
          );
        }
      }
    }
    ref.invalidateSelf();
  }
}
