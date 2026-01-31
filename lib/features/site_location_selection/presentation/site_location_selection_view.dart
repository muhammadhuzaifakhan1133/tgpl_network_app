import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_keys.dart';
import 'package:tgpl_network/features/site_location_selection/data/location_service.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/widgets/selected_location_card.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class SiteLocationSelectionView extends ConsumerStatefulWidget {
  final LatLng? initialPosition;

  const SiteLocationSelectionView({super.key, this.initialPosition});

  @override
  ConsumerState<SiteLocationSelectionView> createState() =>
      _SiteLocationSelectionViewState();
}

class _SiteLocationSelectionViewState
    extends ConsumerState<SiteLocationSelectionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If initial position is provided, set it as selected
      ref.read(markersProvider.notifier).state = {};
      if (widget.initialPosition != null) {
        _onMapTapped(widget.initialPosition!);
      } else {
        _getCurrentLocation();
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    ref.read(locationActionProvider.notifier).state = const AsyncLoading();

    final locationService = ref.read(locationServiceProvider);
    final position = await locationService.getCurrentLocation();

    if (position != null) {
      ref.read(currentLocationProvider.notifier).state = position;

      // Add current location marker
      // final markers = ref.read(markersProvider);
      // final updatedMarkers = markers
      //     .where((m) => m.markerId.value != AppKeys.currentMarkerId)
      //     .toSet();
      // updatedMarkers.add(
      //   Marker(
      //     markerId: MarkerId(AppKeys.currentMarkerId),
      //     position: position,
      //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      //     infoWindow: const InfoWindow(title: 'Your Location'),
      //   ),
      // );
      // ref.read(markersProvider.notifier).state = updatedMarkers;
      // Move camera to current location
      final mapController = ref.read(mapControllerProvider);
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 15),
        ),
      );
    } else {
      if (context.mounted) {
        showSnackBar(
          context,
          'Failed to get location. Please check permissions.',
        );
      }
    }

    ref.read(locationActionProvider.notifier).state = const AsyncData(null);
  }

  Future<void> _onMapTapped(LatLng position) async {
    ref.read(locationActionProvider.notifier).state = const AsyncLoading();

    final locationService = ref.read(locationServiceProvider);
    final address = await locationService.getAddressFromCoordinates(position);

    // Update selected location
    ref.read(selectedLocationProvider.notifier).state = LocationData(
      position: position,
      address: address,
    );

    // Update markers
    final currentMarkers = ref.read(markersProvider);
    final updatedMarkers = currentMarkers
        .where((m) => m.markerId.value != AppKeys.selectedMarkerId)
        .toSet();

    updatedMarkers.add(
      Marker(
        markerId: MarkerId(AppKeys.selectedMarkerId),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: address ?? 'Loading...',
        ),
      ),
    );

    ref.read(markersProvider.notifier).state = updatedMarkers;
    ref.read(locationActionProvider.notifier).state = const AsyncData(null);
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(currentLocationProvider);
    final selectedLocation = ref.watch(selectedLocationProvider);
    final markers = ref.watch(markersProvider);
    ref.watch(mapControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Select Site Location'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
            tooltip: 'Go to my location',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: (controller) {
              ref.read(mapControllerProvider.notifier).state = controller;
              if (widget.initialPosition != null) {
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(target: widget.initialPosition!, zoom: 15),
                  ),
                );
              }
            },
            initialCameraPosition: CameraPosition(
              target: currentPosition ?? const LatLng(24.8607, 67.0011),
              zoom: 12,
            ),
            markers: markers,
            onTap: _onMapTapped,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.satellite,
            // zoomControlsEnabled: false,
          ),

          // Location details card
          if (selectedLocation != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: 1,
                child: SelectedLocationCard(
                  locationData: selectedLocation,
                  onClose: () {
                    ref.read(selectedLocationProvider.notifier).state = null;
                    final currentMarkers = ref.read(markersProvider);
                    ref.read(markersProvider.notifier).state = currentMarkers
                        .where(
                          (m) => m.markerId.value != AppKeys.selectedMarkerId,
                        )
                        .toSet();
                  },
                  onConfirm: () {
                    showSnackBar(context, 'Location selected successfully!');
                    ref.read(goRouterProvider).pop(selectedLocation);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
