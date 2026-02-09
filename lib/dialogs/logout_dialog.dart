import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/data/shared_prefs_data_source.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/dialogs/loader_dialog.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';
import 'package:tgpl_network/main.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

Future<dynamic> logoutDialog(BuildContext context, WidgetRef ref) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(
          'Confirm Logout',
          style: AppTextstyles.googleInter700black28.copyWith(fontSize: 20.sp),
        ),
        content: Text(
          'Are you sure you want to logout?',
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
                fontSize: 16.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // first check pending forms and alert if exists
              showLoader(context);
              final isPendingFormsExist = await ref
                  .read(homeShellControllerProvider.notifier)
                  .hasPendingForms();
              ref.read(goRouterProvider).pop(); // close loader
              if (isPendingFormsExist) {
                if (context.mounted) {
                  showSnackBar(
                    context,
                    "You have pending forms. Please submit them or discard them before logging out.",
                  );
                }
                return;
              }
              // logout
              providerLogger.invalidateAll(null, ref);
              ref.read(goRouterProvider).go(AppRoutes.welcome);
              ref.read(sharedPrefsDataSourceProvider).clearAuthData();
              DatabaseHelper.instance.clearAllTables();
            },
            child: Text(
              'Logout',
              style: AppTextstyles.googleInter500LabelColor14.copyWith(
                color: AppColors.emailUsIconColor,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      );
    },
  );
}
