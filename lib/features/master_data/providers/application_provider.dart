import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_controller.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

final applicationsProvider =
    FutureProvider<List<ApplicationModel>>((ref) async {
  final localDataSource = ref.watch(masterDataLocalDataSourceProvider);
  final filters = ref.watch(applicationFiltersProvider);

  return await localDataSource.getApplications(
    filters: filters.hasActiveFilters ? filters : null,
  );
});

// final applicationsProvider = Provider<List<ApplicationModel>>((ref) {
//   // mock data - all karachi applications
//   return [
//     ApplicationModel(
//       id: "APP-2025-001",
//       applicantName: "Muhammad Ali",
//       city: "Karachi",
//       siteName: "TGL-23",
//       category: "New Plot",
//       address: "123 Main St, Karachi",
//       statusId: 1,
//       latitude: 24.8343808,
//       longitude: 67.041284,
//       receivedDate: "15 Jan 2025",
//       priority: "High",
//       source: "Ahmed Khan",
//       contactNumber: "0321-1234567",
//     ),
//     ApplicationModel(
//       id: "APP-2025-002",
//       applicantName: "Ayesha Khan",
//       city: "Karachi",
//       siteName: "TGL-24",
//       category: "Conversion",
//       address: "456 Market St, Karachi",
//       statusId: 2,
//       latitude: 24.8250000,
//       longitude: 67.042000,
//       receivedDate: "14 Jan 2025",
//       priority: "Medium",
//       source: "M Farhan",
//       contactNumber: "0321-8798545",
//     ),
//     ApplicationModel(
//       id: "APP-2025-003",
//       applicantName: "Omar Siddiqui",
//       city: "Karachi",
//       siteName: "TGL-25",
//       category: "CNG",
//       address: "789 Lakeview Rd, Karachi",
//       statusId: 3,
//       latitude: 24.8130000,
//       longitude: 67.040000,
//       receivedDate: "13 Jan 2025",
//       priority: "Low",
//       source: "Abdul Rafay",
//       contactNumber: "0331-4582212",
//     ),
//     ApplicationModel(
//       id: "APP-2025-004",
//       applicantName: "Sara Ahmed",
//       city: "Karachi",
//       siteName: "TGL-26",
//       category: "New Plot",
//       address: "321 Garden St, Karachi",
//       statusId: 4,
//       latitude: 24.8300000,
//       longitude: 67.035000,
//       receivedDate: "12 Jan 2025",
//       priority: "High",
//       source: "M Haris",
//       contactNumber: "0333-54215454",
//     )
//   ];
// });