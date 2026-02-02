import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/data/dashboard_data_source.dart';

final getLastSyncTimeProvider = FutureProvider<String>((ref) {
  final timer = Timer.periodic(const Duration(minutes: 1), (_) {
    ref.invalidateSelf();
  });
  
  // Cancel timer when provider is disposed
  ref.onDispose(() => timer.cancel());
  final dashboardDataSource = ref.read(dashboardDataSourceProvider);
  return dashboardDataSource.getLastSyncTime();
});