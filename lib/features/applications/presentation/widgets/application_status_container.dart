import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/get_priority_color.dart';

class ApplicationStatusContainer extends ConsumerWidget {
  final int index;
  final bool isExpanded;
  final ApplicationModel application;
  const ApplicationStatusContainer({
    super.key,
    required this.isExpanded,
    required this.application,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStatuses = ref.read(appStatusesProvider(index));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  application.entryCode.toString(),
                  style: AppTextstyles.googleInter400LightGrey12.copyWith(
                    color: AppColors.subHeadingColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: getPriorityColor(
                    application.priority.toString(),
                  ).withOpacity(0.082),
                ),
                child: Center(
                  child: Text(
                    application.priority.toString(),
                    style: AppTextstyles.googleInter400LightGrey12.copyWith(
                      color: getPriorityColor(application.priority.toString()),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 500),
                child: Icon(
                  Icons.expand_more,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ],
          ),
          Text(
            application.dealerName.toString(),
            style: AppTextstyles.googleInter700black28.copyWith(fontSize: 20),
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppImages.locationIconSvg,
                color: AppColors.subHeadingColor,
              ),
              const SizedBox(width: 5),
              Text(
                application.cityName.toString(),
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                AppImages.calendarIconSvg,
                color: AppColors.subHeadingColor,
              ),
              const SizedBox(width: 5),
              Text(
                application.addDate.toString().formatTodMMMyyyy(),
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              for (int i = 0; i < appStatuses.length; i++)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: appStatuses[i].status
                          ? AppColors.nextStep2Color
                          : AppColors.inactiveStatusColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 6,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: AppColors.lightGrey),
                      const SizedBox(height: 2),
                      Text(
                        "Process Status",
                        style: AppTextstyles.googleInter600black18,
                      ),
                      for (int i = 0; i < appStatuses.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(child: Text(appStatuses[i].title)),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: appStatuses[i].status
                                      ? AppColors.nextStep2Color.withOpacity(
                                          0.082,
                                        )
                                      : AppColors.emailUsIconColor.withOpacity(
                                          0.082,
                                        ),
                                ),
                                child: Text(
                                  appStatuses[i].status ? "Yes" : "No",
                                  style: AppTextstyles.googleInter600black18
                                      .copyWith(
                                        fontSize: 12,
                                        color: appStatuses[i].status
                                            ? AppColors.nextStep2Color
                                            : AppColors.emailUsIconColor,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 2),
                      Divider(color: AppColors.lightGrey),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              height: 41,
                              text: "",
                              topPadding: 10,
                              bottomPadding: 10,
                              rightPadding: 0,
                              leftPadding: 0,
                              backgroundColor: AppColors.actionContainerColor,
                              child: Text(
                                "Directions",
                                style: AppTextstyles.googleInter500LabelColor14
                                    .copyWith(color: AppColors.black2Color),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              height: 41,
                              text: "",
                              topPadding: 10,
                              bottomPadding: 10,
                              rightPadding: 0,
                              leftPadding: 0,
                              backgroundColor: AppColors.nextStep1Color,
                              child: Text(
                                "View Details",
                                style: AppTextstyles.googleInter500LabelColor14
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
