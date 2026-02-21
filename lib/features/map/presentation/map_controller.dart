import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/common/providers/statuses_provider.dart';
import 'package:tgpl_network/features/map/data/map_data_source.dart';
import 'package:tgpl_network/features/map/presentation/widgets/site_marker_widget.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

// final isMapLoadedProvider = StateProvider<bool>((ref) => false);

final selectedSiteProvider = StateProvider<ApplicationModel?>((ref) => null);

// Selected city provider
final selectedCityForMapProvider = StateProvider<CityModel?>((ref) => null);

final selectedStatusForMapProvider = StateProvider<AppStatusCategory?>(
  (ref) => null,
);

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
    AppStatusCategory? selectedStatus = ref.watch(selectedStatusForMapProvider);

    if (selectedCity != null && selectedStatus != null) {
      // Increment operation ID to cancel previous operations
      _currentOperationId++;

      return _generateMarkers(
        selectedCity: selectedCity,
        selectedStatus: selectedStatus,
        operationId: _currentOperationId,
      );
    }
    return [];
  }

  Future<List<Marker>> _generateMarkers({
    required CityModel selectedCity,
    required AppStatusCategory selectedStatus,
    required int operationId,
  }) async {
    final mapDataSource = ref.read(mapDataSourceProvider);

    // Check if cancelled before fetching
    if (operationId != _currentOperationId) {
      debugPrint('Operation $operationId cancelled before fetching apps');
      return [];
    }

    final apps = await mapDataSource.getApplicationsForMap(
      city: selectedCity,
      status: selectedStatus,
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
      'Generating markers for ${apps.length} applications in city: ${selectedCity.name}',
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

        final color = AppStatusCategory.getColorForStatusId(app.statusId ?? 18);
        String key = '${color.value}_${app.entryCode}';

        if (selectedCity.isAll ||
            selectedStatus.type == AppStatusCategoryType.all) {
          key = '${color.value}';
          if (!_markerCache.containsKey(key)) {
            _markerCache[key] = await SiteMapMarker(
              color: color,
              label: "",
            ).toBitmapDescriptor();
          }
        }

        BitmapDescriptor icon;
        // Check cache first
        if (_markerCache.containsKey(key)) {
          icon = _markerCache[key]!;
        } else {
          icon = await SiteMapMarker(
            color: color,
            label:
                app.proposedSiteName1 ??
                app.entryCode ??
                app.applicationId.toString(),
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

  void onChangeStatus(AppStatusCategory? status) {
    ref.read(selectedSiteProvider.notifier).state = null;
    ref.read(markerGenerationProgressProvider.notifier).state = null;
    ref.read(selectedStatusForMapProvider.notifier).state = status;
  }
}
