import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/utils/extensions/screen_size_extension.dart';

Widget buildNavItem({
    required int index,
    required String iconPath,
    Widget? iconWidget,
    required String label,
    required bool isLoading,
    required BuildContext context,
    required StatefulNavigationShell navigationShell,
    required void Function(int index) onTap,
  }) {
    bool isSelected = navigationShell.currentIndex == index;
    if (isLoading) {
      // shimmer nav item using shimmer package
      return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: context.screenWidth * 0.06, height: context.screenWidth * 0.06, color: AppColors.grey.shade300),
              SizedBox(height: 4.h),
              Container(width: context.screenWidth * 0.125, height: 12.h, color: AppColors.grey.shade300),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          // Smooth color transition
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(15.r),
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
                    width: context.screenWidth * 0.06,
                    height: context.screenWidth * 0.06,
                  ),
            ),
            SizedBox(height: 4.h),
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