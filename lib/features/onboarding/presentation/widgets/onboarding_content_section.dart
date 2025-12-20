import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/animated_text.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_controller.dart';
import 'package:tgpl_network/features/onboarding/presentation/widgets/onboarding_content_container_clipper.dart';
import 'package:tgpl_network/utils/extensions.dart';

class OnboardingContentSection extends ConsumerWidget {
  const OnboardingContentSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAnimation = ref.watch(onboardingEntryAnimationProvider);
    final onBoardingController = ref.read(
      onboardingControllerProvider.notifier,
    );
    final onboardingState = ref.watch(onboardingControllerProvider);
    final data = onBoardingController.getData(onboardingState.currentPageIndex);
    return AnimatedSlide(
      offset: showAnimation ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: showAnimation ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: ClipPath(
          clipper: OnboardingContentContainerClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              width: context.screenWidth,
              // constraints: BoxConstraints(minHeight: context.screenHeight * 0.45),
              color: Colors.white.withOpacity(0.15),
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 20.0,
                top: 100.0,
                bottom: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  AnimatedText(
                    child: Text(
                      data.title,
                      key: ValueKey(data.title),
                      textAlign: TextAlign.center,
                      style: AppTextstyles.neutra500white32,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  AnimatedText(
                    child: Text(
                      data.description,
                      key: ValueKey(data.description),
                      textAlign: TextAlign.center,
                      style: AppTextstyles.neutra500white18,
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  CustomButton(
                    onPressed: onBoardingController.onActionButtonPressed,
                    text: "",
                    child: AnimatedText(
                      child: Text(
                        data.buttonText,
                        key: ValueKey(data.buttonText),
                        textAlign: TextAlign.center,
                        style: AppTextstyles.neutra500white22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      onBoardingController.dataLength,
                      (index) => onboardingPageIndicator(
                        index: index,
                        currentPageIndex: onboardingState.currentPageIndex,
                        onTap: () {
                          onBoardingController.jumpToPage(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector onboardingPageIndicator({
    required int index,
    required int currentPageIndex,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 5,
        width: index == currentPageIndex ? 30 : 15,
        decoration: BoxDecoration(
          color: index == currentPageIndex
              ? AppColors.white
              : AppColors.halfWhite,
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );
  }
}
