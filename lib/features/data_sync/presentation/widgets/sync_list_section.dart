import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

enum SyncItemStatus { pending, syncing, failed, success }

class SyncListWidget extends ConsumerWidget {
  final String sectionTitle;
  final List<SyncItem> items;
  final bool isCollapsed;
  final VoidCallback? onToggle;
  final VoidCallback? onRetryAll;
  final Function(String)? onRetryItem;

  const SyncListWidget({
    super.key,
    required this.sectionTitle,
    required this.items,
    this.isCollapsed = false,
    this.onToggle,
    this.onRetryAll,
    this.onRetryItem,
  });

  IconData _getSyncIcon(SyncItem item) {
    final surveyForm = item.surveyForm;
    final trafficTradeForm = item.trafficTradeForm;
    if ((surveyForm?.errorMessage.isNotNullOrEmpty ?? false) ||
        (trafficTradeForm?.errorMessage.isNotNullOrEmpty ?? false)) {
      return Icons.warning;
    } else if (surveyForm != null) {
      return Icons.local_gas_station;
    } else if (trafficTradeForm != null) {
      return Icons.traffic;
    } else {
      return Icons.help_outline;
    }
  }

  Color _getSyncIconColor(SyncItem item) {
    final surveyForm = item.surveyForm;
    final trafficTradeForm = item.trafficTradeForm;
    if ((surveyForm?.errorMessage.isNotNullOrEmpty ?? false) ||
        (trafficTradeForm?.errorMessage.isNotNullOrEmpty ?? false)) {
      return AppColors.emailUsIconColor;
    } else if (surveyForm != null) {
      return AppColors.nextStep3Color;
    } else if (trafficTradeForm != null) {
      return AppColors.syncedCountColor;
    } else {
      return AppColors.lightGrey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  style: AppTextstyles.neutra700black32.copyWith(fontSize: 16),
                  children: [
                    TextSpan(
                      text: '  (${items.length} items)',
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
              return _buildSyncItemCard(ref, item, index);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSyncItemCard(WidgetRef ref, SyncItem item, int index) {
    return GestureDetector(
      onTap: () {
        if (item.status != SyncItemStatus.success) {
          final selectedItem = ref.read(selectedFormForActionProvider);
          if (selectedItem?.id == item.id) {
            ref.read(selectedFormForActionProvider.notifier).state = null;
          } else {
            ref.read(selectedFormForActionProvider.notifier).state = item;
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // only left border colored
          border: Border(
            left: BorderSide(color: _getSyncIconColor(item), width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getSyncIconColor(item).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getSyncIcon(item),
                    color: _getSyncIconColor(item),
                    size: 24,
                  ),
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
                      Text(item.subtitle, style: AppTextstyles.neutra500grey12),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Status Action
                _buildStatusWidget(item.status, item.id),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final selectedItem = ref.watch(selectedFormForActionProvider);
                bool showAction =
                    selectedItem?.id == item.id &&
                    item.status != SyncItemStatus.success;
                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: showAction
                      ? Column(
                          children: [
                            const SizedBox(height: 5),
                            const Divider(),
                            // const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // delete button
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20,
                                  onPressed:
                                      item.status != SyncItemStatus.syncing
                                      ? () {
                                          ref
                                              .read(
                                                dataSyncControllerProvider
                                                    .notifier,
                                              )
                                              .deletePendingFormIfAny(item.id);
                                        }
                                      : null,
                                  icon: Icon(Icons.delete),
                                  color: AppColors.rejectedCountDarkColor,
                                ),
                                // edit button
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20,
                                  onPressed:
                                      item.status != SyncItemStatus.syncing
                                      ? () async {
                                          var isSuccess;
                                          if (item.surveyForm != null) {
                                            isSuccess = await ref
                                                .read(goRouterProvider)
                                                .push(
                                                  AppRoutes.surveyForm(
                                                    item.id.toString(),
                                                  ),
                                                );
                                          } else if (item.trafficTradeForm !=
                                              null) {
                                            isSuccess = await ref
                                                .read(goRouterProvider)
                                                .push(
                                                  AppRoutes.trafficTradeForm(
                                                    item.id.toString(),
                                                  ),
                                                );
                                          }
                                          if (isSuccess == true) {
                                            // ignore: unused_result
                                            ref.refresh(
                                              dataSyncControllerProvider,
                                            );
                                          }
                                        }
                                      : null,
                                  icon: Icon(Icons.edit),
                                  color: AppColors.nextStep3Color,
                                ),
                                // retry button.
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20,
                                  onPressed:
                                      item.status != SyncItemStatus.syncing &&
                                          onRetryItem != null
                                      ? () => onRetryItem!(item.id)
                                      : null,
                                  icon: const Icon(Icons.refresh),
                                  color: AppColors.syncedCountColor,
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(height: 12),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWidget(SyncItemStatus status, String applicationId) {
    switch (status) {
      // retry action
      case SyncItemStatus.pending:
        return SizedBox.shrink();

      case SyncItemStatus.syncing:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.syncedCountColor,
            ),
          ),
        );

      case SyncItemStatus.failed:
        return Icon(Icons.error, color: AppColors.emailUsIconColor, size: 20);

      case SyncItemStatus.success:
        return const Icon(
          Icons.cloud_done,
          size: 20,
          color: AppColors.inauguratedCountColor,
        );
    }
  }
}
