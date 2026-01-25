import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/connection_status_card.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_stats_card.dart';

class DataSyncView extends ConsumerWidget {
  const DataSyncView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dataSyncControllerProvider);
    final controller =
        ref.read(dataSyncControllerProvider.notifier);

    return Column(
      children: [
        const CustomAppBar(
          title: "Data Sync",
          subtitle: "Manage your offline data",
          showResyncButton: true,
        ),
        const SizedBox(height: 20),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                ConnectionStatusCard(
                  isOnline: state.isOnline,
                  lastSyncTime: state.lastSyncTime,
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: SyncStatsCard(
                        icon: Icons.cloud_upload_outlined,
                        iconColor: AppColors.nextStep3Color,
                        backgroundColor:
                            AppColors.nextStep3Color.withOpacity(0.1),
                        count: state.pendingItems.length.toString(),
                        label: 'Pending Upload',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SyncStatsCard(
                        icon: Icons.cloud_done,
                        iconColor: AppColors.syncedCountColor,
                        backgroundColor:
                            AppColors.syncedCountColor.withOpacity(0.1),
                        count: state.syncedItems.length.toString(),
                        label: 'Synced Today',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SyncListWidget(
                  sectionTitle: 'Pending Sync',
                  items: state.pendingItems,
                  isCollapsed: state.isPendingCollapsed,
                  onRetryAll: controller.retryAllPending,
                  onRetryItem: controller.retryItem,
                  onToggle: controller.togglePendingSection,
                ),

                const SizedBox(height: 16),

                SyncListWidget(
                  sectionTitle: 'Synced Successfully',
                  items: state.syncedItems,
                  isCollapsed: state.isSyncedCollapsed,
                  onToggle: controller.toggleSyncedSection,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
