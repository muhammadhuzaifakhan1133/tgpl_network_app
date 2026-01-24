import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/common/providers/last_sync_time_provider.dart';
import 'package:tgpl_network/common/providers/sync_status_provider.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_remote_data_source.dart';
import 'package:tgpl_network/utils/internet_connectivity.dart';
import 'package:tgpl_network/utils/should_auto_sync.dart';

final homeShellControllerProvider =
    AsyncNotifierProvider<HomeShellController, void>(() {
      return HomeShellController();
    });

class HomeShellController extends AsyncNotifier<void> {

  List<dynamic> get providersToRefresh => [
        getLastSyncTimeProvider,
        dashboardAsyncControllerProvider,
  ];
  StreamSubscription<InternetStatus>? _connectivitySubscription;

  @override
  Future<void> build() async {
    
    _listenToConnectivityChanges();

    ref.onDispose(() {
      _connectivitySubscription?.cancel();
    });

    final lastSyncTime = await ref.read(getLastSyncTimeProvider.future);

    final isFirstTime = lastSyncTime.isEmpty || lastSyncTime == "Never";

    // If not first time, return immediately with data state
    if (!isFirstTime) {
      state = const AsyncValue.data(null);
      // Sync in background without blocking
      debugPrint("HomeShellController: Not first-time, syncing in background...");
      _syncInBackground();
      return;
    }

    // First time: must complete sync before proceeding
    debugPrint("HomeShellController: First-time setup, starting sync...");
    await _syncDataIfInternetAvailable();
  }

  void _listenToConnectivityChanges() {
    bool isInitialCheck = true;
    _connectivitySubscription = InternetConnectivity.listen((
      InternetStatus status,
    ) async {
      if (isInitialCheck) {
        isInitialCheck = false;
        return;
      }
      if (status == InternetStatus.connected &&
          ref.read(syncStatusProvider) != SyncStatus.syncing) {
        // Internet is back online
        if (!await shouldAutoSync(ref)) {
          ref.read(syncStatusProvider.notifier).state = SyncStatus.synchronized;
          return;
        }
        // Auto-sync only if enough time has passed
        debugPrint(
          "HomeShellController: Internet reconnected, starting auto-sync...",
        );
        await getMasterDataAndSaveLocally();
      } else {
        // Internet is offline
        ref.read(syncStatusProvider.notifier).state = SyncStatus.offline;
      }
    });
  }

  Future<void> _syncInBackground() async {
    if (await InternetConnectivity.hasInternet() &&
        await shouldAutoSync(ref)) {
      try {
        await getMasterDataAndSaveLocally();
      } catch (e) {
        state = AsyncValue.error(e, StackTrace.current);
        return;
      }
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _syncDataIfInternetAvailable() async {
    final lastSyncTime = await ref.read(getLastSyncTimeProvider.future);
    final isFirstTime = lastSyncTime.isEmpty || lastSyncTime == "Never";
    final hasInternet = await InternetConnectivity.hasInternet();
    // First time: require internet connection
    if (isFirstTime && !hasInternet) {
      state = AsyncValue.error(
        Exception('Internet connection required for first-time setup.'),
        StackTrace.current,
      );
      return;
    }
    try {
      state = const AsyncValue.loading();
      await getMasterDataAndSaveLocally();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return;
    }
  }

  bool _isAutoSyncRunning = false;

  Future<void> getMasterDataAndSaveLocally() async {
    if (_isAutoSyncRunning) return;
    _isAutoSyncRunning = true;
    try {
      final username = ref.read(sharedPrefsDataSourceProvider).getUsername();

      if (username == null) {
        throw Exception('Username not found in shared preferences.');
      }
      ref.read(syncStatusProvider.notifier).state = SyncStatus.syncing;
      final masterData = await ref
          .read(masterDataRemoteDataSourceProvider)
          .getMasterDataFromApi(username: username);

      await ref
          .read(masterDataLocalDataSourceProvider)
          .saveMasterData(masterData);
      ref.read(syncStatusProvider.notifier).state = SyncStatus.synchronized;
      _refreshAllDependentProviders();
    } catch (e, stack) {
      Error.throwWithStackTrace(e, stack);
    } finally {
      _isAutoSyncRunning = false;
    }
  }

  void _refreshAllDependentProviders() {
    for (final provider in providersToRefresh) {
      ref.invalidate(provider);
    }
  }
}
