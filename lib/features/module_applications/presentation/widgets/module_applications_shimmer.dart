import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4),
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
          const SizedBox(height: 8),

          // Dealer name and site name
          const ShimmerBox(
            width: double.infinity,
            height: 20,
            borderRadius: 4,
          ),
          const SizedBox(height: 6),

          // Source name
          const ShimmerBox(
            width: 120,
            height: 14,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),

          // Divider
          const ShimmerBox(
            width: double.infinity,
            height: 1,
            borderRadius: 0,
          ),
          const SizedBox(height: 6.75),

          // Phone and location row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: const [
                    ShimmerBox(
                      width: 16,
                      height: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ShimmerBox(
                        height: 13,
                        borderRadius: 4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: const [
                    ShimmerBox(
                      width: 16,
                      height: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(width: 8),
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
          const SizedBox(height: 6.75),

          // Divider
          const ShimmerBox(
            width: double.infinity,
            height: 1,
            borderRadius: 0,
          ),
          const SizedBox(height: 8),

          // Bottom row - date and action buttons
          Row(
            children: const [
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
              SizedBox(width: 8),
              ShimmerBox(
                width: 40,
                height: 40,
                borderRadius: 8,
              ),
              SizedBox(width: 8),
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