import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class RecommendationCard extends ConsumerWidget {
  final String tm;
  final String tmRecommend;
  final String tmRemarks;
  final String rm;
  final String rmRecommend;
  final String rmRemarks;
  const RecommendationCard({
    super.key,
    required this.tm,
    required this.tmRecommend,
    required this.tmRemarks,
    required this.rm,
    required this.rmRecommend,
    required this.rmRemarks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isRecommendationCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Recommendation",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleRecommendationCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(readOnly: true, title: "TM", hintText: tm),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "TM Recommend",
          hintText: tmRecommend,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "TM Remarks",
          hintText: tmRemarks,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(readOnly: true, title: "RM", hintText: rm),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "RM Recommend",
          hintText: rmRecommend,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "RM Remarks",
          hintText: rmRemarks,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
