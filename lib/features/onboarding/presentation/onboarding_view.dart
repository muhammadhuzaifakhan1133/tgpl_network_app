import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_controller.dart';
import 'package:tgpl_network/features/onboarding/presentation/widgets/onboarding_content_section.dart';
import 'package:tgpl_network/utils/extensions.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(onboardingEntryAnimationProvider.notifier).state = true;
  });
    final onBoardingController = ref.read(
      onboardingControllerProvider.notifier,
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: context.screenWidth,
              height: context.screenHeight,
              child: PageView.builder(
                controller: onBoardingController.pageController,
                itemCount: onBoardingController.dataLength,
                onPageChanged: onBoardingController.setCurrentPage,
                itemBuilder: (context, index) {
                  final data = onBoardingController.getData(index);
                  return Container(
                    width: context.screenWidth,
                    height: context.screenHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(data.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: OnboardingContentSection(),
          ),
        ],
      ),
    );
  }
}