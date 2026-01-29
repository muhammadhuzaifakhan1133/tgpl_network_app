import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ApplicationStatusShimmerCard();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}

class ApplicationStatusShimmerCard extends StatelessWidget {
  const ApplicationStatusShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (ID)
          const Row(
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
          const SizedBox(height: 8),
          
          // Applicant Name
          const ShimmerBox(
            width: double.infinity,
            height: 20,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),
          
          // Location and Date Row
          Row(
            children: [
              ShimmerWidget.circular(
                width: 14,
                height: 14,
              ),
              const SizedBox(width: 5),
              const ShimmerBox(
                width: 80,
                height: 13,
                borderRadius: 4,
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Progress Bars
          Row(
            children: [
              for (int i = 0; i < 15; i++)
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: ShimmerBox(
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