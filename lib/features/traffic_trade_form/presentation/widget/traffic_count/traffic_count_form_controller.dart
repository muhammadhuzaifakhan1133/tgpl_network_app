import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final trafficCountControllerProvider =
    NotifierProvider<TrafficCountController, TrafficCountState>(
  TrafficCountController.new,
);

class TrafficCountState {
  final String? trafficCountTruck;
  final String? trafficCountCar;
  final String? trafficCountBike;

  const TrafficCountState({
    this.trafficCountTruck,
    this.trafficCountCar,
    this.trafficCountBike,
  });

  TrafficCountState copyWith({
    String? trafficCountTruck,
    String? trafficCountCar,
    String? trafficCountBike,
    List<String>? fieldsToNull,
  }) {
    return TrafficCountState(
      trafficCountTruck: fieldsToNull.apply("trafficCountTruck", trafficCountTruck, this.trafficCountTruck),
      trafficCountCar: fieldsToNull.apply("trafficCountCar", trafficCountCar, this.trafficCountCar),
      trafficCountBike: fieldsToNull.apply("trafficCountBike", trafficCountBike, this.trafficCountBike),
    );
  }

  @override
  String toString() {
    return 'TrafficCountState(trafficCountTruck: $trafficCountTruck, trafficCountCar: $trafficCountCar, trafficCountBike: $trafficCountBike)';
  }

  // TODO: Add fields to ApplicationModel and uncomment this
  // TrafficCountState.loadFromApplication(ApplicationModel app)
  //     : trafficCountTruck = app.truckCount?.toString(),
  //       trafficCountCar = app.carCount?.toString(),
  //       trafficCountBike = app.bikeCount?.toString();

  TrafficCountState.loadFromTrafficTradeFormModel(TrafficTradeFormModel form)
      : trafficCountTruck = form.trafficCountTruck,
        trafficCountCar = form.trafficCountCar,
        trafficCountBike = form.trafficCountBike;
}

class TrafficCountController extends Notifier<TrafficCountState> {
  @override
  TrafficCountState build() {
    return const TrafficCountState();
  }

  void updateTrafficCountTruck(String value) {
    state = state.copyWith(trafficCountTruck: value);
  }

  void updateTrafficCountCar(String value) {
    state = state.copyWith(trafficCountCar: value);
  }

  void updateTrafficCountBike(String value) {
    state = state.copyWith(trafficCountBike: value);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }

//   void prefillFormData({
//     required String trafficCountTruck,
//     required String trafficCountCar,
//     required String trafficCountBike,
//   }) {
//     state = state.copyWith(
//       trafficCountTruck: trafficCountTruck,
//       trafficCountCar: trafficCountCar,
// trafficCountBike: trafficCountBike,
// );
// }

  void loadFromApplication(ApplicationModel app) {
    // TODO: Add fields to ApplicationModel and uncomment this
    // state = TrafficCountState.loadFromApplication(app);
  }

  void loadFromTrafficTradeFormModel(TrafficTradeFormModel form) {
    state = TrafficCountState.loadFromTrafficTradeFormModel(form);
  }
}