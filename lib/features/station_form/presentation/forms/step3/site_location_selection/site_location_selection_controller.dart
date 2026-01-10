import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Models
class LocationData {
  final LatLng position;
  final String? address;

  LocationData({required this.position, this.address});
}

// Providers
final currentLocationProvider = StateProvider<LatLng?>((ref) => null);

final selectedLocationProvider = StateProvider<LocationData?>((ref) => null);

final markersProvider = StateProvider<Set<Marker>>((ref) => {});

final isLoadingProvider = StateProvider<bool>((ref) => false);

// Location Service
class LocationService {
  Future<LatLng?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      print("First check: $permission");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("Second check: $permission");
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print("Position: $position");
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
          place.postalCode,
        ].where((e) => e != null && e.isNotEmpty).join(', ');
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

final locationServiceProvider = Provider((ref) => LocationService());

// Map Controller Provider
final mapControllerProvider = StateProvider<GoogleMapController?>(
  (ref) => null,
);
