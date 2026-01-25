import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class DashboardHeaderProfile extends ConsumerWidget {
  const DashboardHeaderProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.nextStep1Color, AppColors.headerDarkBlueColor],
            ),
          ),
          child: Center(
            child: Text(
              user.name?[0] ?? "",
              style: AppTextstyles.googleInter700black28.copyWith(
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? "",
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 20,
                  color: AppColors.black2Color,
                ),
              ),
              Text(
                user.role ?? "",
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 16,
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
        // Container(
        //   height: 44,
        //   width: 44,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16.4),
        //     color: AppColors.actionContainerColor,
        //   ),
        //   child: Center(child: SvgPicture.asset(AppImages.searchIconSvg)),
        // ),
        // const SizedBox(width: 8),
        // Container(
        //   height: 44,
        //   width: 44,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16.4),
        //     color: AppColors.actionContainerColor,
        //   ),
        //   child: Center(child: SvgPicture.asset(AppImages.notificationIconSvg)),
        // ),
      ],
    );
  }
}
