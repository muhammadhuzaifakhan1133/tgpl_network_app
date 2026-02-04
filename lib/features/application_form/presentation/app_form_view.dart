import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step1/step1_form_view.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step2/step2_form_view.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step3/step3_form_view.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/widgets/app_form_shimmer_widget.dart';
import 'package:tgpl_network/features/application_form/presentation/widgets/form_steps_indicator.dart';
import 'package:tgpl_network/features/application_form/presentation/widgets/form_steps_title.dart';
import 'package:tgpl_network/routes/app_router.dart';

class StationFormView extends ConsumerStatefulWidget {
  const StationFormView({super.key});

  @override
  ConsumerState<StationFormView> createState() => _StationFormViewState();
}

class _StationFormViewState extends ConsumerState<StationFormView> {
  late final PageController _pageController;

  final List<Widget> _steps = const [
    Step1FormView(),
    Step2FormView(),
    Step3FormView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prerequisiteValuesState = ref.watch(formPrerequisiteValuesProvider);
    return prerequisiteValuesState.when(
      data: (_) {
        ref.listen(appFormControllerProvider, (prev, next) {
          if (prev?.currentStep != next.currentStep) {
            _pageController.animateToPage(
              next.currentStep,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 50.h),
              child: Stack(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final controller = ref.read(
                        appFormControllerProvider.notifier,
                      );
                      return PageView.builder(
                        controller: _pageController,
                        itemCount: _steps.length,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          controller.goToStep(value);
                        },
                        itemBuilder: (context, index) {
                          return ListView(
                            children: [
                              SizedBox(height: 20.h),
                              SvgPicture.asset(
                                AppImages.tajLogoSvg,
                                width: 45.w,
                                height: 45.h,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Welcome to\nTaj Gasoline",
                                textAlign: TextAlign.center,
                                style: AppTextstyles.neutra700black32.copyWith(
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: 13.h),
                              Text(
                                "Apply for a new TGPL retail station. Fill in the details below and our team will contact you shortly.",
                                textAlign: TextAlign.center,
                                style: AppTextstyles.googleInter400Grey14,
                              ),
                              SizedBox(height: 12.h),
                              // steps indicator
                              FormStepsIndicator(),
                              SizedBox(height: 12.h),
                              FormStepsTitle(),
                              SizedBox(height: 24.h),
                              _steps[index],
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return actionContainer(
                          padding: 12,
                          leftMargin: 0,
                          icon: AppImages.backIconSvg,
                          onTap: () {
                            final controller = ref.read(
                              appFormControllerProvider.notifier,
                            );
                            controller.previousStep(
                              onBackFromFirstStep: () {
                                ref.read(goRouterProvider).pop();
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) => errorWidget(error.toString()),
      loading: () => const ApplicationFormShimmer(),
    );
  }
}
