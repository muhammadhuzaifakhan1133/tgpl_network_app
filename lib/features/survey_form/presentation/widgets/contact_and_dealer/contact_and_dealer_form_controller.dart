import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }) {
    return ContactAndDealerFormState(
      dealerName: dealerName ?? this.dealerName,
      dealerContact: dealerContact ?? this.dealerContact,
      referenceBy: referenceBy ?? this.referenceBy,
      locationAddress: locationAddress ?? this.locationAddress,
      landmark: landmark ?? this.landmark,
      nearestDepo: nearestDepo ?? this.nearestDepo,
      typeOfTradeArea: typeOfTradeArea ?? this.typeOfTradeArea,
      plotFront: plotFront ?? this.plotFront,
      plotDepth: plotDepth ?? this.plotDepth,
      plotArea: plotArea ?? this.plotArea,
      distanceFromDepo: distanceFromDepo ?? this.distanceFromDepo,
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