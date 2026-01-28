import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class ApplicationDetailShimmer extends StatelessWidget {

  const ApplicationDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Application Details",
            subtitle: "Loading...",
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                _ShimmerCard(fieldCount: 5), // Applicant Info
                const SizedBox(height: 20),
                _ShimmerCard(fieldCount: 5), // Site Detail
                const SizedBox(height: 20),
                _ShimmerCard(fieldCount: 5), // Contact Dealer
                const SizedBox(height: 20),
                _ShimmerCard(fieldCount: 5), // Dealer Profile
                const SizedBox(height: 20),
                _ShimmerCard(fieldCount: 5), // Recommendation
                const SizedBox(height: 20),
                // Shimmer button
                _ShimmerButton(),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with title and expand icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 18,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Fields
            for (int i = 0; i < fieldCount; i++) ...[
              _ShimmerTextField(),
              if (i < fieldCount - 1) const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShimmerTextField extends StatelessWidget {
  const _ShimmerTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          height: 14,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        // Text field
        Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class _ShimmerButton extends StatelessWidget {
  const _ShimmerButton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
