import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/onboarding/presentation/onboarding_controller.dart';
import 'package:tgpl_network/features/onboarding/presentation/widgets/onboarding_content_section.dart';
import 'package:tgpl_network/utils/screen_size_extension.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    // Trigger entry animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingEntryAnimationProvider.notifier).state = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = ref.watch(onboardingDataProvider);

    // Listen to page changes from controller and animate
    ref.listen<int>(
      onboardingControllerProvider,
      (previous, next) {
        if (previous != next && _pageController.hasClients) {
          _pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
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
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  ref.read(onboardingControllerProvider.notifier).setCurrentPage(index);
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
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
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingContentSection(),
          ),
        ],
      ),
    );
  }
}