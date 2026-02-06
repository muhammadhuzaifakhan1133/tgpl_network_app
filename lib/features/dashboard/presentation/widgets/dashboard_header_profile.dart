import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class DashboardHeaderProfile extends ConsumerWidget {
  const DashboardHeaderProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userProvider already fetched its value in build of DashboardAsyncController
    final user = ref.watch(userProvider).value;
    if (user == null) return SizedBox.shrink();
    return Row(
      children: [
        Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.nextStep1Color, AppColors.headerDarkBlueColor],
            ),
          ),
          child: Center(
            child: Text(
              user.userName[0],
              style: AppTextstyles.googleInter700black28.copyWith(
                fontSize: 20.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.userName,
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.black2Color,
                ),
              ),
              // TODO: add position field in user model
              Text(
                // user.position ?? "",
                user.fullName,
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.black2Color,
                ),
              ),
            ],
          ),
        ),
        actionContainer(
          padding: 12,
          icon: AppImages.searchIconSvg,
          onTap: () {
            ref.read(goRouterProvider).push(AppRoutes.dashboardSearch);
          },
        ),
      ],
    );
  }
}
