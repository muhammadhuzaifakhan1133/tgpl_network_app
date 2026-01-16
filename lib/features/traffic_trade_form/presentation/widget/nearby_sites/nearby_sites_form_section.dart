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
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/nearby_sites/nearby_sites_form_controller.dart';

class NearbySitesFormSection extends ConsumerWidget {
  const NearbySitesFormSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sitesLength = ref.watch(
      nearbySitesControllerProvider.select((s) => s.nearbyTrafficSites.length),
    );

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
              // Use ValueKey with index to ensure Flutter tracks the correct widget
              return _SiteFormCard(key: ValueKey('site_$index'), index: index);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: sitesLength,
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
                    .read(nearbySitesControllerProvider.notifier)
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
  const _SiteFormCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final site = ref.watch(
      nearbySitesControllerProvider.select(
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
        .read(nearbySitesControllerProvider)
        .nearbyTrafficSites
        .length;
    final controller = ref.read(nearbySitesControllerProvider.notifier);

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
                  controller.removeNearbySite(index);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('site_name_$index'),
            title: "Site Name",
            hintText: "Enter site name",
            initialValue: site.siteName,
            onChanged: (value) {
              controller.updateSite(index: index, siteName: value);
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('diesel_sale_$index'),
            title: "Estimated Daily Diesel Sale",
            hintText: "Enter daily diesel sale",
            keyboardType: TextInputType.number,
            initialValue: site.estimatedDailyDieselSale,
            onChanged: (value) {
              controller.updateSite(
                index: index,
                estimatedDailyDieselSale: value,
              );
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('super_sale_$index'),
            title: "Estimated Daily Super Sale",
            hintText: "Enter daily super sale",
            keyboardType: TextInputType.number,
            initialValue: site.estimatedDailySuperSale,
            onChanged: (value) {
              controller.updateSite(
                index: index,
                estimatedDailySuperSale: value,
              );
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('lubricant_sale_$index'),
            title: "Estimated Lubricant Sale",
            hintText: "Enter daily lubricant sale",
            keyboardType: TextInputType.number,
            initialValue: site.estimatedDailyLubricantSale,
            onChanged: (value) {
              controller.updateSite(
                index: index,
                estimatedDailyLubricantSale: value,
              );
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('omc_name_$index'),
            title: "OMC Name",
            hintText: "Enter OMC name",
            initialValue: site.omcName,
            onChanged: (value) {
              controller.updateSite(index: index, omcName: value);
            },
          ),
          const SizedBox(height: 10),
          CustomDropDownWithTitle(
            key: ValueKey('nfr_facility_$index'),
            title: "Is NFR Facility Available?",
            hintText: "Select an option",
            selectedItem: site.isNfrFacility,
            items: ref.read(yesNoValuesProvider),
            onChanged: (value) {
              if (value == null) return;
              controller.updateSite(
                index: index,
                isNfrFacility: value.toString(),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomDropDownWithTitle(
            key: ValueKey('nfr_facilities_list_$index'),
            title: "Select NFR Facilities",
            hintText: "Select nfr facilities",
            isMultiSelect: true,
            selectedItems: site.nfrFacilities,
            items: ref.read(nfrFacilitiesProvider),
            onMultiChanged: (values) {
              controller.updateSite(
                index: index,
                nfrFacilities: values,
              );
            },
          ),
        ],
      ),
    );
  }
}
