import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }) {
    return TrafficCountState(
      trafficCountTruck: trafficCountTruck ?? this.trafficCountTruck,
      trafficCountCar: trafficCountCar ?? this.trafficCountCar,
      trafficCountBike: trafficCountBike ?? this.trafficCountBike,
    );
  }

  @override
  String toString() {
    return 'TrafficCountState(trafficCountTruck: $trafficCountTruck, trafficCountCar: $trafficCountCar, trafficCountBike: $trafficCountBike)';
  }
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

  void prefillFormData({
    required String trafficCountTruck,
    required String trafficCountCar,
    required String trafficCountBike,
  }) {
    state = state.copyWith(
      trafficCountTruck: trafficCountTruck,
      trafficCountCar: trafficCountCar,
trafficCountBike: trafficCountBike,
);
}
}