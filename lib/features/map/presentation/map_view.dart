import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(24.8243808, 67.041284),
        ),
      ),
    );
  }
}
