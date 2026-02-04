import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/map/data/map_data_source.dart';
import 'package:tgpl_network/features/map/presentation/widgets/site_marker_widget.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

// final isMapLoadedProvider = StateProvider<bool>((ref) => false);

final selectedSiteProvider = StateProvider<ApplicationModel?>((ref) => null);

// Selected city provider
final selectedCityForMapProvider = StateProvider<CityModel?>((ref) => null);

final selectedStatusForMapProvider = StateProvider<String?>((ref) => null);

final markerGenerationProgressProvider = StateProvider<double?>((ref) => null);

final mapMarkersProvider =
    AsyncNotifierProvider<MapMarkersController, List<Marker>>(() {
      return MapMarkersController();
    });

class MapMarkersController extends AsyncNotifier<List<Marker>> {
  final Map<String, BitmapDescriptor> _markerCache = {};
  int _currentOperationId = 0; // Track operation ID

  @override
  Future<List<Marker>> build() async {
    // Watch for city changes - rebuilds when city changes;
    CityModel? selectedCity = ref.watch(selectedCityForMapProvider);
    String? selectedStatus = ref.watch(selectedStatusForMapProvider);

    if (selectedCity != null && selectedStatus != null) {
      // Increment operation ID to cancel previous operations
      _currentOperationId++;

      return _generateMarkers(
        cityName: selectedCity.name.toString(),
        statusId: selectedStatus,
        operationId: _currentOperationId,
      );
    }
    return [];
  }

  Future<List<Marker>> _generateMarkers({
    required String cityName,
    required String statusId,
    required int operationId,
  }) async {
    final mapDataSource = ref.read(mapDataSourceProvider);

    // Check if cancelled before fetching
    if (operationId != _currentOperationId) {
      debugPrint('Operation $operationId cancelled before fetching apps');
      return [];
    }

    final apps = await mapDataSource.getApplicationsForMap(
      cityName: cityName,
      statusId: statusId,
    );

    // Check if cancelled after fetching
    if (operationId != _currentOperationId) {
      debugPrint(
        'Operation $operationId cancelled after fetching ${apps.length} apps',
      );
      return [];
    }

    ref.read(markerGenerationProgressProvider.notifier).state = 0;
    debugPrint(
      'Generating markers for ${apps.length} applications in city: $cityName',
    );

    final List<Marker> markers = [];

    // Process in batches to avoid blocking UI
    const batchSize = 100;
    for (int i = 0; i < apps.length; i += batchSize) {
      // Check cancellation at start of each batch
      if (operationId != _currentOperationId) {
        debugPrint(
          'Operation $operationId cancelled at batch ${i ~/ batchSize}',
        );
        ref.read(markerGenerationProgressProvider.notifier).state = null;
        return [];
      }

      final end = (i + batchSize < apps.length) ? i + batchSize : apps.length;
      final batch = apps.sublist(i, end);

      for (final app in batch) {
        // Check cancellation periodically during marker generation
        if (operationId != _currentOperationId) {
          debugPrint(
            'Operation $operationId cancelled during marker generation',
          );
          ref.read(markerGenerationProgressProvider.notifier).state = null;
          return [];
        }

        final color = AppColors.getApplicationStatusColor(app.statusId ?? 18);
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
      // Update progress
      ref.read(markerGenerationProgressProvider.notifier).state =
          (markers.length / apps.length);
      }


      // Yield to UI thread between batches
      await Future.delayed(Duration.zero);
      debugPrint('Generated ${markers.length}/${apps.length} markers');
    }

    // Clear progress indicator on completion
    ref.read(markerGenerationProgressProvider.notifier).state = null;

    return markers;
  }

  void onChangeCity(CityModel city) {
    ref.read(selectedSiteProvider.notifier).state = null;
    ref.read(markerGenerationProgressProvider.notifier).state = null;
    ref.read(selectedCityForMapProvider.notifier).state = city;
  }

  void onChangeStatus(String? status) {
    ref.read(selectedSiteProvider.notifier).state = null;
    ref.read(markerGenerationProgressProvider.notifier).state = null;
    ref.read(selectedStatusForMapProvider.notifier).state = status;
  }
}
