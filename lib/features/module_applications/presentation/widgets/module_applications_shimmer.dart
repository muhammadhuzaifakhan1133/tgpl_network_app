import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class ModuleApplicationsShimmer extends StatelessWidget {
  final int itemCount;

  const ModuleApplicationsShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return const ModuleApplicationShimmerCard();
      },
    );
  }
}

class ModuleApplicationShimmerCard extends StatelessWidget {
  const ModuleApplicationShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row - entry code and priority
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                width: 80,
                height: 14,
                borderRadius: 4,
              ),
              ShimmerBox(
                width: 60,
                height: 20,
                borderRadius: 25,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Dealer name and site name
          const ShimmerBox(
            width: double.infinity,
            height: 20,
            borderRadius: 4,
          ),
          SizedBox(height: 6.h),

          // Source name
          const ShimmerBox(
            width: 120,
            height: 14,
            borderRadius: 4,
          ),
          SizedBox(height: 8.h),

          // Divider
          const ShimmerBox(
            width: double.infinity,
            height: 1,
            borderRadius: 0,
          ),
          SizedBox(height: 6.75.h),

          // Phone and location row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ShimmerBox(
                      width: 16,
                      height: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ShimmerBox(
                        height: 13,
                        borderRadius: 4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  children: [
                    ShimmerBox(
                      width: 16,
                      height: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ShimmerBox(
                        height: 13,
                        borderRadius: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.75.h),

          // Divider
          const ShimmerBox(
            width: double.infinity,
            height: 1,
            borderRadius: 0,
          ),
          SizedBox(height: 8.h),

          // Bottom row - date and action buttons
          Row(
            children: [
              ShimmerBox(
                width: 100,
                height: 12,
                borderRadius: 4,
              ),
              Spacer(),
              ShimmerBox(
                width: 40,
                height: 40,
                borderRadius: 8,
              ),
              SizedBox(width: 8.w),
              ShimmerBox(
                width: 40,
                height: 40,
                borderRadius: 8,
              ),
              SizedBox(width: 8.w),
              ShimmerBox(
                width: 40,
                height: 40,
                borderRadius: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}