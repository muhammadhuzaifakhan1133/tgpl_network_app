import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class HomeShellView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeShellView({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        body: navigationShell,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        bottomNavigationBar: Container(
          // margin: const EdgeInsets.all(20), // Creates the floating effect
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            // borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, AppImages.dashboardInactiveSvg, "Dashboard"),
              _buildNavItem(
                1,
                AppImages.applicationsInactiveSvg,
                "Application",
              ),
              _buildNavItem(2, AppImages.mapInactiveSvg, "Map"),
              _buildNavItem(3, AppImages.profileInactiveSvg, "Profiles"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String label) {
    bool isSelected = navigationShell.currentIndex == index;

    return GestureDetector(
      onTap: () => _onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
              child: SvgPicture.asset(
                icon,
                color: isSelected ? AppColors.primary : null,
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
