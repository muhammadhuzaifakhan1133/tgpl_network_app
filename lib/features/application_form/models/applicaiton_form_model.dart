import 'package:tgpl_network/features/application_form/models/site_status_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';

class ApplicationFormModel {
  // step 1
  final String? applicantName;
  final String? emailAddress;
  final String? contactPerson;
  final String? currentlyPresence;
  final String? contactNumber;
  final String? whatsappNumber;

  // step 2
  final CityModel? selectedCity;
  final SiteStatusModel? selectedSiteStatus;
  final String? selectedPriority;
  final String? source;
  final String? sourceName;

  // step 3
  final String? frontSize;
  final String? depthSize;
  final String? googleLocation;
  final String? address;

  ApplicationFormModel({
    this.applicantName,
    this.emailAddress,
    this.contactPerson,
    this.currentlyPresence,
    this.contactNumber,
    this.whatsappNumber,
    this.selectedCity,
    this.selectedSiteStatus,
    this.selectedPriority,
    this.source,
    this.sourceName,
    this.frontSize,
    this.depthSize,
    this.googleLocation,
    this.address,
  });

  Map<String, dynamic> toApiMap() {
    return {
      "applicantName": applicantName,
      "EmailAddress": emailAddress,
      "contactPerson": contactPerson,
      "currentlyPresence": currentlyPresence,
      "contactNumber": contactNumber,
      "whatsappNumber": whatsappNumber,
      "cityId": selectedCity?.cityId,
      "siteStatusId": selectedSiteStatus?.siteStatusId,
      "priority": selectedPriority,
      "source": source,
      "sourceName": sourceName,
      "frontSize": frontSize,
      "depthSize": depthSize,
      "googleLocation": googleLocation,
      "address": address,
    };
  }

  // factory ApplicationFormModel.fromJson(Map<String, dynamic> json) {
  //   return ApplicationFormModel(
  //     // step 1
  //     applicantName: json['applicantName'],
  //     contactPerson: json['contactPerson'],
  //     currentlyPresence: json['currentlyPresence'],
  //     contactNumber: json['contactNumber'],
  //     whatsappNumber: json['whatsappNumber'],

  //     // step 2
  //     selectedCity: json['selectedCity'],
  //     selectedSiteStatus: json['selectedSiteStatus'],
  //     selectedPriority: json['selectedPriority'],
  //     source: json['source'],
  //     sourceName: json['sourceName'],

  //     // step 3
  //     frontSize: json['frontSize'],
  //     depthSize: json['depthSize'],
  //     googleLocation: json['googleLocation'],
  //     address: json['address'],
  //   );
  // }
}
