import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/nullable_fields_helper.dart';

final volumeFinancialControllerProvider =
    NotifierProvider<VolumeFinancialController, VolumeFinancialState>(
      VolumeFinancialController.new,
    );

class VolumeFinancialState {
  final String? dailyDieselSales;
  final String? dailySuperSales;
  final String? dailyHOBCSales;
  final String? dailyLubricantSales;
  final String? rentExpectation;
  final String? truckPortPotential;
  final String? salamMartPotential;
  final String? restaurantPotential;

  const VolumeFinancialState({
    this.dailyDieselSales,
    this.dailySuperSales,
    this.dailyHOBCSales,
    this.dailyLubricantSales,
    this.rentExpectation,
    this.truckPortPotential,
    this.salamMartPotential,
    this.restaurantPotential,
  });

  VolumeFinancialState copyWith({
    String? dailyDieselSales,
    String? dailySuperSales,
    String? dailyHOBCSales,
    String? dailyLubricantSales,
    String? rentExpectation,
    String? truckPortPotential,
    String? salamMartPotential,
    String? restaurantPotential,
    List<String>? fieldsToNull,
  }) {
    return VolumeFinancialState(
      dailyDieselSales: fieldsToNull.apply("dailyDieselSales", dailyDieselSales, this.dailyDieselSales),
      dailySuperSales: fieldsToNull.apply("dailySuperSales", dailySuperSales, this.dailySuperSales),
      dailyHOBCSales: fieldsToNull.apply("dailyHOBCSales", dailyHOBCSales, this.dailyHOBCSales),
      dailyLubricantSales: fieldsToNull.apply("dailyLubricantSales", dailyLubricantSales, this.dailyLubricantSales),
      rentExpectation: fieldsToNull.apply("rentExpectation", rentExpectation, this.rentExpectation),
      truckPortPotential: fieldsToNull.apply("truckPortPotential", truckPortPotential, this.truckPortPotential),
      salamMartPotential: fieldsToNull.apply("salamMartPotential", salamMartPotential, this.salamMartPotential),
      restaurantPotential: fieldsToNull.apply("restaurantPotential", restaurantPotential, this.restaurantPotential),
    );
  }

  @override
  String toString() {
    return 'VolumeFinancialState(dailyDieselSales: $dailyDieselSales, dailySuperSales: $dailySuperSales, dailyHOBCSales: $dailyHOBCSales, dailyLubricantSales: $dailyLubricantSales, rentExpectation: $rentExpectation, truckPortPotential: $truckPortPotential, salamMartPotential: $salamMartPotential, restaurantPotential: $restaurantPotential)';
  }
}

class VolumeFinancialController extends Notifier<VolumeFinancialState> {
  @override
  VolumeFinancialState build() {
    return const VolumeFinancialState();
  }

  void updateDailyDieselSales(String value) {
    state = state.copyWith(dailyDieselSales: value);
  }

  void updateDailySuperSales(String value) {
    state = state.copyWith(dailySuperSales: value);
  }

  void updateDailyHOBCSales(String value) {
    state = state.copyWith(dailyHOBCSales: value);
  }

  void updateDailyLubricantSales(String value) {
    state = state.copyWith(dailyLubricantSales: value);
  }

  void updateRentExpectation(String value) {
    state = state.copyWith(rentExpectation: value);
  }

  void setTruckPortPotential(String value) {
    state = state.copyWith(truckPortPotential: value);
  }

  void setSalamMartPotential(String value) {
    state = state.copyWith(salamMartPotential: value);
  }

  void setRestaurantPotential(String value) {
    state = state.copyWith(restaurantPotential: value);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }

  void prefillFormData({
    required String dailyDieselSales,
    required String dailySuperSales,
    required String dailyHOBCSales,
    required String dailyLubricantSales,
    required String rentExpectation,
    required String truckPortPotential,
    required String salamMartPotential,
    required String restaurantPotential,
  }) {
    state = state.copyWith(
      dailyDieselSales: dailyDieselSales,
      dailySuperSales: dailySuperSales,
      dailyHOBCSales: dailyHOBCSales,
      dailyLubricantSales: dailyLubricantSales,
      rentExpectation: rentExpectation,
      truckPortPotential: truckPortPotential,
      salamMartPotential: salamMartPotential,
      restaurantPotential: restaurantPotential,
    );
  }
}
