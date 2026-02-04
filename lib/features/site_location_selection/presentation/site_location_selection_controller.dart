import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData {
  final LatLng position;
  final String? address;

  LocationData({required this.position, this.address});
}

// Providers
final currentLocationProvider = StateProvider.autoDispose<LatLng?>(
  (ref) => null,
);

final selectedLocationProvider = StateProvider.autoDispose<LocationData?>(
  (ref) => null,
);

final markersProvider = StateProvider<Set<Marker>>((ref) => {});
final locationActionProvider = StateProvider.autoDispose<AsyncValue<void>>(
  (ref) => const AsyncData(null),
);

// Map Controller Provider
final mapControllerProvider = StateProvider.autoDispose<GoogleMapController?>(
  (ref) => null,
);
