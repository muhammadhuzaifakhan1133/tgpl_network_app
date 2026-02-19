import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class ApplicantInfoCard extends ConsumerWidget {
  // take parameters for all fields to show
  final String applicantName;
  final String contactPerson;
  final String currentPresence;
  final String contactNumber;
  final String whatsappNumber;

  const ApplicantInfoCard({
    super.key,
    required this.applicantName,
    required this.contactPerson,
    required this.currentPresence,
    required this.contactNumber,
    required this.whatsappNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isApplicationDetailCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Applicant Info",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleApplicationDetailCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Applicant Name",
          hintText: applicantName,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Contact Person",
          hintText: contactPerson,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Currently Presence",
          hintText: currentPresence,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Contact Number",
          hintText: contactNumber,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "WhatsApp Number",
          hintText: whatsappNumber,
        ),
      ],
    );
  }
}
