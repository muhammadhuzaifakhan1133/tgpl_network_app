import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';

class HomeShellView extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const HomeShellView({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeShellControllerProvider);
    bool isLoading = state.isLoading && ref.read(isOpenHomeFirstTimeProvider);
    return Scaffold(
      body: navigationShell,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              index: 0,
              iconPath: AppImages.dashboardInactiveSvg,
              label: "Dashboard",
              isLoading: isLoading,
            ),
            _buildNavItem(
              index: 1,
              iconPath: AppImages.applicationsInactiveSvg,
              label: "Application",
              isLoading: isLoading,
            ),
            _buildNavItem(
              index: 2,
              iconPath: AppImages.mapInactiveSvg,
              label: "Map",
              isLoading: isLoading,
            ),
            _buildNavItem(
              index: 3,
              iconPath: "",
              iconWidget: Icon(
                Icons.cloud_sync_sharp,
                color: navigationShell.currentIndex == 3
                    ? AppColors.primary
                    : AppColors.grey,
                size: 20,
              ),
              label: "Sync Data",
              isLoading: isLoading,
            ),
            _buildNavItem(
              index: 4,
              iconPath: AppImages.profileInactiveSvg,
              label: "Profiles",
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    Widget? iconWidget,
    required String label,
    required bool isLoading,
  }) {
    bool isSelected = navigationShell.currentIndex == index;
    if (isLoading) {
      // shimmer nav item using shimmer package
      return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 24, height: 24, color: AppColors.grey.shade300),
              const SizedBox(height: 4),
              Container(width: 50, height: 12, color: AppColors.grey.shade300),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          // Smooth color transition
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon scaling animation
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child:
                  iconWidget ??
                  SvgPicture.asset(
                    iconPath,
                    color: isSelected ? AppColors.primary : null,
                    width: 20,
                    height: 20,
                  ),
            ),
            const SizedBox(height: 4),
            // Text color and style animation
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: isSelected
                  ? AppTextstyles.neutra500grey12.copyWith(
                      color: AppColors.primary,
                    )
                  : AppTextstyles.neutra500grey12,
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
