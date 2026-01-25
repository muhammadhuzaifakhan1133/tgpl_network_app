import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/utils/get_all_submodules_names.dart';

final dashboardSearchControllerProvider =
    NotifierProvider.autoDispose<DashboardSearchController, List<SubModuleModel>>(
      DashboardSearchController.new,
    );

class DashboardSearchController extends Notifier<List<SubModuleModel>> {
  late List<SubModuleModel> _allSubModules;

  @override
  List<SubModuleModel> build() {
    _allSubModules = getAllSubmodulesList(ref);
    return [];
  }

  void updateSearchResults(String query) {
    if (query.trim().isEmpty) {
      state = [];
    } else {
      final q = query.toLowerCase();
      state = _allSubModules.where((subModule) {
        return subModule.title.toLowerCase().contains(q) ||
            subModule.moduleName.toLowerCase().contains(q);
      }).toList();
    }
  }
}
