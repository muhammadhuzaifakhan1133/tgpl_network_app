import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/shimmer_textfield.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class ApplicationFieldsShimmer extends StatelessWidget {
  final String title;
  const ApplicationFieldsShimmer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: title,
            subtitle: "Loading...",
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                _ShimmerCard(fieldCount: 5), // Applicant Info
                SizedBox(height: 20.h),
                _ShimmerCard(fieldCount: 5), // Site Detail
                SizedBox(height: 20.h),
                _ShimmerCard(fieldCount: 5), // Contact Dealer
                SizedBox(height: 20.h),
                _ShimmerCard(fieldCount: 5), // Dealer Profile
                SizedBox(height: 20.h),
                _ShimmerCard(fieldCount: 5), // Recommendation
                SizedBox(height: 20.h),
                // Shimmer button
                const ShimmerBox(
                  width: double.infinity,
                  height: 48,
                  borderRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  final int fieldCount;

  const _ShimmerCard({required this.fieldCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with title and expand icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ShimmerBox(
                width: 150,
                height: 18,
                borderRadius: 4,
              ),
              ShimmerBox.circular(
                width: 24,
                height: 24,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Fields
          for (int i = 0; i < fieldCount; i++) ...[
            const ShimmerTextField(),
            if (i < fieldCount - 1) SizedBox(height: 10.h),
          ],
        ],
      ),
    );
  }
}