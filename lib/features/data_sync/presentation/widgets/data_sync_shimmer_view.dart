// lib/features/data_sync/presentation/widgets/data_sync_shimmer.dart
import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class DataSyncShimmerView extends StatelessWidget {
  const DataSyncShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: "Data Sync",
          subtitle: "Loading...",
          showResyncButton: true,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: const [
                // Connection Status Card Shimmer
                ConnectionStatusCardShimmer(),
                SizedBox(height: 20),

                // Sync Stats Cards Row
                Row(
                  children: [
                    Expanded(child: SyncStatsCardShimmer()),
                    SizedBox(width: 16),
                    Expanded(child: SyncStatsCardShimmer()),
                  ],
                ),
                SizedBox(height: 16),

                // Pending Sync List Shimmer
                SyncListShimmer(
                  sectionTitle: 'Pending Sync',
                  itemCount: 3,
                ),
                SizedBox(height: 16),

                // Synced List Shimmer
                SyncListShimmer(
                  sectionTitle: 'Synced Successfully',
                  itemCount: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Connection Status Card Shimmer
class ConnectionStatusCardShimmer extends StatelessWidget {
  const ConnectionStatusCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(
            color: Colors.grey,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(
                  width: 140,
                  height: 12,
                  borderRadius: 4,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ShimmerWidget.circular(
                      width: 10,
                      height: 10,
                    ),
                    const SizedBox(width: 8),
                    const ShimmerBox(
                      width: 80,
                      height: 20,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              ShimmerBox(
                width: 80,
                height: 12,
                borderRadius: 4,
              ),
              SizedBox(height: 8),
              ShimmerBox(
                width: 100,
                height: 16,
                borderRadius: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Sync Stats Card Shimmer
class SyncStatsCardShimmer extends StatelessWidget {
  const SyncStatsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerWidget.circular(
            width: 48,
            height: 48,
          ),
          const SizedBox(height: 12),
          const ShimmerBox(
            width: 60,
            height: 32,
            borderRadius: 4,
          ),
          const SizedBox(height: 4),
          const ShimmerBox(
            width: 100,
            height: 14,
            borderRadius: 4,
          ),
        ],
      ),
    );
  }
}

/// Sync List Shimmer
class SyncListShimmer extends StatelessWidget {
  final String sectionTitle;
  final int itemCount;

  const SyncListShimmer({
    super.key,
    required this.sectionTitle,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ShimmerBox(
                width: 180,
                height: 16,
                borderRadius: 4,
              ),
              Row(
                children: [
                  const ShimmerBox(
                    width: 70,
                    height: 14,
                    borderRadius: 4,
                  ),
                  const SizedBox(width: 8),
                  ShimmerWidget.circular(
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Items List Shimmer
        Column(
          children: List.generate(
            itemCount,
            (index) => const SyncItemCardShimmer(),
          ),
        ),
      ],
    );
  }
}

/// Individual Sync Item Card Shimmer
class SyncItemCardShimmer extends StatelessWidget {
  const SyncItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(
            color: Colors.grey,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Shimmer
          const ShimmerBox(
            width: 40,
            height: 40,
            borderRadius: 8,
          ),
          const SizedBox(width: 12),

          // Title and Subtitle Shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(
                  width: double.infinity,
                  height: 14,
                  borderRadius: 4,
                ),
                SizedBox(height: 4),
                ShimmerBox(
                  width: 120,
                  height: 12,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Status Icon Shimmer
          ShimmerWidget.circular(
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}