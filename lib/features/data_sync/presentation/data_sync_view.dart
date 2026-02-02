import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/common/providers/last_sync_time_provider.dart';
import 'package:tgpl_network/common/providers/sync_status_provider.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_state.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/connection_status_card.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/data_sync_shimmer_view.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_stats_card.dart';

class DataSyncView extends ConsumerWidget {
  const DataSyncView({super.key});

  Widget _buildContent(WidgetRef ref, DataSyncState data) {
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
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(dataSyncControllerProvider);
              },
              child: ListView(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final lastSyncTime = ref.watch(getLastSyncTimeProvider);
                      final isOnline =
                          ref.watch(syncStatusProvider) != SyncStatus.offline;
                      return lastSyncTime.when(
                        data: (time) => ConnectionStatusCard(
                          isOnline: isOnline,
                          lastSyncTime: time,
                        ),
                        loading: () => ConnectionStatusCard(
                          isOnline: isOnline,
                          lastSyncTime: 'Loading...',
                        ),
                        error: (error, stack) => ConnectionStatusCard(
                          isOnline: isOnline,
                          lastSyncTime: 'Error',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
              
                  Row(
                    children: [
                      Expanded(
                        child: SyncStatsCard(
                          icon: Icons.cloud_upload_outlined,
                          iconColor: AppColors.nextStep3Color,
                          backgroundColor: AppColors.nextStep3Color.withOpacity(
                            0.1,
                          ),
                          count: data.pendingItems.length.toString(),
                          label: 'Pending Upload',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SyncStatsCard(
                          icon: Icons.cloud_done,
                          iconColor: AppColors.syncedCountColor,
                          backgroundColor: AppColors.syncedCountColor.withOpacity(
                            0.1,
                          ),
                          count: data.syncedItems.length.toString(),
                          label: 'Synced Today',
                        ),
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 16),
              
                  Consumer(
                    builder: (context, ref, child) {
                      final isCollapsed = ref.watch(isPendingCollapsedProvider);
                      return SyncListWidget(
                        sectionTitle: 'Pending Sync',
                        items: data.pendingItems,
                        isCollapsed: isCollapsed,
                        onRetryAll: () {
                          ref
                              .read(dataSyncControllerProvider.notifier)
                              .retryPendingForms();
                        },
                        onRetryItem: (applicationId) {
                          ref
                              .read(dataSyncControllerProvider.notifier)
                              .retryPendingForms(applicationId: applicationId);
                        },
                        onToggle: () {
                          ref.read(isPendingCollapsedProvider.notifier).state =
                              !isCollapsed;
                        },
                      );
                    },
                  ),
              
                  const SizedBox(height: 16),
              
                  Consumer(
                    builder: (context, ref, child) {
                      final isCollapsed = ref.watch(isSyncedCollapsedProvider);
                      return SyncListWidget(
                        sectionTitle: 'Synced Successfully',
                        items: data.syncedItems,
                        isCollapsed: isCollapsed,
                        onToggle: () {
                          ref.read(isSyncedCollapsedProvider.notifier).state =
                              !isCollapsed;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dataSyncControllerProvider);
    return state.when(
      data: (dataSyncState) => _buildContent(ref, dataSyncState),
      loading: () => const DataSyncShimmerView(),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
