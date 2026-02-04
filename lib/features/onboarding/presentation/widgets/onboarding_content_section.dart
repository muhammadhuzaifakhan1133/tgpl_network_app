import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/animated_text.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_controller.dart';
import 'package:tgpl_network/features/onboarding/presentation/widgets/onboarding_content_container_clipper.dart';
import 'package:tgpl_network/utils/extensions/screen_size_extension.dart';

class OnboardingContentSection extends ConsumerWidget {
  const OnboardingContentSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAnimation = ref.watch(onboardingEntryAnimationProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final currentPageIndex = ref.watch(onboardingControllerProvider);
    final data = controller.currentPageData;
    final totalPages = controller.totalPages;

    return AnimatedSlide(
      offset: showAnimation ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: showAnimation ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: ClipPath(
          clipper: OnboardingContentContainerClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              width: context.screenWidth,
              color: Colors.white.withOpacity(0.15),
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 20.0,
                top: 100,
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
                  SizedBox(height: 15.0.h),
                  AnimatedText(
                    child: Text(
                      data.description,
                      key: ValueKey(data.description),
                      textAlign: TextAlign.center,
                      style: AppTextstyles.neutra500white18,
                    ),
                  ),
                  SizedBox(height: 42.46.h),
                  CustomButton(
                    onPressed: controller.onActionButtonPressed,
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
                  SizedBox(height: 20.h),
                  _PageIndicators(
                    totalPages: totalPages,
                    currentPageIndex: currentPageIndex,
                    onPageTap: controller.jumpToPage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageIndicators extends StatelessWidget {
  final int totalPages;
  final int currentPageIndex;
  final void Function(int) onPageTap;

  const _PageIndicators({
    required this.totalPages,
    required this.currentPageIndex,
    required this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) => _PageIndicator(
          index: index,
          currentPageIndex: currentPageIndex,
          onTap: () => onPageTap(index),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int index;
  final int currentPageIndex;
  final VoidCallback onTap;

  const _PageIndicator({
    required this.index,
    required this.currentPageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentPageIndex;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 5.h,
        width: isActive ? 30.w : 15.w,
        decoration: BoxDecoration(
          color: isActive ? AppColors.white : AppColors.halfWhite,
          borderRadius: BorderRadius.circular(11.r),
        ),
      ),
    );
  }
}
