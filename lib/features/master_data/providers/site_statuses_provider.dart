import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_form/data/app_form_dropdowns_local_data_source.dart';
import 'package:tgpl_network/features/application_form/models/site_status_model.dart';

final siteStatusesProvider = FutureProvider<List<SiteStatusModel>>((ref) async {
  final appFormDropdownsLocalDataSource = ref.watch(appFormDropdownsLocalDataSourceProvider);
  return await appFormDropdownsLocalDataSource.getSiteStatuses();
});