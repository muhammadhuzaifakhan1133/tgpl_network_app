import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_controller.dart';
import 'package:tgpl_network/features/station_form/presentation/widgets/form_steps_indicator.dart';
import 'package:tgpl_network/features/station_form/presentation/widgets/form_steps_title.dart';

class StationFormView extends StatelessWidget {
  const StationFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Stack(
            children: [
              Column(
                children: [
                  SvgPicture.asset(AppImages.tajLogoSvg, width: 50, height: 50),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome to\nTaj Gasoline",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.neutra700black32.copyWith(height: 1),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Apply for a new TGPL retail station. Fill in the details below and our team will contact you shortly.",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.googleInter400Grey14,
                  ),
                  const SizedBox(height: 12),
                  // steps indicator
                  FormStepsIndicator(),
                  const SizedBox(height: 12),
                  FormStepsTitle(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final controller = ref.read(
                          stationFormControllerProvider.notifier,
                        );
                        return PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller.steps.length,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (value) {
                            controller.goToStep(value);
                          },
                          itemBuilder: (context, index) {
                            return controller.steps[index];
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Consumer(
                  builder: (context, ref, child) {
                    return actionContainer(
                      padding: 12,
                      icon: AppImages.backIconSvg,
                      onTap: () {
                        final controller = ref.read(
                          stationFormControllerProvider.notifier,
                        );
                        controller.onPreviousButtonPressed();
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
  }
}
