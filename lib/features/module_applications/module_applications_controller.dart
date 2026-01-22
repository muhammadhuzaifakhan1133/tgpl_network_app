import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/providers/applications_provider.dart';

final moduleApplicationsAsyncControllerProvider =
    AsyncNotifierProvider.family<
      ModuleApplicationsAyncController,
      List<ApplicationLegacyModel>,
      String
    >((module) {
      return ModuleApplicationsAyncController(module);
    });

class ModuleApplicationsAyncController
    extends AsyncNotifier<List<ApplicationLegacyModel>> {
  final String module;
  ModuleApplicationsAyncController(this.module);

  @override
  FutureOr<List<ApplicationLegacyModel>> build() async {
    return await ref.watch(applicationsProvider);
  }
}
