import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/features/map/presentation/widgets/site_marker_widget.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/utils/get_application_status_color.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

// final isMapLoadedProvider = StateProvider<bool>((ref) => false);

final selectedSiteProvider = StateProvider<ApplicationModel?>((ref) => null);

// Selected city provider
final selectedCityProvider = StateProvider<CityModel?>((ref) => null);

final mapMarkersProvider =
    AsyncNotifierProvider<MapMarkersController, List<Marker>>(() {
  return MapMarkersController();
});

class MapMarkersController extends AsyncNotifier<List<Marker>> {
  final Map<String, BitmapDescriptor> _markerCache = {};

  @override
  Future<List<Marker>> build() async {
    // Watch for city changes - rebuilds when city changes
    final cities = await ref.watch(cityNamesProvider.future);
    final selectedCity = ref.watch(selectedCityProvider);
    if (selectedCity == null && cities.isNotEmpty) {
      // If no city selected, default to first city
      ref.read(selectedCityProvider.notifier).state = cities.first;
    }
    
    return _generateMarkers(cityId: selectedCity!.cityId.toString());
  }

  Future<List<Marker>> _generateMarkers({required String cityId}) async {
    final masterDataSource = ref.read(masterDataLocalDataSourceProvider);
    final apps = await masterDataSource.getApplicationsForMap(cityId: cityId);
    
    debugPrint('Generating markers for ${apps.length} applications in city: $cityId');

    final List<Marker> markers = [];
    
    // Process in batches to avoid blocking UI
    const batchSize = 100;
    for (int i = 0; i < apps.length; i += batchSize) {
      final end = (i + batchSize < apps.length) ? i + batchSize : apps.length;
      final batch = apps.sublist(i, end);
      
      for (final app in batch) {
        final color = getApplicationStatusColor(app.statusId ?? 18);
        final key = '${color.value}_${app.entryCode}';
        
        // Check cache first
        BitmapDescriptor icon;
        if (_markerCache.containsKey(key)) {
          icon = _markerCache[key]!;
        } else {
          icon = await SiteMapMarker(
            color: color,
            label: app.entryCode.toString(),
          ).toBitmapDescriptor();
          _markerCache[key] = icon;
        }
        
        markers.add(
          Marker(
            markerId: MarkerId(app.applicationId.toString()),
            position: LatLng(app.latitude, app.longitude),
            icon: icon,
            onTap: () {
              ref.read(selectedSiteProvider.notifier).state = app;
            },
          ),
        );
      }
      
      // Yield to UI thread between batches
      await Future.delayed(Duration.zero);
      debugPrint('Generated ${markers.length}/${apps.length} markers');
    }

    return markers;
  }
}