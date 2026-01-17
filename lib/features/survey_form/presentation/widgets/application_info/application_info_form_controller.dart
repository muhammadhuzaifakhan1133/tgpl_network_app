import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/nullable_fields_helper.dart';

final applicationInfoFormControllerProvider =
    NotifierProvider<ApplicationInfoFormController, ApplicationInfoFormState>(
      ApplicationInfoFormController.new,
    );

class ApplicationInfoFormState {
  final String? selectedCity;
  final String? siteStatus;
  final String? selectedPriority;
  final String? applicantId;
  final String? entryCode;
  final String? dateConducted;
  final String? conductedBy;
  final String? googleLocation;
  final String? district;
  final String? npName;
  final String? source;
  final String? sourceName;

  const ApplicationInfoFormState({
    this.selectedCity,
    this.siteStatus,
    this.selectedPriority,
    this.applicantId,
    this.entryCode,
    this.dateConducted,
    this.conductedBy,
    this.googleLocation,
    this.district,
    this.npName,
    this.source,
    this.sourceName,
  });

  ApplicationInfoFormState copyWith({
    String? selectedCity,
    String? siteStatus,
    String? selectedPriority,
    String? applicantId,
    String? entryCode,
    String? dateConducted,
    String? conductedBy,
    String? googleLocation,
    String? district,
    String? npName,
    String? source,
    String? sourceName,
    List<String>? fieldsToNull,
  }) {
    return ApplicationInfoFormState(
      selectedCity: fieldsToNull
          .apply('selectedCity', selectedCity, this.selectedCity),
      siteStatus: fieldsToNull.apply("siteStatus", siteStatus, this.siteStatus),
      selectedPriority: fieldsToNull.apply("selectedPriority", selectedPriority, this.selectedPriority),
      applicantId: fieldsToNull.apply("applicantId", applicantId, this.applicantId),
      entryCode: fieldsToNull.apply("entryCode", entryCode, this.entryCode),
      dateConducted: fieldsToNull.apply("dateConducted", dateConducted, this.dateConducted),
      conductedBy: fieldsToNull.apply("conductedBy", conductedBy, this.conductedBy),
      googleLocation: fieldsToNull.apply("googleLocation", googleLocation, this.googleLocation),
      district: fieldsToNull.apply("district", district, this.district),
      npName: fieldsToNull.apply("npName", npName, this.npName),
      source: fieldsToNull.apply("source", source, this.source),
      sourceName: fieldsToNull.apply("sourceName", sourceName, this.sourceName),
    );
  }

  @override
  String toString() {
    return 'ApplicationInfoFormState(selectedCity: $selectedCity, siteStatus: $siteStatus, selectedPriority: $selectedPriority, applicantId: $applicantId, entryCode: $entryCode, dateConducted: $dateConducted, conductedBy: $conductedBy, googleLocation: $googleLocation, district: $district, npName: $npName, source: $source, sourceName: $sourceName)';
  }
}

class ApplicationInfoFormController extends Notifier<ApplicationInfoFormState> {
  @override
  ApplicationInfoFormState build() {
    return const ApplicationInfoFormState();
  }

  void updateLocation({
    String? city,
    String? district,
    String? googleLocation,
  }) {
    state = state.copyWith(
      selectedCity: city,
      district: district,
      googleLocation: googleLocation,
    );
  }

  void updateSiteInfo({String? status, String? priority}) {
    state = state.copyWith(siteStatus: status, selectedPriority: priority);
  }

  void updateConductedInfo({String? dateConducted, String? conductedBy}) {
    state = state.copyWith(
      dateConducted: dateConducted,
      conductedBy: conductedBy,
    );
  }

  void updateNpName(String name) {
    state = state.copyWith(npName: name);
  }

  void updateSourceInfo({String? source, String? sourceName}) {
    state = state.copyWith(source: source, sourceName: sourceName);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }

  void prefillFormData({
    required String applicantId,
    required String entryCode,
    required String dateConducted,
    required String conductedBy,
    required String googleLocation,
    required String district,
    required String npName,
    required String source,
    required String sourceName,
    required String city,
    required String status,
    required String priority,
  }) {
    state = state.copyWith(
      applicantId: applicantId,
      entryCode: entryCode,
      dateConducted: dateConducted,
      conductedBy: conductedBy,
      googleLocation: googleLocation,
      district: district,
      npName: npName,
      source: source,
      sourceName: sourceName,
      selectedCity: city,
      siteStatus: status,
      selectedPriority: priority,
    );
  }
}
