class StationFormModel {
  // step 1
  final String? applicantName;
  final String? contactPerson;
  final String? currentlyPresence;
  final String? contactNumber;
  final String? whatsappNumber;

  // step 2
  final String? selectedCity;
  final String? selectedSiteStatus;
  final String? selectedPriority;
  final String? source;
  final String? sourceName;

  // step 3
  final String? frontSize;
  final String? depthSize;
  final String? googleLocation;
  final String? address;

  StationFormModel({this.applicantName, this.contactPerson, this.currentlyPresence, this.contactNumber, this.whatsappNumber, this.selectedCity, this.selectedSiteStatus, this.selectedPriority, this.source, this.sourceName, this.frontSize, this.depthSize, this.googleLocation, this.address});

  Map<String, dynamic> toJson() {
    return {
      // step 1
      'applicantName': applicantName,
      'contactPerson': contactPerson,
      'currentlyPresence': currentlyPresence,
      'contactNumber': contactNumber,
      'whatsappNumber': whatsappNumber,

      // step 2
      'selectedCity': selectedCity,
      'selectedSiteStatus': selectedSiteStatus,
      'selectedPriority': selectedPriority,
      'source': source,
      'sourceName': sourceName,

      // step 3
      'frontSize': frontSize,
      'depthSize': depthSize,
      'googleLocation': googleLocation,
      'address': address,
    };
  }

  factory StationFormModel.fromJson(Map<String, dynamic> json) {
    return StationFormModel(
      // step 1
      applicantName: json['applicantName'],
      contactPerson: json['contactPerson'],
      currentlyPresence: json['currentlyPresence'],
      contactNumber: json['contactNumber'],
      whatsappNumber: json['whatsappNumber'],

      // step 2
      selectedCity: json['selectedCity'],
      selectedSiteStatus: json['selectedSiteStatus'],
      selectedPriority: json['selectedPriority'],
      source: json['source'],
      sourceName: json['sourceName'],

      // step 3
      frontSize: json['frontSize'],
      depthSize: json['depthSize'],
      googleLocation: json['googleLocation'],
      address: json['address'],
    );
  }
}