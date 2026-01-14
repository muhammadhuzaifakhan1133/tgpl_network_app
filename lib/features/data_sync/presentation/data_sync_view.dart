import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/connection_status_card.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_stats_card.dart';

class DataSyncView extends StatelessWidget {
  const DataSyncView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
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
                  isOnline: true,
                  lastSyncTime: "10 minutes ago",
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
                        count: '3',
                        label: 'Pending Upload',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SyncStatsCard(
                        icon: Icons.cloud_done,
                        iconColor: AppColors.syncedCountColor,
                        backgroundColor: AppColors.syncedCountColor
                            .withOpacity(0.1),
                        count: '142',
                        label: 'Synced Today',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Pending Sync Section
                SyncListWidget(
                  sectionTitle: 'Pending Sync',
                  itemCount: 3,
                  onRetryAll: () {},
                  onRetryItem: (index) {},
                  items: [
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
                      status: SyncItemStatus.syncing,
                    ),
                    SyncItem(
                      icon: Icons.warning,
                      iconColor: AppColors.emailUsIconColor,
                      title: 'Survey Form #2209',
                      subtitle: 'Name should be at least 3 characters',
                      status: SyncItemStatus.failed,
                    ),
                  ],
                ),
            
                // const SizedBox(height: 15),
            
                // Synced Successfully Section
                SyncListWidget(
                  sectionTitle: 'Synced Successfully',
                  itemCount: 2,
                  onToggle: () => debugPrint('Toggle synced section'),
                  items: [
                    SyncItem(
                      icon: Icons.article,
                      iconColor: AppColors.nextStep3Color,
                      title: 'Survey Form #2208',
                      subtitle: 'Synced 12 mins ago',
                      status: SyncItemStatus.success,
                    ),
                    SyncItem(
                      icon: Icons.description,
                      iconColor: AppColors.syncedCountColor,
                      title: 'Traffic/Trade #2209',
                      subtitle: 'Synced 09:15 AM',
                      status: SyncItemStatus.success,
                    ),
                    SyncItem(
                      icon: Icons.storage_rounded,
                      iconColor: AppColors.commissioningColor,
                      title: 'Databased Update',
                      subtitle: 'Synced 04:00 AM',
                      status: SyncItemStatus.success,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
