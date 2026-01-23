import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/common/providers/sync_status_provider.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_remote_data_source.dart';
import 'package:tgpl_network/utils/internet_connectivity.dart';
import 'package:tgpl_network/utils/should_auto_sync.dart';

final isOpenHomeFirstTimeProvider = StateProvider<bool>((ref) {
  return false;
});

final homeShellControllerProvider =
    AsyncNotifierProvider<HomeShellController, void>(() {
      return HomeShellController();
    });

class HomeShellController extends AsyncNotifier<void> {
  StreamSubscription<InternetStatus>? _connectivitySubscription;
  
  @override
  Future<void> build() async {
    _listenToConnectivityChanges();

    ref.onDispose(() {
      _connectivitySubscription?.cancel();
    });

    final isFirstTime = ref.read(isOpenHomeFirstTimeProvider);
    print("HomeShellController build called. isFirstTime: $isFirstTime");
    // If not first time, return immediately with data state
    if (!isFirstTime) {
      print("Not first time opening home, sync will be in background.");
      state = const AsyncValue.data(null);
      // Sync in background without blocking
      _syncInBackground();
      return;
    }

    // First time: must complete sync before proceeding
    await syncDataIfInternetAvailable();
  }

   void _listenToConnectivityChanges() {
    _connectivitySubscription = InternetConnectivity.listen((
      InternetStatus status,
    ) {
      if (status == InternetStatus.connected && ref.read(syncStatusProvider).status != SyncStatus.syncing) {
        // Internet is back online
        if (!await shouldAutoSync(lastSyncTimeIso: currentState.lastSyncTime)) {
      return;
    }
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

  Future<void> _syncInBackground() async {
    if (await InternetConnectivity.hasInternet() &&
        await shouldAutoSync(ref: ref)) {
      try {
        await getMasterDataAndSaveLocally();
      } catch (e) {
        state = AsyncValue.error(e, StackTrace.current);
        return;
      }
      state = const AsyncValue.data(null);
    }
  }

  Future<void> syncDataIfInternetAvailable() async {
    final isFirstTime = ref.read(isOpenHomeFirstTimeProvider);
    final hasInternet = await InternetConnectivity.hasInternet();
    print(
      "SyncDataIfInternetAvailable called. isFirstTime: $isFirstTime, hasInternet: $hasInternet",
    );
    // First time: require internet connection
    if (isFirstTime && !hasInternet) {
      state = AsyncValue.error(
        Exception('Internet connection required for first-time setup.'),
        StackTrace.current,
      );
      return;
    }

    print("Starting data sync...");
    // Only sync if internet is available
    if (hasInternet) {
      try {
        state = const AsyncValue.loading();
        await getMasterDataAndSaveLocally();

        // Mark first-time as complete after successful sync
        if (isFirstTime) {
          ref.read(isOpenHomeFirstTimeProvider.notifier).state = false;
        }
      } catch (e, stackTrace) {
        state = AsyncValue.error(e, stackTrace);
        return;
      }
    }
    print("Data sync completed.");
    state = const AsyncValue.data(null);
  }

  Future<void> getMasterDataAndSaveLocally() async {
    try {
      final username = ref.read(sharedPrefsDataSourceProvider).getUsername();

      if (username == null) {
        throw Exception('Username not found in shared preferences.');
      }

      final masterData = await ref
          .read(masterDataRemoteDataSourceProvider)
          .getMasterDataFromApi(username: username);

      await ref
          .read(masterDataLocalDataSourceProvider)
          .saveMasterData(masterData);
    } catch (e) {
      throw Exception('Error fetching or saving master data: $e');
    }
  }
}
