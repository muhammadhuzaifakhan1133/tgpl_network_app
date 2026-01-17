import 'package:tgpl_network/features/data_sync/models/sync_item.dart';

class DataSyncState {
  final bool isOnline;
  final String lastSyncTime;

  final bool isPendingCollapsed;
  final bool isSyncedCollapsed;

  final List<SyncItem> pendingItems;
  final List<SyncItem> syncedItems;

  const DataSyncState({
    required this.isOnline,
    required this.lastSyncTime,
    required this.isPendingCollapsed,
    required this.isSyncedCollapsed,
    required this.pendingItems,
    required this.syncedItems,
  });

  factory DataSyncState.initial() {
    return DataSyncState(
      isOnline: true,
      lastSyncTime: '10 minutes ago',
      isPendingCollapsed: false,
      isSyncedCollapsed: false,
      pendingItems: const [],
      syncedItems: const [],
    );
  }

  DataSyncState copyWith({
    bool? isOnline,
    String? lastSyncTime,
    bool? isPendingCollapsed,
    bool? isSyncedCollapsed,
    List<SyncItem>? pendingItems,
    List<SyncItem>? syncedItems,
  }) {
    return DataSyncState(
      isOnline: isOnline ?? this.isOnline,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      isPendingCollapsed:
          isPendingCollapsed ?? this.isPendingCollapsed,
      isSyncedCollapsed:
          isSyncedCollapsed ?? this.isSyncedCollapsed,
      pendingItems: pendingItems ?? this.pendingItems,
      syncedItems: syncedItems ?? this.syncedItems,
    );
  }
}
