import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/audit_perform/presentation/audit_perform_controller.dart';

class NextPreviousButtons extends ConsumerWidget {
  final int totalPages;
  const NextPreviousButtons({super.key, required this.totalPages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(currentAuditPerformPageIndexProvider);
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _previousButton(
            currentPageIndex,
            onTap: () {
              ref
                  .read(currentAuditPerformPageIndexProvider.notifier)
                  .previousPage();
            },
          ),
          _nextButton(
            currentPageIndex,
            onTap: () {
              ref
                  .read(currentAuditPerformPageIndexProvider.notifier)
                  .nextPage(totalPages);
            },
          ),
        ],
      ),
    );
  }

  Widget _previousButton(int currentPageIndex, {required VoidCallback onTap}) {
    if (currentPageIndex == 0) {
      return SizedBox(width: 100.w);
    }
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios, size: 22),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Back',
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                "Page ${currentPageIndex - 1}/$totalPages",
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Divider(thickness: 1, color: AppColors.grey),
        ],
      ),
    );
  }

  Widget _nextButton(int currentPageIndex, {required VoidCallback onTap}) {
    if (currentPageIndex == totalPages - 1) {
      return SizedBox(width: 100.w);
    }
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Divider(thickness: 2, color: AppColors.grey),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Next',
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                "Page ${currentPageIndex + 1}/$totalPages",
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_ios, size: 22),
        ],
      ),
    );
  }
}
