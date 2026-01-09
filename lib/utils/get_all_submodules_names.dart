import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/presentation/module_provider.dart';

List<String> getAllSubmodulesList(WidgetRef ref) {
    final modules = ref.read(modulesProvider);
    final List<String> submodules = [];
    for (var mod in modules) {
      submodules.addAll(mod.subModules.map((e) => e.title).toList());
    }
    return submodules;
  }