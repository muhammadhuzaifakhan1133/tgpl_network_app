import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/account_setting_and_support_card.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class AccountSettingsSection extends ConsumerWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account Settings", style: AppTextstyles.neutra700black224),
        SizedBox(height: 14.h),
        AccountSettingAndSupportCard(
          title: "Change Password",
          icon: AppImages.lockIconSvg,
          color: AppColors.commissioningColor,
          onTap: () {
            ref.read(goRouterProvider).push(AppRoutes.changePassword);
          },
        ),
      ],
    );
  }
}
