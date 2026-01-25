import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_site_model.dart';

final nearbySitesControllerProvider =
    NotifierProvider<NearbySitesController, NearbySitesState>(
  NearbySitesController.new,
);

class NearbySitesState {
  final List<TrafficSiteModel> nearbyTrafficSites;
  final int totalSites;

  const NearbySitesState({
    this.nearbyTrafficSites = const [],
    this.totalSites = 0,
  });

  NearbySitesState copyWith({
    List<TrafficSiteModel>? nearbyTrafficSites,
    int? totalSites,
  }) {
    return NearbySitesState(
      nearbyTrafficSites: nearbyTrafficSites ?? this.nearbyTrafficSites,
      totalSites: totalSites ?? this.totalSites,
    );
  }

  @override
  String toString() {
    return 'NearbySitesState(nearbyTrafficSites: $nearbyTrafficSites, totalSites: $totalSites)';
  }
}

class NearbySitesController extends Notifier<NearbySitesState> {
  @override
  NearbySitesState build() {
    // Initialize with one empty site
    return NearbySitesState(
      nearbyTrafficSites: [TrafficSiteModel()],
      totalSites: 1,
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
    state = state.copyWith(nearbyTrafficSites: updatedSites, totalSites: updatedSites.length);
  }

  void removeNearbySite(int index) {
    if (state.nearbyTrafficSites.length <= 1) return; // Keep at least one site

    final updatedSites = [...state.nearbyTrafficSites];
    if (index >= 0 && index < updatedSites.length) {
      updatedSites.removeAt(index);
      state = state.copyWith(nearbyTrafficSites: updatedSites, totalSites: updatedSites.length);
    }
  }

  void clearField(String fieldName, {required int index}) {
    final updatedSites = [...state.nearbyTrafficSites];
    if (index >= 0 && index < updatedSites.length) {
      updatedSites[index] = updatedSites[index].copyWith(
        fieldsToNull: [fieldName],
      );
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