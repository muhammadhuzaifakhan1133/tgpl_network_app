
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/dashboard/data/module_provider.dart';

List<SubModuleModel> getAllSubmodulesList(ref) {
    final modules = ref.read(modulesProvider);
    final List<SubModuleModel> submodules = [];
    for (var mod in modules) {
      submodules.addAll(mod.subModules);
    }
    return submodules;
  }