import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/application_form/presentation/confirmation/widgets/application_id_container.dart';
import 'package:tgpl_network/features/application_form/presentation/confirmation/widgets/next_step_or_help_container.dart';
import 'package:tgpl_network/routes/app_router.dart';

class AppFormConfirmationView extends ConsumerWidget {
  final String applicationId;
  const AppFormConfirmationView({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: CustomButton(
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
          text: "Back to Home",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Center(
          child: ListView(
            children: [
              SvgPicture.asset(
                AppImages.tickWithCircleIconSvg,
                width: 72.w,
                height: 72.h,
              ),
              SizedBox(height: 12.h),
              Text(
                "Application Submitted!",
                textAlign: TextAlign.center,
                style: AppTextstyles.neutra700black32.copyWith(fontSize: 28.sp),
              ),
              SizedBox(height: 13.h),
              Text(
                "Thank you for applying with Taj Gasoline. Your application has been received successfully.",
                textAlign: TextAlign.center,
                style: AppTextstyles.googleInter400black16.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              ApplicationIdContainer(applicationId: applicationId),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What's Next?",
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 24.sp,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Review, Verification and Approvals",
                  style: AppTextstyles.googleInter400black16,
                ),
              ),
              SizedBox(height: 24.h),
              NextStepOrHelpContainer(
                step: "1",
                color: AppColors.nextStep1Color,
                title: "Application Review",
                subtitle:
                    "Our team will review your application within 24-48 hours",
              ),
              SizedBox(height: 24.h),
              NextStepOrHelpContainer(
                step: "2",
                color: AppColors.nextStep2Color,
                title: "Site Verification",
                subtitle:
                    "We'll contact you to schedule a site visit and verification",
              ),
              SizedBox(height: 24.h),
              NextStepOrHelpContainer(
                step: "3",
                color: AppColors.nextStep3Color,
                title: "Next Steps",
                subtitle:
                    "We'll guide you through the approval and setup process",
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Need Help?",
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 24.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              NextStepOrHelpContainer(
                icon: AppImages.helplineIconSvg,
                color: AppColors.nextStep1Color,
                title: "Call Helpline",
                subtitle: "021-111-TGPL (8475)",
              ),
              SizedBox(height: 24.h),
              NextStepOrHelpContainer(
                icon: AppImages.messageIconSvg,
                color: AppColors.nextStep2Color,
                title: "WhatsApp Support",
                subtitle: "+92 300 1234567",
              ),
              SizedBox(height: 24.h),
              NextStepOrHelpContainer(
                icon: AppImages.emailIconSvg,
                color: AppColors.emailUsIconColor,
                title: "Email Us",
                subtitle: "support@tajgasoline.com",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
