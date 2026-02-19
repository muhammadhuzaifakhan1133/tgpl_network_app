import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_site_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';

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

  NearbySitesState.loadFromApplication(ApplicationModel app)
      : nearbyTrafficSites = app.nearbyTrafficSites.isNotEmpty?app.nearbyTrafficSites.map((site) => TrafficSiteModel(
          id: site.id?.toString(),
          siteName: site.proposedSiteName,
          estimatedDailyDieselSale: site.estimateDailyDieselSale.toString(),
          estimatedDailySuperSale: site.estimateDailySuperSale.toString(),
          estimatedDailyLubricantSale: site.estimateLubricantSale.toString(),
          omcName: site.nfrName,
          isNfrFacility: site.nflFacilityAvailable,
          nfrFacilities: site.nfrFacility?.split(",").map((e) => e.trim()).toList() ?? [],
      )).toList() : [TrafficSiteModel()],
        totalSites = app.nearbyTrafficSites.isNotEmpty ? app.nearbyTrafficSites.length : 1;
  
  NearbySitesState.loadFromTrafficTradeFormModel(TrafficTradeFormModel form)
      : nearbyTrafficSites = form.nearbyTrafficSites,
        totalSites = form.nearbyTrafficSites.length;
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

  void loadFromApplication(ApplicationModel app) {
    state = NearbySitesState.loadFromApplication(app);
  }

  void loadFromTrafficTradeFormModel(TrafficTradeFormModel form) {
    state = NearbySitesState.loadFromTrafficTradeFormModel(form);
  }
}