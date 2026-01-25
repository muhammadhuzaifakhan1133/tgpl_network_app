import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/data/dashboard_data_source.dart';

final getLastSyncTimeProvider = FutureProvider<String>((ref) {
  final dashboardDataSource = ref.read(dashboardDataSourceProvider);
  return dashboardDataSource.getLastSyncTime();
});