// lib/features/application_form/presentation/forms/step1/step1_form_shimmer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/shimmer_textfield.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';

class ApplicationFormShimmer extends StatelessWidget {
  const ApplicationFormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Stack(
          children: [
            ListView(
              children: [
                // Logo shimmer
                const ShimmerBox.circular(
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 10.h),

                // Title shimmer
                Center(
                  child: Column(
                    children: [
                      const ShimmerBox(
                        width: 250,
                        height: 32,
                        borderRadius: 4,
                      ),
                      SizedBox(height: 8.h),
                      const ShimmerBox(
                        width: 200,
                        height: 32,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                // Description shimmer
                Center(
                  child: Column(
                    children: [
                      const ShimmerBox(
                        width: 400,
                        height: 14,
                        borderRadius: 4,
                      ),
                      SizedBox(height: 4.h),
                      const ShimmerBox(
                        width: 350,
                        height: 14,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Steps indicator shimmer
                const StepsIndicatorShimmer(),
                SizedBox(height: 12.h),

                // Step title shimmer
                const ShimmerBox(
                  width: 120,
                  height: 16,
                  borderRadius: 4,
                ),
                SizedBox(height: 20.h),

                // Form content shimmer (you can switch between different step shimmers)
                const Step1FormShimmer(),
              ],
            ),

            // Back button shimmer
            Positioned(
              left: 0,
              top: 0,
              child: const ShimmerBox.circular(
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepsIndicatorShimmer extends StatelessWidget {
  const StepsIndicatorShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++) // Assuming 5 steps
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: const ShimmerBox(
                height: 8,
                borderRadius: 16,
              ),
            ),
          ),
      ],
    );
  }
}

class Step1FormShimmer extends StatelessWidget {
  const Step1FormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title shimmer
        const ShimmerBox(
          width: 200,
          height: 28,
          borderRadius: 4,
        ),
        SizedBox(height: 24.h),

        // Applicant Name
        const ShimmerTextField(),
        SizedBox(height: 16.h),

        // Contact Person
        const ShimmerTextField(),
        SizedBox(height: 16.h),

        // Currently Presence
        const ShimmerTextField(),
        SizedBox(height: 16.h),

        // Contact Number
        const ShimmerTextField(),
        SizedBox(height: 16.h),

        // WhatsApp Number
        const ShimmerTextField(),
        SizedBox(height: 20.h),

        // Button shimmer
        const ShimmerBox(
          width: double.infinity,
          height: 48,
          borderRadius: 8,
        ),
      ],
    );
  }
}