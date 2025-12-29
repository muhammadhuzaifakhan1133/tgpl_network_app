import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/dashboard/models/user_model.dart';
import 'package:tgpl_network/features/dashboard/presentation/module_provider.dart';

final userProvider = Provider<User>((ref) {
  return User(name: "Ahmed Hassan", title: "Regional Manager", id: "EMP-2025-001");
});

final dashboardControllerProvider =
    NotifierProvider.autoDispose<DashboardController, DashboardState>(() {
      return DashboardController();
    });

class DashboardState {
  List<bool> isModulesExpanded;

  DashboardState({required this.isModulesExpanded});

  DashboardState copyWith({List<bool>? isModulesExpanded}) {
    return DashboardState(
      isModulesExpanded: isModulesExpanded ?? this.isModulesExpanded,
    );
  }
}

class DashboardController extends Notifier<DashboardState> {
  List<ModuleModel> get modules => ref.read(modulesProvider);

  @override
  DashboardState build() {
    return DashboardState(
      isModulesExpanded: List<bool>.generate(modules.length, (_) => false),
    );
  }

  void onModuleExpand(int index) {
    final newExpandedList = List<bool>.generate(
      state.isModulesExpanded.length,
      (i) => i == index ? !state.isModulesExpanded[i] : false,
    );

    state = state.copyWith(isModulesExpanded: newExpandedList);
  }
}
