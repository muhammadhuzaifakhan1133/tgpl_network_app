import 'package:tgpl_network/features/data_sync/models/sync_item.dart';

class DataSyncState {

  final List<SyncItem> pendingItems;
  final List<SyncItem> syncedItems;

  const DataSyncState({
    required this.pendingItems,
    required this.syncedItems,
  });

  DataSyncState copyWith({
    bool? isPendingCollapsed,
    bool? isSyncedCollapsed,
    List<SyncItem>? pendingItems,
    List<SyncItem>? syncedItems,
  }) {
    return DataSyncState(
      pendingItems: pendingItems ?? this.pendingItems,
      syncedItems: syncedItems ?? this.syncedItems,
    );
  }
}
