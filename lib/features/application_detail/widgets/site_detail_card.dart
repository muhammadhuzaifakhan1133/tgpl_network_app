import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class SiteDetailCard extends ConsumerWidget {
  final String entryCode;
  final String dateConducted;
  final String googleLocation;
  final String city;
  final String district;
  final String priority;
  final String locationAddress;
  final String landmark;
  final String plotArea;
  final String plotFront;
  final String plotDepth;
  final String nearestDepo;
  final String distanceFromDepo;
  final String typeOfTrade;

  const SiteDetailCard({
    super.key,
    required this.entryCode,
    required this.dateConducted,
    required this.googleLocation,
    required this.city,
    required this.district,
    required this.priority,
    required this.locationAddress,
    required this.landmark,
    required this.plotArea,
    required this.plotFront,
    required this.plotDepth,
    required this.nearestDepo,
    required this.distanceFromDepo,
    required this.typeOfTrade,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isSiteDetailCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Site Detail",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleSiteDetailCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Entry Code",
          hintText: entryCode,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Date Conducted",
          hintText: dateConducted,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Google Location",
          hintText: googleLocation,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(readOnly: true, title: "City", hintText: city),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "District",
          hintText: district,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Priority",
          hintText: priority,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Location Address",
          hintText: locationAddress,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Landmark",
          hintText: landmark,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Plot Area",
          hintText: plotArea,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,

                title: "Plot Front",
                hintText: plotFront,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,

                title: "Plot Depth",
                hintText: plotDepth,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Nearest Depo",
          hintText: nearestDepo,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Distance From Depo (Km)",
          hintText: distanceFromDepo,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Type of Trade",
          hintText: typeOfTrade,
        ),
      ],
    );
  }
}
