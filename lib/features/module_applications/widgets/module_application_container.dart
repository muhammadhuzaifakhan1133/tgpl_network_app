import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/models/application_model.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/module_applications/widgets/document_bottom_sheet.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/get_application_category_color.dart';

class ModuleApplicationContainer extends ConsumerWidget {
  final ApplicationModel application;
  final String submodule;
  const ModuleApplicationContainer({
    super.key,
    required this.application,
    required this.submodule,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(application.id, style: AppTextstyles.googleInter400Grey14),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: getApplicationCategoryColor(
                    application.category,
                  ).withOpacity(0.08),
                ),
                child: Text(
                  application.category,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 12,
                    color: getApplicationCategoryColor(application.category),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${application.applicantName} | ${application.siteName}",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 20,
              color: AppColors.black2Color,
            ),
          ),
          Text(application.source, style: AppTextstyles.googleInter400Grey14),
          const SizedBox(height: 8),
          Divider(color: AppColors.lightGrey),
          const SizedBox(height: 6.75),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.phoneIconSvg,
                      color: AppColors.subHeadingColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        application.contactNumber,
                        style: AppTextstyles.googleInter400Grey14.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.locationIconSvg,
                      color: AppColors.subHeadingColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        application.city,
                        style: AppTextstyles.googleInter400Grey14.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.75),
          Divider(color: AppColors.lightGrey),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Received: ${application.receivedDate}",
                  style: AppTextstyles.googleInter400LightGrey12,
                ),
              ),
              actionContainer(icon: AppImages.locationIconSvg, onTap: () {}),
              const SizedBox(width: 8),
              actionContainer(
                icon: AppImages.eyeIconSvg,
                onTap: () {
                  // send section to the detail view
                  ref
                      .read(goRouterProvider)
                      .push(
                        AppRoutes.applicationDetail(application.id),
                        extra: application.statusId,
                      );
                },
              ),
              if (submodule == "Survey & Dealer Profile" ||
                  submodule == "Traffic & Trade") ...[
                const SizedBox(width: 8),
                actionContainer(
                  icon: AppImages.formIconSvg,
                  onTap: () {
                    if (submodule == "Survey & Dealer Profile") {
                      ref
                          .read(goRouterProvider)
                          .push(AppRoutes.surveyForm(application.id));
                      return;
                    } else {
                      ref
                          .read(goRouterProvider)
                          .push(AppRoutes.trafficTradeForm(application.id));
                    }
                  },
                ),
              ],
              const SizedBox(width: 8),
              actionContainer(
                icon: AppImages.uploadIconSvg,
                onTap: () {
                  documentBottomSheet(
                    context: context,
                    application: application,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
