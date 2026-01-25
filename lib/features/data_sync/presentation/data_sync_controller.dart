import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'data_sync_state.dart';

final dataSyncControllerProvider =
    NotifierProvider<DataSyncController, DataSyncState>(DataSyncController.new);

class DataSyncController extends Notifier<DataSyncState> {
  @override
  DataSyncState build() {
    return DataSyncState.initial().copyWith(
      pendingItems: _mockPendingItems(),
      syncedItems: _mockSyncedItems(),
    );
  }

  // ---------------- UI ACTIONS ----------------

  void togglePendingSection() {
    state = state.copyWith(isPendingCollapsed: !state.isPendingCollapsed);
  }

  void toggleSyncedSection() {
    state = state.copyWith(isSyncedCollapsed: !state.isSyncedCollapsed);
  }

  void retryAllPending() {
    final updated = state.pendingItems
        .map((e) => e.copyWith(status: SyncItemStatus.syncing))
        .toList();

    state = state.copyWith(pendingItems: updated);
  }

  void retryItem(int index) {
    final list = [...state.pendingItems];
    list[index] = list[index].copyWith(status: SyncItemStatus.syncing);

    state = state.copyWith(pendingItems: list);
    Future.delayed(const Duration(seconds: 2), () {
      final updatedList = [...state.pendingItems];
      updatedList[index] = updatedList[index].copyWith(
        status: SyncItemStatus.pending,
      );
      state = state.copyWith(pendingItems: updatedList);
    });
  }

  // ---------------- MOCK DATA ----------------

  List<SyncItem> _mockPendingItems() => [
    SyncItem(
      icon: Icons.article,
      iconColor: AppColors.nextStep3Color,
      title: 'Survey Form #2208',
      subtitle: 'Created 12 mins ago',
      status: SyncItemStatus.pending,
    ),
    SyncItem(
      icon: Icons.description,
      iconColor: AppColors.syncedCountColor,
      title: 'Traffic/Trade #2209',
      subtitle: 'Edited 46 mins ago',
      status: SyncItemStatus.pending,
    ),
    SyncItem(
      icon: Icons.warning,
      iconColor: AppColors.emailUsIconColor,
      title: 'Survey Form #2210',
      subtitle: 'Name should be at least 3 characters',
      status: SyncItemStatus.failed,
    ),
  ];

  List<SyncItem> _mockSyncedItems() => [
    SyncItem(
      icon: Icons.article,
      iconColor: AppColors.nextStep3Color,
      title: 'Survey Form #2207',
      subtitle: 'Synced 12 mins ago',
      status: SyncItemStatus.success,
    ),
    SyncItem(
      icon: Icons.description,
      iconColor: AppColors.syncedCountColor,
      title: 'Traffic/Trade #2206',
      subtitle: 'Synced 09:15 AM',
      status: SyncItemStatus.success,
    ),
  ];
}
