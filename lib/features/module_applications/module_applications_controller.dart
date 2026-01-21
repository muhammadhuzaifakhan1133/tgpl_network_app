import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/providers/application_provider.dart';

final moduleApplicationsAsyncControllerProvider =
    AsyncNotifierProvider.family<
      ModuleApplicationsAyncController,
      List<ApplicationModel>,
      String
    >((module) {
      return ModuleApplicationsAyncController(module);
    });

class ModuleApplicationsAyncController
    extends AsyncNotifier<List<ApplicationModel>> {
  final String module;
  ModuleApplicationsAyncController(this.module);

  @override
  FutureOr<List<ApplicationModel>> build() async {
    return await ref.watch(applicationsProvider);
  }
}
