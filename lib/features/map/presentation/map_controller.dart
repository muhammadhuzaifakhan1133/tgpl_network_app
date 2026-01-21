import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/common/models/application_model.dart';
import 'package:tgpl_network/features/master_data/providers/application_provider.dart';
import 'package:tgpl_network/features/map/presentation/widgets/site_marker_widget.dart';
import 'package:tgpl_network/utils/get_application_status_color.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

final isMapLoadedProvider = StateProvider<bool>((ref) => false);

final selectedSiteProvider = StateProvider<ApplicationModel?>((ref) => null);

final mapMarkersProvider =
    AsyncNotifierProvider<MapMarkersController, List<Marker>>(() {
  return MapMarkersController();
});

class MapMarkersController extends AsyncNotifier<List<Marker>> {
  final _markerCache = <String, BitmapDescriptor>{};

  @override
  Future<List<Marker>> build() async {
    return _generateMarkers();
  }

  Future<List<Marker>> _generateMarkers() async {
    final apps = ref.read(applicationsProvider);
    final List<Marker> markers = [];
    for (final app in apps) {
      final marker = Marker(
        markerId: MarkerId(app.id.toString()),
        position: LatLng(app.latitude, app.longitude),
        icon: await _getMarker(
          color: getApplicationStatusColor(app.statusId),
          label: app.siteName,
        ),
        onTap: () => ref.read(selectedSiteProvider.notifier).state = app,
      );
      markers.add(marker);
    }
    return markers;
  }

  Future<BitmapDescriptor> _getMarker({
    required color,
    required String label,
  }) async {
    final key = '${color.value}_$label';
    if (_markerCache.containsKey(key)) return _markerCache[key]!;

    final bitmap = await SiteMapMarker(color: color, label: label).toBitmapDescriptor();
    _markerCache[key] = bitmap;
    return bitmap;
  }
}
