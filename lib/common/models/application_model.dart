class ApplicationModel {
  final String id;
  final String applicantName;
  final String city;
  final String siteName;
  final String category;
  final String address;
  final int statusId;
  final double latitude;
  final double longitude;
  final String receivedDate;
  final String priority;
  final String source;
  final String contactNumber;

  ApplicationModel({required this.id, required this.applicantName, required this.city, required this.siteName, required this.category, required this.address, required this.statusId, required this.latitude, required this.longitude, required this.receivedDate, required this.priority, required this.source, required this.contactNumber});
}