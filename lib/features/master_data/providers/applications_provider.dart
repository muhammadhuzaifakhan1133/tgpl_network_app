import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationsProvider = Provider<List<ApplicationLegacyModel>>((ref) {
  // mock data - all karachi applications
  return [
    ApplicationLegacyModel(
      id: "APP-2025-001",
      applicantName: "Muhammad Ali",
      city: "Karachi",
      siteName: "TGL-23",
      category: "New Plot",
      address: "123 Main St, Karachi",
      statusId: 1,
      latitude: 24.8343808,
      longitude: 67.041284,
      receivedDate: "15 Jan 2025",
      priority: "High",
      source: "Ahmed Khan",
      contactNumber: "0321-1234567",
    ),
    ApplicationLegacyModel(
      id: "APP-2025-002",
      applicantName: "Ayesha Khan",
      city: "Karachi",
      siteName: "TGL-24",
      category: "Conversion",
      address: "456 Market St, Karachi",
      statusId: 2,
      latitude: 24.8250000,
      longitude: 67.042000,
      receivedDate: "14 Jan 2025",
      priority: "Medium",
      source: "M Farhan",
      contactNumber: "0321-8798545",
    ),
    ApplicationLegacyModel(
      id: "APP-2025-003",
      applicantName: "Omar Siddiqui",
      city: "Karachi",
      siteName: "TGL-25",
      category: "CNG",
      address: "789 Lakeview Rd, Karachi",
      statusId: 3,
      latitude: 24.8130000,
      longitude: 67.040000,
      receivedDate: "13 Jan 2025",
      priority: "Low",
      source: "Abdul Rafay",
      contactNumber: "0331-4582212",
    ),
    ApplicationLegacyModel(
      id: "APP-2025-004",
      applicantName: "Sara Ahmed",
      city: "Karachi",
      siteName: "TGL-26",
      category: "New Plot",
      address: "321 Garden St, Karachi",
      statusId: 4,
      latitude: 24.8300000,
      longitude: 67.035000,
      receivedDate: "12 Jan 2025",
      priority: "High",
      source: "M Haris",
      contactNumber: "0333-54215454",
    )
  ];
});

class ApplicationLegacyModel {
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

  ApplicationLegacyModel({required this.id, required this.applicantName, required this.city, required this.siteName, required this.category, required this.address, required this.statusId, required this.latitude, required this.longitude, required this.receivedDate, required this.priority, required this.source, required this.contactNumber});
}