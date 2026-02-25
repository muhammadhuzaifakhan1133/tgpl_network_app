import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_form/models/site_status_model.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';

final siteStatusesProvider = FutureProvider<List<SiteStatusModel>>((ref) async {
  final masterDataLocalDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return await masterDataLocalDataSource.getSiteStatuses();
});