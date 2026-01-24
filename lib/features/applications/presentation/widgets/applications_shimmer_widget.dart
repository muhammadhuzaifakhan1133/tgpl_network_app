import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row (ID, Priority, Arrow)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 12,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                const SizedBox(width: 8),
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
            const SizedBox(height: 8),
            
            // Applicant Name
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            
            // Location and Date Row
            Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  height: 13,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  height: 13,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Progress Bars
            Row(
              children: [
                for (int i = 0; i < 19; i++)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 6,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}