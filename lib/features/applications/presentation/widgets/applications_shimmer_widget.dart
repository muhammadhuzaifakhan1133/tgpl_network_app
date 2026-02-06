import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class ApplicationsListShimmer extends StatelessWidget {
  final int itemCount;
  
  const ApplicationsListShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ApplicationStatusShimmerCard();
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20.h);
      },
    );
  }
}

class ApplicationStatusShimmerCard extends StatelessWidget {
  const ApplicationStatusShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (ID)
          Row(
            children: [
              Expanded(
                child: ShimmerBox(
                  width: 100,
                  height: 12,
                  borderRadius: 4,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          
          // Applicant Name
          const ShimmerBox(
            width: double.infinity,
            height: 20,
            borderRadius: 4,
          ),
          SizedBox(height: 8.h),
          
          // Location and Date Row
          Row(
            children: [
              ShimmerWidget.circular(
                width: 14,
                height: 14,
              ),
              SizedBox(width: 5.w),
              const ShimmerBox(
                width: 80,
                height: 13,
                borderRadius: 4,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          
          // Progress Bars
          Row(
            children: [
              for (int i = 0; i < 15; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: const ShimmerBox(
                      width: double.infinity,
                      height: 6,
                      borderRadius: 30,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}