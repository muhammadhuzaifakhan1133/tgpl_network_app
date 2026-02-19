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
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
import 'package:tgpl_network/features/map/presentation/map_controller.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_remote_data_source.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/dealer_involvement_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/depo_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/nfr_facilities_provider.dart';
import 'package:tgpl_network/features/master_data/providers/priorities_provider.dart';
import 'package:tgpl_network/features/master_data/providers/tm_rm_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/trade_area_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/features/module_applications/presentation/module_applications_controller.dart';
import 'package:tgpl_network/features/application_form/data/app_form_dropdowns_local_data_source.dart';
import 'package:tgpl_network/features/application_form/data/app_form_dropdowns_remote_data_source.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';
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
    // Providers of master data
    userProvider,
    applicationControllerProvider,
    cityNamesProvider,
    dealerInvolvementNamesProvider,
    depoNamesProvider,
    nfrFacilitiesProvider,
    prioritiesProvider,
    tmNamesProvider,
    rmNamesProvider,
    tradeAreaNamesProvider,
    yesNoNaValuesProvider,
    yesNoValuesProvider,
    // Providers of Dashboard data source
    getLastSyncTimeProvider,
    dashboardAsyncControllerProvider,
    // Provider of Data Sync Screen
    dataSyncControllerProvider,
    // Provider for Map
    mapMarkersProvider,
    // Providers for Application Detail Screen
    applicationDetailAsyncControllerProvider,
    // Providers for Survey Form Screen
    surveyFormControllerProvider,
    surveyFormStatusChangedProvider,
    // Providers for Traffic Trade Form Screen
    trafficTradeFormControllerProvider,
    trafficTradeFormStatusChangedProvider,
    // Provider for application for specific module
    moduleApplicationsAsyncControllerProvider,
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

  /// 🔥 Even better: Check if there are actually pending forms before syncing
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

    // Check if master data sync is needed
    final shouldSyncMasterData = await shouldAutoSync(ref) || forcefulSync;

    try {

      // Sync pending forms first
      final isPendingFormsExist = await hasPendingForms();
      if (isPendingFormsExist || shouldSyncMasterData) {
        ref.read(syncStatusProvider.notifier).state = SyncStatus.syncing;
      }
      
      if (isPendingFormsExist) {
        await _syncPendingForms();
      }

      // Sync master data (only if needed)
      if (shouldSyncMasterData) {
        await _syncMasterData();
      } else {
        ref.read(snackbarMessageProvider.notifier).state = isPendingFormsExist
            ? 'Pending forms synced. Master data is up to date.'
            : 'All data is up to date.';
      }

      ref.read(syncStatusProvider.notifier).state = SyncStatus.synchronized;

      // Refresh providers
      refreshAllDependentProviders();
    } catch (e, _) {
      ref.read(snackbarMessageProvider.notifier).state = 'Data sync failed: $e';
      ref.read(syncStatusProvider.notifier).state = SyncStatus.error;
    } finally {
      _isAutoSyncRunning = false;
    }
  }

  Future<bool> hasPendingForms() async {
    try {
      final dataSync = await ref.read(dataSyncControllerProvider.future);
      final pendingItems = dataSync.pendingItems;
      return pendingItems.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking pending forms: $e');
      return false; // Assume no forms on error
    }
  }

  void refreshAllDependentProviders() {
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

  Future<void> _syncMasterData() async {
    final username = ref.read(sharedPrefsDataSourceProvider).getUsername();

    if (username == null) {
      throw Exception('Username not found in shared preferences.');
    }

    ref.read(snackbarMessageProvider.notifier).state =
        'Fetching latest master data...';

    final masterData = await ref
        .read(masterDataRemoteDataSourceProvider)
        .getMasterDataFromApi(username: username);

    final dropdownValues = await ref
        .read(appFormDropdownsRemoteDataSourceProvider)
        .fetchAppFormDropdownValues();

    ref.read(snackbarMessageProvider.notifier).state =
        'Data fetched successfully. Saving locally...';

    await ref
        .read(appFormDropdownsLocalDataSourceProvider)
        .saveSiteStatuses(dropdownValues.siteStatuses);

    await ref
        .read(masterDataLocalDataSourceProvider)
        .saveMasterData(masterData);

    ref.read(snackbarMessageProvider.notifier).state =
        'Data synchronized successfully.';
  }

  Future<void> _syncPendingForms() async {
    try {
      ref.read(snackbarMessageProvider.notifier).state =
          'Syncing pending forms...';

      final dataSyncController = ref.read(dataSyncControllerProvider.notifier);
      await dataSyncController.retryPendingForms();

      debugPrint('Pending forms synced successfully');
    } catch (e) {
      debugPrint('Error syncing pending forms: $e');
      // Don't throw - let master data sync continue
      ref.read(snackbarMessageProvider.notifier).state =
          'Warning: Some forms failed to sync. Will retry later.';
    }
  }
}
