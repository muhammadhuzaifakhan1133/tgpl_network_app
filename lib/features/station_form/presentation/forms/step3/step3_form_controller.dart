import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final step3FormControllerProvider =
    NotifierProvider<Step3FormController, Step3FormState>(
  Step3FormController.new,
);


class Step3FormState {
  final String? frontSize;
  final String? depthSize;
  final String? googleLocation;
  final String? address;

  const Step3FormState({
    this.frontSize,
    this.depthSize,
    this.googleLocation,
    this.address,
  });

  Step3FormState copyWith({
    String? frontSize,
    String? depthSize,
    String? googleLocation,
    String? address,
    List<String>? fieldsToNull,
  }) {
    return Step3FormState(
      frontSize: fieldsToNull.apply('frontSize', frontSize, this.frontSize),
      depthSize: fieldsToNull.apply('depthSize', depthSize, this.depthSize),
      googleLocation: fieldsToNull.apply('googleLocation', googleLocation, this.googleLocation),
      address: fieldsToNull.apply('address', address, this.address),
    );
  }
}


class Step3FormController extends Notifier<Step3FormState> {
  @override
  Step3FormState build() {
    return const Step3FormState();
  }

  void updateFrontSize(String value) {
    state = state.copyWith(frontSize: value);
  }

  void updateDepthSize(String value) {
    state = state.copyWith(depthSize: value);
  }

  void updateLocation(String value) {
    state = state.copyWith(googleLocation: value);
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }
}
