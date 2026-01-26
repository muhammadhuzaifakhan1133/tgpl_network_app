import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/src/framework.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/map/presentation/map_controller.dart';
import 'package:tgpl_network/features/map/presentation/widgets/map_skeleton.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/statuses_provider.dart';
import 'package:tgpl_network/utils/get_application_status_color.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _getCurrentLocation();
  //   });
  // }

  // Future<void> _getCurrentLocation() async {
  //   ref.read(locationActionProvider.notifier).state =
  //   const AsyncLoading();

  //   final locationService = ref.read(locationServiceProvider);
  //   final position = await locationService.getCurrentLocation();

  //   if (position != null) {
  //     ref.read(currentLocationProvider.notifier).state = position;

  //     // Add current location marker
  //     final markers = ref.read(markersProvider.notifier);
  //     markers.state = {
  //       ...markers.state,
  //       Marker(
  //         markerId: MarkerId(AppKeys.currentMarkerId),
  //         position: position,
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //         infoWindow: const InfoWindow(title: 'Your Location'),
  //       ),
  //     };

  //     // Move camera to current location
  //     final mapController = ref.read(mapControllerProvider);
  //     mapController?.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: position, zoom: 15),
  //       ),
  //     );
  //   } else {
  //     if (context.mounted) {
  //       showSnackBar(context, 'Failed to get location. Please check permissions.');
  //     }
  //   }

  //   ref.read(locationActionProvider.notifier).state =
  //   const AsyncData(null);
  // }

  @override
  Widget build(BuildContext context) {
    final markersAsync = ref.watch(mapMarkersProvider);
    final selectedApplication = ref.watch(selectedSiteProvider);
    // final isMapLoaded = ref.watch(isMapLoadedProvider);
    final citiesAsync = ref.watch(cityNamesProvider);
    final selectedCity = ref.watch(selectedCityProvider);

    if (markersAsync.isLoading) {
      return const MapSkeleton();
    }
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
            // ref.read(isMapLoadedProvider.notifier).state = true;
          },
          markers: markersAsync.when(
            data: (markers) => Set<Marker>.from(markers),
            loading: () => {},
            error: (_, __) => {},
          ),
          onTap: (_) => ref.read(selectedSiteProvider.notifier).state = null,
        ),
        // City Dropdown
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: citiesAsync.when(
            data: (cities) {
              return CustomDropDown(
                items: cities,
                backgroundColor: AppColors.white,
                displayString: (item) => item.name,
                selectedItem: selectedCity,
                hintText: 'Select City',
                onChanged: (city) {
                  ref.read(selectedCityProvider.notifier).state = city;
                },
              );
            },
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ),
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

class _SelectedApplicationCard extends ConsumerWidget {
  final ApplicationModel application;
  const _SelectedApplicationCard({required this.application});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                "${application.entryCode}",
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: getApplicationStatusColor(
                    application.statusId ?? 18,
                  ).withOpacity(0.08),
                ),
                child: Text(
                  getStatusById(
                    application.statusId ?? 18,
                    ref.read(statusesProvider),
                  ),
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 12,
                    color: getApplicationStatusColor(
                      application.statusId ?? 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            application.dealerName ?? "N/A",
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
                  application.locationAddress ?? "N/A",
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
