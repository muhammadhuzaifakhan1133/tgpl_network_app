import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

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

  VolumeFinancialState.loadFromApplication(ApplicationModel app)
      : dailyDieselSales = app.estimateDailyDieselSale?.toString(),
        dailySuperSales = app.estimateDailySuperSale?.toString(),
        dailyHOBCSales = null, // TODO: Addd hobc field
        dailyLubricantSales = app.estimateLubricantSale?.toString(),
        rentExpectation = app.expectedLeaseRentPerManth?.toString(),
        truckPortPotential = app.trucPortPotentail?.toString(),
        salamMartPotential = app.salamMartPotential?.toString(),
        restaurantPotential = app.resturantPotential?.toString();

  VolumeFinancialState.loadFromTrafficTradeFormModel(TrafficTradeFormModel form)
      : dailyDieselSales = form.dailyDieselSales,
        dailySuperSales = form.dailySuperSales,
        dailyHOBCSales = form.dailyHOBCSales,
        dailyLubricantSales = form.dailyLubricantSales,
        rentExpectation = form.rentExpectation,
        truckPortPotential = form.truckPortPotential,
        salamMartPotential = form.salamMartPotential,
        restaurantPotential = form.restaurantPotential;
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

  void loadFromApplication(ApplicationModel app) {
    state = VolumeFinancialState.loadFromApplication(app);
  }

  void loadFromTrafficTradeFormModel(TrafficTradeFormModel form) {
    state = VolumeFinancialState.loadFromTrafficTradeFormModel(form);
  }
}
