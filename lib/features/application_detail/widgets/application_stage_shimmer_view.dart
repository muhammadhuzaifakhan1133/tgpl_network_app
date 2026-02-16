import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class ApplicationStagesShimmer extends StatelessWidget {
  const ApplicationStagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Summary Card Shimmer
          _buildProgressSummaryCardShimmer(),
          SizedBox(height: 20.h),

          // Filter Tabs Shimmer
          _buildFilterTabsShimmer(),
          SizedBox(height: 20.h),

          // Stages Grid Shimmer
          _buildStagesGridShimmer(),
        ],
      ),
    );
  }

  Widget _buildProgressSummaryCardShimmer() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number shimmer
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ShimmerBox(width: 60.w, height: 36.h, borderRadius: 4.r),
                      SizedBox(width: 4.w),
                      ShimmerBox(width: 40.w, height: 18.h, borderRadius: 4.r),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Label shimmer
                  ShimmerBox(width: 120.w, height: 11.h, borderRadius: 4.r),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Percentage shimmer
                  ShimmerBox(width: 60.w, height: 28.h, borderRadius: 4.r),
                  SizedBox(height: 4.h),
                  // Label shimmer
                  ShimmerBox(width: 90.w, height: 11.h, borderRadius: 4.r),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Progress bar shimmer
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: ShimmerBox(
              width: double.infinity,
              height: 8.h,
              borderRadius: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabsShimmer() {
    return SizedBox(
      height: 36.h,
      child: Row(
        children: [
          ShimmerBox(width: 100.w, height: 36.h, borderRadius: 20.r),
          SizedBox(width: 12.w),
          ShimmerBox(width: 120.w, height: 36.h, borderRadius: 20.r),
          SizedBox(width: 12.w),
          ShimmerBox(width: 130.w, height: 36.h, borderRadius: 20.r),
        ],
      ),
    );
  }

  Widget _buildStagesGridShimmer() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        // Match the actual grid delegate settings
        childAspectRatio: 1.2, // Uncomment if needed
      ),
      itemCount: 6, // Show 6 shimmer cards
      itemBuilder: (context, index) {
        return _buildStageCardShimmer();
      },
    );
  }

  Widget _buildStageCardShimmer() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status badge shimmer
          Row(
            children: [
              ShimmerBox.circular(width: 8.w, height: 8.h),
              SizedBox(width: 8.w),
              ShimmerBox(width: 80.w, height: 10.h, borderRadius: 4.r),
            ],
          ),
          SizedBox(height: 12.h),

          // Stage name shimmer (2 lines)
          ShimmerBox(width: double.infinity, height: 14.h, borderRadius: 4.r),
          SizedBox(height: 6.h),
          ShimmerBox(width: 100.w, height: 14.h, borderRadius: 4.r),

          // Spacer to push dates to bottom
          SizedBox(height: 20.h),

          // Due date shimmer
          Row(
            children: [
              ShimmerBox(width: 25.w, height: 9.h, borderRadius: 4.r),
              SizedBox(width: 8.w),
              ShimmerBox(width: 50.w, height: 11.h, borderRadius: 4.r),
            ],
          ),
          SizedBox(height: 6.h),

          // Completed date shimmer
          Row(
            children: [
              ShimmerBox(width: 35.w, height: 9.h, borderRadius: 4.r),
              SizedBox(width: 8.w),
              ShimmerBox(width: 50.w, height: 11.h, borderRadius: 4.r),
            ],
          ),
        ],
      ),
    );
  }
}
