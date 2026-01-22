import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/map/presentation/map_controller.dart';
import 'package:tgpl_network/features/master_data/providers/applications_provider.dart';
import 'package:tgpl_network/utils/get_application_category_color.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markersAsync = ref.watch(mapMarkersProvider);
    final selectedApplication = ref.watch(selectedSiteProvider);
    final isMapLoaded = ref.watch(isMapLoadedProvider);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(24.8243808, 67.041284),
            zoom: 13,
          ),
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (controller) async {
            await Future.delayed(const Duration(milliseconds: 300));
            ref.read(isMapLoadedProvider.notifier).state = true;
          },
          markers: markersAsync.when(
            data: (markers) => Set<Marker>.from(markers),
            loading: () => {},
            error: (_, __) => {},
          ),
          onTap: (_) => ref.read(selectedSiteProvider.notifier).state = null,
        ),
        if (!isMapLoaded)
          const Positioned.fill(child: _MapSkeleton()),
        if (selectedApplication != null)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: _SelectedApplicationCard(application: selectedApplication),
          ),
      ],
    );
  }
}

class _MapSkeleton extends StatelessWidget {
  const _MapSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey.shade200,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}


class _SelectedApplicationCard extends StatelessWidget {
  final ApplicationLegacyModel application;
  const _SelectedApplicationCard({required this.application});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${application.id} (${application.siteName})",
                style: AppTextstyles.googleInter400Grey14.copyWith(fontSize: 12),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: getApplicationCategoryColor(application.category)
                      .withOpacity(0.08),
                ),
                child: Text(
                  application.category,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 12,
                    color: getApplicationCategoryColor(application.category),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            application.applicantName,
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 20,
              color: AppColors.black2Color,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  application.address,
                  style: AppTextstyles.googleInter400Grey14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: "Directions",
                  leftPadding: 0,
                  rightPadding: 0,
                  height: 41,
                  backgroundColor: AppColors.actionContainerColor,
                  textStyle: AppTextstyles.googleInter500LabelColor14.copyWith(
                    color: AppColors.black2Color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: "View Details",
                  leftPadding: 0,
                  rightPadding: 0,
                  height: 41,
                  backgroundColor: AppColors.nextStep1Color,
                  textStyle: AppTextstyles.googleInter500LabelColor14.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
