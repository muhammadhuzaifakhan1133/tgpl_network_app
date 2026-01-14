import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_site_model.dart';

final trafficTradeFormControllerProvider =
    NotifierProvider<TrafficTradeFormController, TrafficTradeFormState>(
      () => TrafficTradeFormController(),
    );

class TrafficTradeFormState {
  List<TrafficSiteModel> nearbyTrafficSites = [TrafficSiteModel()];
  String? truckPortPotential;
  String? salamMartPotential;
  String? resturantPotential;
  String? selectedTm;
  String? selectedRm;
  String? selectedTMRecommendation;
  String? selectedRMRecommendation;

  TrafficTradeFormState({
    this.nearbyTrafficSites = const [],
    this.truckPortPotential,
    this.salamMartPotential,
    this.resturantPotential,
    this.selectedTm,
    this.selectedRm,
    this.selectedTMRecommendation,
    this.selectedRMRecommendation,
  }) {
    if (nearbyTrafficSites.isEmpty) {
      nearbyTrafficSites = [TrafficSiteModel()];
    }
  }

  TrafficTradeFormState copyWith({
    List<TrafficSiteModel>? nearbyTrafficSites,
    String? truckPortPotential,
    String? salamMartPotential,
    String? resturantPotential,
    String? selectedTm,
    String? selectedRm,
    String? selectedTMRecommendation,
    String? selectedRMRecommendation,
  }) {
    return TrafficTradeFormState(
      nearbyTrafficSites: nearbyTrafficSites ?? this.nearbyTrafficSites,
      truckPortPotential: truckPortPotential ?? this.truckPortPotential,
      salamMartPotential: salamMartPotential ?? this.salamMartPotential,
      resturantPotential: resturantPotential ?? this.resturantPotential,
      selectedTm: selectedTm ?? this.selectedTm,
      selectedRm: selectedRm ?? this.selectedRm,
      selectedTMRecommendation:
          selectedTMRecommendation ?? this.selectedTMRecommendation,
      selectedRMRecommendation:
          selectedRMRecommendation ?? this.selectedRMRecommendation,
    );
  }
}

class TrafficTradeFormController extends Notifier<TrafficTradeFormState> {
  final formKey = GlobalKey<FormState>();
  TextEditingController trafficCountTruckController = TextEditingController();
  TextEditingController trafficCountCarController = TextEditingController();
  TextEditingController trafficCountBikeController = TextEditingController();
  TextEditingController dailyDieselSalesController = TextEditingController();
  TextEditingController dailySuperSalesController = TextEditingController();
  TextEditingController dailyHOBCSalesController = TextEditingController();
  TextEditingController dailyLubricantSalesController = TextEditingController();
  TextEditingController rentExpectationController = TextEditingController();
  TextEditingController tmRemarksController = TextEditingController();
  TextEditingController rmRemarksController = TextEditingController();
  

  @override
  TrafficTradeFormState build() {
    return TrafficTradeFormState();
  }

  void onChangeIsNfrFacilityAvailable(int index, String value) {
    final updatedSites = [...state.nearbyTrafficSites];
    updatedSites[index] = updatedSites[index].copyWith(isNfrFacility: value);
    state = state.copyWith(nearbyTrafficSites: updatedSites);
  }

  void onChangeNfrFacilities(int siteIndex, List<String> values) {
    final updatedSites = [...state.nearbyTrafficSites];
    updatedSites[siteIndex] =
        updatedSites[siteIndex].copyWith(nfrFacilities: values);
    state = state.copyWith(nearbyTrafficSites: updatedSites);
  }

  void removeNearbySite(int index) {
    final updatedSites = [...state.nearbyTrafficSites];
    if (index >= 0 && index < updatedSites.length) {
      updatedSites.removeAt(index);
      state = state.copyWith(nearbyTrafficSites: updatedSites);
    }
  }

  void addNearbySite() {
    final updatedSites = [...state.nearbyTrafficSites, TrafficSiteModel()];
    state = state.copyWith(nearbyTrafficSites: updatedSites);
  }

  void setTruckPortPotential(String? value) {
    state = state.copyWith(truckPortPotential: value);
  }

  void setSalamMartPotential(String? value) {
    state = state.copyWith(salamMartPotential: value);
  }

  void setResturantPotential(String? value) {
    state = state.copyWith(resturantPotential: value);
  }

  void onChangeTM(String value) {
    state = state.copyWith(selectedTm: value);
  }

  void onChangeRM(String value) {
    state = state.copyWith(selectedRm: value);
  }

  void onChangeTMRecommendation(String value) {
    state = state.copyWith(selectedTMRecommendation: value);
  }

  void onChangeRMRecommendation(String value) {
    state = state.copyWith(selectedRMRecommendation: value);
  }
}
