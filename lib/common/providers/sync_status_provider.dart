import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/common/data/sync_status_data_source.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_remote_data_source.dart';
import 'package:tgpl_network/utils/internet_connectivity.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tgpl_network/utils/should_auto_sync.dart';

final syncStatusProvider =
    NotifierProvider<SyncStatusController, SyncStatusState>(() {
      return SyncStatusController();
    });


class SyncStatusController extends Notifier<SyncStatus> {
  StreamSubscription<InternetStatus>? _connectivitySubscription;


  @override
  SyncStatusState build() {
    // Clean up subscription when provider is disposed
    ref.onDispose(() {
      _connectivitySubscription?.cancel();
    });

    // Initial sync status
    final lastSyncTime = await ref
        .read(syncStatusDataSourceProvider)
        .getLastSyncTime();
    bool hasInternet = await InternetConnectivity.hasInternet();
    SyncStatus status = hasInternet
        ? SyncStatus.synchronized
        : SyncStatus.offline;

    // Start listening to connectivity changes
    _listenToConnectivityChanges();

    return SyncStatusState(status: status, lastSyncTime: lastSyncTime);
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = InternetConnectivity.listen((
      InternetStatus status,
    ) {
      final currentState = state.value;
      if (currentState == null) return;

      if (status == InternetStatus.connected) {
        // Internet is back online
        state = AsyncValue.data(
          currentState.copyWith(status: SyncStatus.synchronized),
        );
        // Auto-sync only if enough time has passed
        _autoSyncOnReconnect();
      } else {
        // Internet is offline
        state = AsyncValue.data(
          currentState.copyWith(status: SyncStatus.offline),
        );
      }
    });
  }


  Future<void> _autoSyncOnReconnect() async {
    final currentState = state.value;
    if (currentState == null) return;

    // Check if enough time has passed since last sync
    if (!await shouldAutoSync(lastSyncTimeIso: currentState.lastSyncTime)) {
      return;
    }

    await resyncData();
  }

  Future<void> resyncData() async {
    final currentState = state.value;
    if (currentState == null) return;

    // Check internet before syncing
    if (!await InternetConnectivity.hasInternet()) {
      state = AsyncValue.data(
        currentState.copyWith(status: SyncStatus.offline),
      );
      throw Exception('No internet connection available');
    }

    state = AsyncValue.data(currentState.copyWith(status: SyncStatus.syncing));

    try {
      await getMasterDataAndSaveLocally();

      final lastSyncTime = await ref
          .read(syncStatusDataSourceProvider)
          .getLastSyncTime();

      state = AsyncValue.data(
        SyncStatusState(
          status: SyncStatus.synchronized,
          lastSyncTime: lastSyncTime,
        ),
      );
    } catch (e, stackTrace) {
      // Revert to previous state or offline on error
      state = AsyncValue.data(
        currentState.copyWith(status: SyncStatus.offline),
      );
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
