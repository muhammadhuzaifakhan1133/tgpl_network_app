import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/features/master_data/providers/nfr_facilities_provider.dart';
import 'package:tgpl_network/features/master_data/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/nearby_sites/nearby_sites_form_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class NearbySitesFormSection extends ConsumerWidget {
  const NearbySitesFormSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sitesLength = ref.watch(
      nearbySitesControllerProvider.select((s) => s.totalSites),
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
              // Get the actual site to use its unique ID as the key
              // final sites = ref.watch(
              //   nearbySitesControllerProvider.select(
              //     (s) => s.nearbyTrafficSites,
              //   ),
              // );

              if (index >= sitesLength) {
                return const SizedBox.shrink();
              }

              final id = ref
                  .read(nearbySitesControllerProvider)
                  .nearbyTrafficSites[index]
                  .id;

              return _SiteFormCard(
                key: ValueKey(id),
                index: index,
                onRemove: sitesLength > 1
                    ? () {
                        ref
                            .read(nearbySitesControllerProvider.notifier)
                            .removeNearbySite(index);
                      }
                    : null,
              );
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
  final VoidCallback? onRemove;
  const _SiteFormCard({super.key, required this.index, required this.onRemove});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(nearbySitesControllerProvider);
    final site = state.nearbyTrafficSites.length > index
        ? state.nearbyTrafficSites[index]
        : null;
    final sitesLength = state.totalSites;
    final controller = ref.read(nearbySitesControllerProvider.notifier);

    // If site is null (index out of bounds), don't render
    if (site == null || index >= sitesLength) {
      return const SizedBox.shrink();
    }

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
                onTap: onRemove,
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('site_name_${site.id}'),
            title: "Site Name",
            hintText: "Enter site name",
            isRequired: true,
            validator: (v) => v.validate(),
            initialValue: site.siteName,
            onChanged: (value) {
              controller.updateSite(index: index, siteName: value);
            },
            showClearButton: true,
            onClear: () {
              controller.clearField('siteName', index: index);
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('diesel_sale_${site.id}'),
            title: "Estimated Daily Diesel Sale",
            hintText: "Enter daily diesel sale",
            keyboardType: TextInputType.number,
            isRequired: true,
            validator: (v) => v.validate(),
            initialValue: site.estimatedDailyDieselSale,
            onChanged: (value) {
              controller.updateSite(
                index: index,
                estimatedDailyDieselSale: value,
              );
            },
            showClearButton: true,
            onClear: () {
              controller.clearField('estimatedDailyDieselSale', index: index);
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('super_sale_${site.id}'),
            title: "Estimated Daily Super Sale",
            hintText: "Enter daily super sale",
            keyboardType: TextInputType.number,
            isRequired: true,
            validator: (v) => v.validate(),
            initialValue: site.estimatedDailySuperSale,
            onChanged: (value) {
              controller.updateSite(
                index: index,
                estimatedDailySuperSale: value,
              );
            },
            showClearButton: true,
            onClear: () {
              controller.clearField('estimatedDailySuperSale', index: index);
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('lubricant_sale_${site.id}'),
            title: "Estimated Lubricant Sale",
            hintText: "Enter daily lubricant sale",
            isRequired: true,
            validator: (v) => v.validate(),
            keyboardType: TextInputType.number,
            initialValue: site.estimatedDailyLubricantSale,
            onChanged: (value) {
              controller.updateSite(
                index: index,
                estimatedDailyLubricantSale: value,
              );
            },
            showClearButton: true,
            onClear: () {
              controller.clearField(
                'estimatedDailyLubricantSale',
                index: index,
              );
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            key: ValueKey('omc_name_${site.id}'),
            title: "OMC Name",
            hintText: "Enter OMC name",
            initialValue: site.omcName,
            onChanged: (value) {
              controller.updateSite(index: index, omcName: value);
            },
            showClearButton: true,
            onClear: () {
              controller.clearField('omcName', index: index);
            },
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, _) {
              final isNfrFacility = ref.watch(
                nearbySitesControllerProvider.select(
                  (state) => state.nearbyTrafficSites[index].isNfrFacility,
                ),
              );
              return SmartCustomDropDownWithTitle(
                key: ValueKey('nfr_facility_${site.id}'),
                title: "Is NFR Facility Available?",
                hintText: "Select an option",
                selectedItem: isNfrFacility,
                asyncProvider: yesNoValuesProvider,
                isRequired: true,
                validator: (v) => v.validate(),
                itemsBuilder: (values) => values,
                onChanged: (value) {
                  if (value == null) return;
                  controller.updateSite(
                    index: index,
                    isNfrFacility: value.toString(),
                  );
                },
                showClearButton: true,
                onClear: () {
                  controller.clearField('isNfrFacility', index: index);
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, _) {
              final nfrFacilities = ref.watch(
                nearbySitesControllerProvider.select(
                  (state) => state.nearbyTrafficSites[index].nfrFacilities,
                ),
              );
              return SmartCustomDropDownWithTitle(
                key: ValueKey('nfr_facilities_list_${site.id}'),
                title: "Select NFR Facilities",
                hintText: "Select nfr facilities",
                isMultiSelect: true,
                selectedItems: nfrFacilities,
                asyncProvider: nfrFacilitiesProvider,
                itemsBuilder: (values) => values,
                onMultiChanged: (values) {
                  controller.updateSite(index: index, nfrFacilities: values);
                },
                showClearButton: true,
                onClear: () {
                  controller.clearField('nfrFacilities', index: index);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
