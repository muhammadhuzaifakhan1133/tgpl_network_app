import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/features/application_detail/data/application_stage_model.dart';
import 'package:tgpl_network/features/application_detail/widgets/application_stage_shimmer_view.dart';

class ApplicationStagesView extends ConsumerWidget {
  final String applicationId;
  const ApplicationStagesView({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressSummary = ref.watch(
      applicationDetailAsyncControllerProvider(
        applicationId,
      ).select((s) => s.value?.progressSummary),
    );
    if (progressSummary == null) {
      return const ApplicationStagesShimmer();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Summary Card
          _buildProgressSummaryCard(
            completedStages: progressSummary.completedStages,
            totalStages: progressSummary.totalStages,
            percentage: progressSummary.completionPercentage,
          ),
          SizedBox(height: 20.h),

          // Filter Tabs
          _buildFilterTabs(
            pendingCount: progressSummary.pendingStages,
            completedCount: progressSummary.completedStages,
          ),
          SizedBox(height: 20.h),

          // Stages Grid
          _buildStagesGrid(stages: progressSummary.stages),
        ],
      ),
    );
  }

  Widget _buildProgressSummaryCard({
    required int completedStages,
    required int totalStages,
    required double percentage,
  }) {
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$completedStages',
                        style: AppTextstyles.neutra700black224.copyWith(
                          fontSize: 36.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        ' / $totalStages',
                        style: AppTextstyles.neutra700black224.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'OVERALL PROGRESS',
                    style: AppTextstyles.googleInter600black18.copyWith(
                      fontSize: 11.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$percentage%',
                    style: AppTextstyles.neutra700black224.copyWith(
                      fontSize: 28.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'COMPLETION',
                    style: AppTextstyles.googleInter600black18.copyWith(
                      fontSize: 11.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8.h,
              backgroundColor: const Color(0xFF2A3150),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs({
    required int pendingCount,
    required int completedCount,
  }) {
    final filters = [
      'All Tasks',
      'Pending ($pendingCount)',
      'Completed ($completedCount)',
    ];

    return Consumer(
      builder: (context, ref, child) {
        final selectedFilter = ref.watch(
          applicationDetailControllerProvider.select((s) => s.selectedStatus),
        );
        return SizedBox(
          height: 36.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final isSelected = selectedFilter == filter;

              return GestureDetector(
                onTap: () {
                  ref
                      .read(applicationDetailControllerProvider.notifier)
                      .selectStatus(filter);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      filter,
                      style: isSelected
                          ? AppTextstyles.neutra700black224.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.white,
                            )
                          : AppTextstyles.neutra700black224.copyWith(
                              fontSize: 13.sp,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStagesGrid({required List<ApplicationStageModel> stages}) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedFilter = ref.watch(
          applicationDetailControllerProvider.select((s) => s.selectedStatus),
        );
        // Filter stages based on selected filter
        List<ApplicationStageModel> filteredStages = stages;
        if (selectedFilter.startsWith('Pending')) {
          filteredStages = stages.where((s) => s.isPending).toList();
        } else if (selectedFilter.startsWith('Completed')) {
          filteredStages = stages.where((s) => s.isCompleted).toList();
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.2,
          ),
          itemCount: filteredStages.length,
          itemBuilder: (context, index) {
            return _buildStageCard(filteredStages[index]);
          },
        );
      },
    );
  }

  Widget _buildStageCard(ApplicationStageModel stage) {
    final isCompleted = stage.isCompleted;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isCompleted
              ? AppColors.primary.withOpacity(0.3)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status badge and indicator
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.primary
                      : AppColors.inactiveColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  isCompleted ? 'COMPLETED' : 'PENDING',
                  style: AppTextstyles.googleInter600black18.copyWith(
                    fontSize: 10.sp,
                    letterSpacing: 0.5,
                    color: isCompleted
                        ? AppColors.primary
                        : AppColors.inactiveColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Stage name
          Text(
            stage.stageName,
            style: AppTextstyles.googleInter600black18.copyWith(
              fontSize: 14.sp,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          // Due date
          Row(
            children: [
              Text(
                'DUE',
                style: AppTextstyles.googleInter600black18.copyWith(
                  fontSize: 9.sp,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                stage.dueDate ?? '-',
                style: AppTextstyles.googleInter600black18.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Completed date
          Row(
            children: [
              Text(
                'DONE',
                style: AppTextstyles.googleInter600black18.copyWith(
                  fontSize: 9.sp,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                stage.completedDate ?? '-',
                style: AppTextstyles.googleInter600black18.copyWith(
                  color: isCompleted
                      ? AppColors.primary
                      : AppColors.inactiveColor,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
