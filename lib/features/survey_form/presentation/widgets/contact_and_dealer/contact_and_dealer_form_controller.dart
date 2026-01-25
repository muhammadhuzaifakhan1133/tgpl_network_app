import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final contactAndDealerFormControllerProvider =
    NotifierProvider<ContactAndDealerFormController, ContactAndDealerFormState>(
        ContactAndDealerFormController.new);

class ContactAndDealerFormState {
  // Dealer / Contact
  final String? dealerName;
  final String? dealerContact;
  final String? referenceBy;

  // Location
  final String? locationAddress;
  final String? landmark;
  final String? nearestDepo;
  final String? typeOfTradeArea;

  // Plot
  final String? plotFront;
  final String? plotDepth;
  final String? plotArea;
  final String? distanceFromDepo;

  const ContactAndDealerFormState({
    this.dealerName,
    this.dealerContact,
    this.referenceBy,
    this.locationAddress,
    this.landmark,
    this.nearestDepo,
    this.typeOfTradeArea,
    this.plotFront,
    this.plotDepth,
    this.plotArea,
    this.distanceFromDepo,
  });

  ContactAndDealerFormState copyWith({
    String? dealerName,
    String? dealerContact,
    String? referenceBy,
    String? locationAddress,
    String? landmark,
    String? nearestDepo,
    String? typeOfTradeArea,
    String? plotFront,
    String? plotDepth,
    String? plotArea,
    String? distanceFromDepo,
    List<String>? fieldsToNull,
  }) {
    return ContactAndDealerFormState(
      dealerName: fieldsToNull.apply("dealerName", dealerName , this.dealerName),
      dealerContact: fieldsToNull.apply("dealerContact", dealerContact , this.dealerContact),
      referenceBy: fieldsToNull.apply("referenceBy", referenceBy , this.referenceBy),
      locationAddress: fieldsToNull.apply("locationAddress", locationAddress , this.locationAddress),
      landmark: fieldsToNull.apply("landmark", landmark , this.landmark),
      nearestDepo: fieldsToNull.apply("nearestDepo", nearestDepo , this.nearestDepo),
      typeOfTradeArea: fieldsToNull.apply("typeOfTradeArea", typeOfTradeArea , this.typeOfTradeArea),
      plotFront: fieldsToNull.apply("plotFront", plotFront , this.plotFront),
      plotDepth: fieldsToNull.apply("plotDepth", plotDepth , this.plotDepth),
      plotArea: fieldsToNull.apply("plotArea", plotArea , this.plotArea),
      distanceFromDepo: fieldsToNull.apply("distanceFromDepo", distanceFromDepo , this.distanceFromDepo),
    );
  }

  @override
  String toString() {
    return 'ContactAndDealerFormState(dealerName: $dealerName, dealerContact: $dealerContact, referenceBy: $referenceBy, locationAddress: $locationAddress, landmark: $landmark, nearestDepo: $nearestDepo, typeOfTradeArea: $typeOfTradeArea, plotFront: $plotFront, plotDepth: $plotDepth, plotArea: $plotArea, distanceFromDepo: $distanceFromDepo)';
  }
}

class ContactAndDealerFormController
    extends Notifier<ContactAndDealerFormState> {
  @override
  ContactAndDealerFormState build() {
    return const ContactAndDealerFormState();
  }

  /* ---------------- Dealer / Contact ---------------- */

  void updateDealerInfo({
    String? dealerName,
    String? dealerContact,
    String? referenceBy,
  }) {
    state = state.copyWith(
      dealerName: dealerName,
      dealerContact: dealerContact,
      referenceBy: referenceBy,
    );
  }

  /* ---------------- Location ---------------- */

  void updateLocationInfo({
    String? locationAddress,
    String? landmark,
    String? nearestDepo,
    String? typeOfTradeArea,
  }) {
    state = state.copyWith(
      locationAddress: locationAddress,
      landmark: landmark,
      nearestDepo: nearestDepo,
      typeOfTradeArea: typeOfTradeArea,
    );
  }

  /* ---------------- Plot ---------------- */

  void updatePlotDimensions({
    String? front,
    String? depth,
  }) {
    final plotFront = front ?? state.plotFront;
    final plotDepth = depth ?? state.plotDepth;

    String? area;
    final f = double.tryParse(plotFront ?? '');
    final d = double.tryParse(plotDepth ?? '');
    if (f != null && d != null) {
      area = (f * d).toStringAsFixed(2);
    }

    state = state.copyWith(
      plotFront: plotFront,
      plotDepth: plotDepth,
      plotArea: area,
    );
  }

  void updateDistanceFromDepo(String? value) {
    state = state.copyWith(distanceFromDepo: value);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }

  /* ---------------- Prefill (edit mode) ---------------- */

  void prefillFormData({
    required String dealerName,
    required String dealerContact,
    required String referenceBy,
    required String locationAddress,
    required String nearestDepo,
    required String typeOfTradeArea,
    required String landmark,
    required String plotFront,
    required String plotDepth,
    required String distanceFromDepo,
  }) {
    updateDealerInfo(
      dealerName: dealerName,
      dealerContact: dealerContact,
      referenceBy: referenceBy,
    );

    updateLocationInfo(
      locationAddress: locationAddress,
      landmark: landmark,
      nearestDepo: nearestDepo,
      typeOfTradeArea: typeOfTradeArea,
    );

    updatePlotDimensions(
      front: plotFront,
      depth: plotDepth,
    );

    updateDistanceFromDepo(distanceFromDepo);
  }
}