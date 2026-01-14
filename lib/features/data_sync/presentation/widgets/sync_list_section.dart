import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';

enum SyncItemStatus { pending, syncing, failed, success }

class SyncListWidget extends StatelessWidget {
  final String sectionTitle;
  final int itemCount;
  final List<SyncItem> items;
  final bool isCollapsed;
  final VoidCallback? onToggle;
  final VoidCallback? onRetryAll;
  final Function(int)? onRetryItem;

  const SyncListWidget({
    super.key,
    required this.sectionTitle,
    required this.itemCount,
    required this.items,
    this.isCollapsed = false,
    this.onToggle,
    this.onRetryAll,
    this.onRetryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: sectionTitle,
                  style: AppTextstyles.neutra700black32.copyWith(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: '  ($itemCount items)',
                      style: AppTextstyles.neutra500grey12.copyWith(
                        fontSize: 14,
                      ), 
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (onRetryAll != null)
                    TextButton(
                      onPressed: onRetryAll,
                      child: Text(
                        'Retry All',
                        style: AppTextstyles.neutra500grey12.copyWith(
                          fontSize: 14,
                          color: AppColors.syncedCountColor,
                        ),
                      ),
                    ),
                  if (onToggle != null)
                    IconButton(
                      onPressed: onToggle,
                      icon: Icon(
                        isCollapsed
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ],
          ),
        ),

        // Items List
        if (!isCollapsed)
          Column(
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              SyncItem item = entry.value;
              return _buildSyncItemCard(item, index);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSyncItemCard(SyncItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // only left border colored
        border: Border(left: BorderSide(color: item.iconColor, width: 4)),
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
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 24),
          ),
          const SizedBox(width: 12),

          // Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextstyles.neutra500grey12.copyWith(
                    fontSize: 14,
                    color: AppColors.black2Color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: AppTextstyles.neutra500grey12,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Status Action
          _buildStatusWidget(item.status, index),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(SyncItemStatus status, int index) {
    switch (status) {
      // retry action
      case SyncItemStatus.pending:
        return IconButton(
          onPressed: onRetryItem != null ? () => onRetryItem!(index) : null,
          icon: const Icon(Icons.refresh),
          color: AppColors.nextStep3Color,
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        );

      case SyncItemStatus.syncing:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.syncedCountColor),
          ),
        );

      case SyncItemStatus.failed:
        return Icon(Icons.edit, color: AppColors.emailUsIconColor, size: 20);

      case SyncItemStatus.success:
        return const Icon(Icons.cloud_done, size: 20, color: AppColors.inauguratedCountColor);
    }
  }
}
