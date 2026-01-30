import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/common/providers/last_sync_time_provider.dart';
import 'package:tgpl_network/common/providers/sync_status_provider.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/dashboard/data/module_provider.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_remote_data_source.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/priorities_provider.dart';
import 'package:tgpl_network/features/module_applications/presentation/module_applications_controller.dart';
import 'package:tgpl_network/features/application_form/data/app_form_dropdowns_local_data_source.dart';
import 'package:tgpl_network/features/application_form/data/app_form_dropdowns_remote_data_source.dart';
import 'package:tgpl_network/utils/internet_connectivity.dart';

final homeShellControllerProvider =
    AsyncNotifierProvider<HomeShellController, void>(() {
      return HomeShellController();
    });

final snackbarMessageProvider = StateProvider<String?>((ref) {
  return null;
});

class HomeShellController extends AsyncNotifier<void> {
  int autoSyncThresholdMinutes = 60 * 12; // 12 hours

  List<ProviderOrFamily> get providersToRefresh => [
    getLastSyncTimeProvider,
    dashboardAsyncControllerProvider,
    userProvider,
    modulesProvider,
    applicationControllerProvider,
    appStatusesProvider,
    cityNamesProvider,
    prioritiesProvider,
    // mapMarkersProvider // this is expensive, avoid refreshing unless necessary
    moduleApplicationsAsyncControllerProvider,
    applicationDetailAsyncControllerProvider,
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
      // Sync in background without blocking (if necessary)
      _syncInBackground();
      return;
    }

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
      if (status == InternetStatus.connected) {
        // Internet is back online
        await getMasterDataAndSaveLocally();
      } else {
        // Internet is offline
        ref.read(syncStatusProvider.notifier).state = SyncStatus.offline;
      }
    });
  }

  Future<void> _syncInBackground() async {
    try {
      await getMasterDataAndSaveLocally();
    } catch (e) {
      ref.read(snackbarMessageProvider.notifier).state =
          'Background sync failed: $e';
      state = AsyncValue.error(e, StackTrace.current);
      return;
    }
    state = const AsyncValue.data(null);
  }

  Future<void> _syncDataIfInternetAvailable() async {
    final hasInternet = await InternetConnectivity.hasInternet();

    // First time: require internet connection
    if (!hasInternet) {
      ref.read(snackbarMessageProvider.notifier).state =
          'Internet connection required for first-time setup.';
      int tryNumber = 0;
      while (!await InternetConnectivity.hasInternet()) {
        tryNumber++;
        ref.read(snackbarMessageProvider.notifier).state =
            'Waiting for internet connection... (Attempt $tryNumber)';
        await Future.delayed(const Duration(seconds: 5));
      }
    }
    try {
      state = const AsyncValue.loading();
      await getMasterDataAndSaveLocally();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      ref.read(snackbarMessageProvider.notifier).state =
          'Error during data sync: $e';
      state = AsyncValue.error(e, stackTrace);
      return;
    }
  }

  bool _isAutoSyncRunning = false;

  Future<void> getMasterDataAndSaveLocally({bool forcefulSync = false}) async {
    if (_isAutoSyncRunning) return;
    _isAutoSyncRunning = true;

    if (!await InternetConnectivity.hasInternet()) {
      ref.read(snackbarMessageProvider.notifier).state =
          'No internet connection. Please connect to the internet to sync data.';
      ref.read(syncStatusProvider.notifier).state = SyncStatus.offline;
      _isAutoSyncRunning = false;
      return;
    }

    if (!await shouldAutoSync(ref) && !forcefulSync) {
      ref.read(syncStatusProvider.notifier).state = SyncStatus.synchronized;
      _isAutoSyncRunning = false;
      return;
    }
    try {
      final username = ref.read(sharedPrefsDataSourceProvider).getUsername();

      if (username == null) {
        throw Exception('Username not found in shared preferences.');
      }

      ref.read(syncStatusProvider.notifier).state = SyncStatus.syncing;
      ref.read(snackbarMessageProvider.notifier).state =
          'Fetching latest data...';
      final masterData = await ref
          .read(masterDataRemoteDataSourceProvider)
          .getMasterDataFromApi(username: username);
      final dropdownValues = await ref
          .read(appFormDropdownsRemoteDataSourceProvider)
          .fetchAppFormDropdownValues();
      debugPrint('Fetched master data: $masterData');
      debugPrint('Fetched dropdown values: $dropdownValues');
      ref.read(snackbarMessageProvider.notifier).state =
          'Data fetched successfully. Saving locally...';
      await ref
          .read(appFormDropdownsLocalDataSourceProvider)
          .saveSiteStatuses(dropdownValues.siteStatuses);
      await ref
          .read(masterDataLocalDataSourceProvider)
          .saveMasterData(masterData);
      ref.read(syncStatusProvider.notifier).state = SyncStatus.synchronized;
      ref.read(snackbarMessageProvider.notifier).state =
          'Data synchronized successfully.';
      _refreshAllDependentProviders();
    } catch (e, stack) {
      ref.read(snackbarMessageProvider.notifier).state = 'Data sync failed: $e';
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

  FutureOr<bool> shouldAutoSync(Ref ref) async {
    String lastSyncTimeIso = await ref.read(getLastSyncTimeProvider.future);

    if (lastSyncTimeIso.isEmpty || lastSyncTimeIso == "Never") {
      return true; // Always sync if never synced before
    }

    try {
      final lastSync = DateTime.parse(lastSyncTimeIso);
      final now = DateTime.now();
      final difference = now.difference(lastSync);

      // Auto-sync if difference is greater than threshold
      return difference.inMinutes >= autoSyncThresholdMinutes;
    } catch (e) {
      return true; // Sync on error to be safe
    }
  }
}
