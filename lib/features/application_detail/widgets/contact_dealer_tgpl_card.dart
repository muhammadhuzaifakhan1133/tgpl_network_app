import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class ContactDealerTGPLCard extends ConsumerWidget {
  // take parameters for all fields to show
  final String npName;
  final String source;
  final String sourceName;
  final String conductedBy;
  final String dealerName;
  final String dealerContact;
  final String referenceBy;

  const ContactDealerTGPLCard({
    super.key,
    required this.npName,
    required this.source,
    required this.sourceName,
    required this.conductedBy,
    required this.dealerName,
    required this.dealerContact,
    required this.referenceBy,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isContactDealerTGPLCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Contact (Dealer & TGPL)",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleContactDealerTGPLCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "NP. Name",
          hintText: npName,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Source",
          hintText: source,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Source Name",
          hintText: sourceName,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Conducted By",
          hintText: conductedBy,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Dealer Name",
          hintText: dealerName,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Dealer Contact",
                hintText: dealerContact,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Reference By",
                hintText: referenceBy,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
