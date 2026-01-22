import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/data/master_data_remote_data_source.dart';
import 'package:tgpl_network/utils/has_internet_connection.dart';

final isOpenHomeFirstTimeProvider = StateProvider<bool>((ref) {
  return false;
});

final homeShellControllerProvider =
    AsyncNotifierProvider<HomeShellController, void>(() {
  return HomeShellController();
});

class HomeShellController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    await syncDataIfInternetAvailable();
  }

  Future<void> syncDataIfInternetAvailable() async {
    if (await InternetConnectivity.hasInternet()) {
      try {
        final sharedPrefsDataSource = ref.read(sharedPrefsDataSourceProvider);
        final username = sharedPrefsDataSource.getUsername();
        if (username == null) {
          throw Exception('Username not found in shared preferences.');
        }
        final masterData = await ref
            .read(masterDataRemoteDataSourceProvider)
            .getMasterDataFromApi(username: username);
        await ref
            .read(masterDataLocalDataSourceProvider)
            .saveMasterData(masterData);
        ref.read(isOpenHomeFirstTimeProvider.notifier).state = false;
      } catch (e, stackTrace) {
        state = AsyncValue.error(e, stackTrace);
        return;
      }
    }
    state = const AsyncValue.data(null);
  }
}
