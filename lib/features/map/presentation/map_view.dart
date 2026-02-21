import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/map/presentation/map_controller.dart';
import 'package:tgpl_network/features/map/presentation/widgets/selected_application_card.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/statuses_provider.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markersAsync = ref.watch(mapMarkersProvider);

    return Stack(
      children: [
        buildGoogleMap(markersAsync, ref),
        // City Dropdown
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Row(
            children: [
              buildCityDropDown(),
              SizedBox(width: 12.w),
              buildStatusDropDown(),
            ],
          ),
        ),
        // Add site count below dropdowns
        Positioned(
          top: 80,
          left: 16,
          child: buildSiteCountContainer(markersAsync),
        ),

        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: buildSelectedApplicationCard(),
        ),
        // linear loading indicator for marker generation (initially when applications are loading, and also when regenerating markers)
        if (markersAsync.isLoading)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: buildLoadingIndicator(),
          ),
      ],
    );
  }

  Consumer buildLoadingIndicator() {
    return Consumer(
      builder: (context, ref, _) {
        return LinearProgressIndicator(
          value: ref.watch(markerGenerationProgressProvider),
        );
      },
    );
  }

  Consumer buildSelectedApplicationCard() {
    return Consumer(
      builder: (context, ref, _) {
        final selectedApplication = ref.watch(selectedSiteProvider);
        if (selectedApplication == null) {
          return SizedBox.shrink();
        }
        return SelectedApplicationCard(application: selectedApplication);
      },
    );
  }

  Consumer buildSiteCountContainer(AsyncValue<List<Marker>> markersAsync) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedCity = ref.watch(selectedCityForMapProvider);
        final selectedStatusId = ref.watch(selectedStatusForMapProvider);
        if (markersAsync.isLoading ||
            selectedCity == null ||
            selectedStatusId == null) {
          return SizedBox.shrink();
        }
        return Consumer(
          builder: (context, ref, _) {
            final selectedStatusId = ref.watch(selectedStatusForMapProvider);
            final markerCount = markersAsync.value?.length ?? 0;
            Color statusColor = selectedStatusId?.color ?? AppColors.labelColor;
            // Get color based on selected status, default to label color
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: statusColor.withOpacity(0.3),
                  width: 1.5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 16.w, color: statusColor),
                  SizedBox(width: 4.w),
                  Text(
                    '$markerCount Site${markerCount == 1 ? '' : 's'}',
                    style: AppTextstyles.googleInter500LabelColor14.copyWith(
                      fontSize: 12.sp,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Expanded buildStatusDropDown() {
    return Expanded(
      child: Consumer(
        builder: (context, ref, _) {
          final statuses = ref.watch(statusesProvider);
          final selectedStatusId = ref.watch(selectedStatusForMapProvider);
          return CustomDropDown<AppStatusCategory>(
            items: statuses,
            displayString: (item) => item.type.displayName,
            backgroundColor: AppColors.white,
            itemTextStyle: (statusEntry) {
              return TextStyle(color: statusEntry.color);
            },
            selectedItem: selectedStatusId,
            hintText: 'Select Status',
            onChanged: (statusEntry) {
              ref
                  .read(mapMarkersProvider.notifier)
                  .onChangeStatus(statusEntry);
            },
          );
        },
      ),
    );
  }

  Expanded buildCityDropDown() {
    return Expanded(
      child: Consumer(
        builder: (context, ref, _) {
          final citiesAsync = ref.watch(cityNamesProvider);
          final selectedCity = ref.watch(selectedCityForMapProvider);
          return CustomDropDown(
            items: citiesAsync.when(
              data: (cities) => [
                const CityModel.all(),
                ...cities,
              ],
              error: (e, s) => [],
              loading: () => [],
            ),
            backgroundColor: AppColors.white,
            displayString: (item) => item.name,
            selectedItem: selectedCity,
            hintText: citiesAsync.isLoading ? 'Loading...' : 'Select City',
            onChanged: (city) {
              ref.read(mapMarkersProvider.notifier).onChangeCity(city);
            },
          );
        },
      ),
    );
  }

  GoogleMap buildGoogleMap(
    AsyncValue<List<Marker>> markersAsync,
    WidgetRef ref,
  ) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(24.8243808, 67.041284),
        zoom: 13,
      ),
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: (controller) async {
        // await Future.delayed(const Duration(milliseconds: 300));
        // ref.read(isMapLoadedProvider.notifier).state = true;
      },
      markers: markersAsync.when(
        data: (markers) => Set<Marker>.from(markers),
        loading: () => {},
        error: (_, __) => {},
      ),
      onTap: (_) => ref.read(selectedSiteProvider.notifier).state = null,
    );
  }
}
