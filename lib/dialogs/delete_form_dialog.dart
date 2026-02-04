import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';

Future<dynamic> deleteFormDialog(
  BuildContext context,
  WidgetRef ref,
  SyncItem item,
) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(
          'Confirm Deletion',
          style: AppTextstyles.googleInter700black28.copyWith(fontSize: 20),
        ),
        content: Text(
          'Are you sure you want to delete this pending form? This action cannot be undone.',
          style: AppTextstyles.googleInter400black16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(goRouterProvider).pop();
            },
            child: Text(
              'Cancel',
              style: AppTextstyles.googleInter500LabelColor14.copyWith(
                color: AppColors.nextStep1Color,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(goRouterProvider).pop();
              ref
                  .read(dataSyncControllerProvider.notifier)
                  .deletePendingFormIfAny(item.id);
            },
            child: Text(
              'Delete',
              style: AppTextstyles.googleInter500LabelColor14.copyWith(
                color: AppColors.rejectedCountDarkColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}
