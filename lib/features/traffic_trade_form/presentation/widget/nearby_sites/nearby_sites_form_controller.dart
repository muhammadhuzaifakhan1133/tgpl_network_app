import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_site_model.dart';

final nearbySitesControllerProvider =
    NotifierProvider<NearbySitesController, NearbySitesState>(
  NearbySitesController.new,
);

class NearbySitesState {
  final List<TrafficSiteModel> nearbyTrafficSites;

  const NearbySitesState({
    this.nearbyTrafficSites = const [],
  });

  NearbySitesState copyWith({
    List<TrafficSiteModel>? nearbyTrafficSites,
  }) {
    return NearbySitesState(
      nearbyTrafficSites: nearbyTrafficSites ?? this.nearbyTrafficSites,
    );
  }

  @override
  String toString() {
    return 'NearbySitesState(nearbyTrafficSites: $nearbyTrafficSites)';
  }
}

class NearbySitesController extends Notifier<NearbySitesState> {
  @override
  NearbySitesState build() {
    // Initialize with one empty site
    return NearbySitesState(
      nearbyTrafficSites: [TrafficSiteModel()],
    );
  }

  void updateSite({
    required int index,
    String? siteName,
    String? estimatedDailyDieselSale,
    String? estimatedDailySuperSale,
    String? estimatedDailyLubricantSale,
    String? omcName,
    String? isNfrFacility,
    List<String>? nfrFacilities,
  }) {
    final updatedSites = [...state.nearbyTrafficSites];
    if (index >= 0 && index < updatedSites.length) {
      updatedSites[index] = updatedSites[index].copyWith(
        siteName: siteName,
        estimatedDailyDieselSale: estimatedDailyDieselSale,
        estimatedDailySuperSale: estimatedDailySuperSale,
        estimatedDailyLubricantSale: estimatedDailyLubricantSale,
        omcName: omcName,
        isNfrFacility: isNfrFacility,
        nfrFacilities: nfrFacilities,
      );
      state = state.copyWith(nearbyTrafficSites: updatedSites);
    }
  }

  void addNearbySite() {
    final updatedSites = [...state.nearbyTrafficSites,  TrafficSiteModel()];
    state = state.copyWith(nearbyTrafficSites: updatedSites);
  }

  void removeNearbySite(int index) {
    if (state.nearbyTrafficSites.length <= 1) return; // Keep at least one site

    final updatedSites = [...state.nearbyTrafficSites];
    if (index >= 0 && index < updatedSites.length) {
      updatedSites.removeAt(index);
      state = state.copyWith(nearbyTrafficSites: updatedSites);
    }
  }

  void prefillFormData({required List<TrafficSiteModel> nearbyTrafficSites}) {
    state = state.copyWith(
      nearbyTrafficSites: nearbyTrafficSites.isNotEmpty 
          ? nearbyTrafficSites 
          : [TrafficSiteModel()],
    );
  }
}