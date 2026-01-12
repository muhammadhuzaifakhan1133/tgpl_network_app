import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/nfr_facilities_provider.dart';
import 'package:tgpl_network/common/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';

class NearbySitesFormSection extends ConsumerWidget {
  const NearbySitesFormSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _SiteFormCard(index: index);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: ref.watch(
              trafficTradeFormControllerProvider.select(
                (s) => s.nearbyTrafficSites.length,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              text: "+ Add Site",
              width: 100,
              height: 40,
              topPadding: 0,
              leftPadding: 0,
              bottomPadding: 0,
              rightPadding: 0,
              backgroundColor: AppColors.black,
              textStyle: AppTextstyles.neutra500white22.copyWith(fontSize: 14),
              onPressed: () {
                ref
                    .read(trafficTradeFormControllerProvider.notifier)
                    .addNearbySite();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SiteFormCard extends ConsumerWidget {
  final int index;
  const _SiteFormCard({
    super.key,
    required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final site = ref.watch(
      trafficTradeFormControllerProvider.select(
        (s) => s.nearbyTrafficSites.length > index 
            ? s.nearbyTrafficSites[index] 
            : null,
      ),
    );
    
    // If site is null (index out of bounds), don't render
    if (site == null) {
      return const SizedBox.shrink();
    }
    
    final sitesLength = ref
        .read(trafficTradeFormControllerProvider)
        .nearbyTrafficSites
        .length;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Site ${index + 1}",
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 24,
                    color: AppColors.black2Color,
                  ),
                ),
              ),
              actionContainer(
                icon: AppImages.deleteIconSvg,
                iconColor: sitesLength <= 1
                    ? AppColors.grey
                    : AppColors.emailUsIconColor,
                backgroundColor: sitesLength <= 1
                    ? AppColors.actionContainerColor
                    : AppColors.emailUsIconColor.withOpacity(0.1),
                onTap: () {
                  if (sitesLength <= 1) return;
                  ref
                      .read(trafficTradeFormControllerProvider.notifier)
                      .removeNearbySite(index);
                },
              ),
            ],
          ),
          // site name textfield
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Site Name",
            hintText: "Enter site name",
            controller: site.siteNameController,
          ),
          // daily diesel sales textfield
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Estimated Daily Diesel Sale",
            hintText: "Enter daily diesel sale",
            keyboardType: TextInputType.number,
            controller: site.estimatedDailyDieselSaleController,
          ),
          // daily super sales textfield
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Estimated Daily Super Sale",
            hintText: "Enter daily super sale",
            keyboardType: TextInputType.number,
            controller: site.estimatedDailySuperSaleController,
          ),
          // daily lubricant sales textfield
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Estimated Lubricant Sale",
            hintText: "Enter daily lubricant sale",
            keyboardType: TextInputType.number,
            controller: site.estimatedDailyLubricantSaleController,
          ),
          // omc name textfield
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "OMC Name",
            hintText: "Enter OMC name",
            controller: site.omcNameController,
          ),
          // is nfr facility dropdown yes no
          const SizedBox(height: 10),
          CustomDropDownWithTitle(
            title: "Is NFR Facility Available?",
            hintText: "Select an option",
            selectedItem: site.isNfrFacility,
            items: ref.read(yesNoValuesProvider),
            onChanged: (value) {
              if (value == null) return;
              ref
                  .read(trafficTradeFormControllerProvider.notifier)
                  .onChangeIsNfrFacilityAvailable(index, value.toString());
            },
          ),
          // select nfr facilities (dropdown with multiselect true)
          const SizedBox(height: 10),
          CustomDropDownWithTitle(
            title: "Select NFR Facilities",
            hintText: "Select nfr facilities",
            isMultiSelect: true,
            selectedItems: site.nfrFacilities,
            items: ref.read(nfrFacilitiesProvider),
            onMultiChanged: (values) {
              ref
                  .read(trafficTradeFormControllerProvider.notifier)
                  .onChangeNfrFacilities(index, values);
            },
          ),
        ],
      ),
    );
  }
}
