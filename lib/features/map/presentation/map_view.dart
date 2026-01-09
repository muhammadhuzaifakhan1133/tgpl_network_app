import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/common/models/application_model.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/map/presentation/map_controller.dart';
import 'package:tgpl_network/utils/get_application_category_color.dart';
import 'package:tgpl_network/utils/screen_size_extension.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(24.8243808, 67.041284),
            zoom: 13,
          ),
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onTap: (_) {
            ref.read(selectedSiteProvider.notifier).state = null;
          },
          onMapCreated: (GoogleMapController googleMapController) async {
            await Future.delayed(const Duration(milliseconds: 300));
            ref.read(isMapLoadedProvider.notifier).state = true;
          },
          markers: Set<Marker>.of(
            ref
                .watch(mapControllerProvider)
                .when<List<Marker>>(
                  data: (markers) => markers,
                  error: (_, _) => [],
                  loading: () => [],
                ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final isMapLoaded = ref.watch(isMapLoadedProvider);
            if (isMapLoaded) {
              return SizedBox.shrink();
            } else {
              return Positioned.fill(child: _MapSkeleton());
            }
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final application = ref.watch(selectedSiteProvider);
            if (application == null) {
              return SizedBox.shrink();
            } else {
              return Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: AnimatedSlide(
                  offset: Offset(0, 0),
                  duration: const Duration(milliseconds: 250),
                  child: _selectedApplicationMapCard(context, application),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Container _selectedApplicationMapCard(
    BuildContext context,
    ApplicationModel application,
  ) {
    return Container(
      width: context.screenWidth * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 12,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: getApplicationCategoryColor(
                    application.category,
                  ).withOpacity(0.08),
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
          Text(
            application.applicantName,
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 20,
              color: AppColors.black2Color,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
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
                  leftPadding: 0,
                  rightPadding: 0,
                  height: 41,
                  backgroundColor: AppColors.actionContainerColor,
                  text: "Directions",
                  textStyle: AppTextstyles.googleInter500LabelColor14.copyWith(
                    color: AppColors.black2Color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  backgroundColor: AppColors.nextStep1Color,
                  leftPadding: 0,
                  rightPadding: 0,
                  height: 41,
                  text: "View Details",
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

class _MapSkeleton extends StatelessWidget {
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
