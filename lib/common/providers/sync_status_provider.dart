import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';

final syncStatusProvider = AsyncNotifierProvider<SyncStatusAsyncController, SyncStatus>(() {
  return SyncStatusAsyncController();
});

class SyncStatusAsyncController extends AsyncNotifier<SyncStatus> {
  @override
  SyncStatus build() {
    // Initial sync status can be set here
    return SyncStatus.offline;
  }

  void resyncData() {
    state = AsyncValue.data(SyncStatus.syncing);
    // Simulate sync process
    Future.delayed(const Duration(seconds: 3), () {
      state = AsyncValue.data(SyncStatus.synchronized);
    });
  }
}