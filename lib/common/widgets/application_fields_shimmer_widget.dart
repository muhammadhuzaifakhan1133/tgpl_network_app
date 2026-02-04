import 'package:flutter/material.dart';
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
              ShimmerWidget.circular(
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Fields
          for (int i = 0; i < fieldCount; i++) ...[
            const ShimmerTextField(),
            if (i < fieldCount - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}