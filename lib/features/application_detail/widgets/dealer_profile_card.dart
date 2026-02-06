import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class DealerProfileCard extends ConsumerWidget {
  final String isDealer;
  final String platform;
  final String otherDealerBusinesses;
  final String dealerInvolvementInBusiness;
  final String isReadyToInjectCapital;
  final String reasonForConversion;
  final String currentAttendantSalary;
  final String isAgreedToFollowStandards;
  const DealerProfileCard({
    super.key,
    required this.isDealer,
    required this.platform,
    required this.otherDealerBusinesses,
    required this.dealerInvolvementInBusiness,
    required this.isReadyToInjectCapital,
    required this.reasonForConversion,
    required this.currentAttendantSalary,
    required this.isAgreedToFollowStandards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isDealerProfileCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Dealer Profile",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleDealerProfileCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is this Dealer",
          hintText: isDealer,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Platform",
          hintText: platform,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "What other businesses does the dealer have, Mention # of business and types.",
          hintText: otherDealerBusinesses,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "How involved is the dealer in petrol pump business?",
          hintText: dealerInvolvementInBusiness,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "Is the dealer ready to inject working capital on site and operate on cash?",
          hintText: isReadyToInjectCapital,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Why does the dealer want to convert to Taj?",
          hintText: reasonForConversion,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "In case it is an operational site, what is the current salary of attendant / month",
          hintText: currentAttendantSalary,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "Is the dealer agreed to follow all TGPL operating standards?*",
          hintText: isAgreedToFollowStandards,
        ),
      ],
    );
  }
}
