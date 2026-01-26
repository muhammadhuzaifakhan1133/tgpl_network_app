import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/data/dashboard_data_source.dart';
import 'package:tgpl_network/features/dashboard/models/dashboard_response_model.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/dashboard/data/module_provider.dart';
import 'package:tgpl_network/common/models/user_model.dart';

final userProvider = Provider<UserModel>((ref) {
  return UserModel(
    name: "Ahmed Hassan",
    role: "Regional Manager",
    id: "EMP-2025-001",
  );
});

final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardState>(() {
      return DashboardController();
    });

final dashboardAsyncControllerProvider =
    AsyncNotifierProvider<DashboardAsyncController, DashboardResponseModel>(() {
      return DashboardAsyncController();
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

class DashboardAsyncController extends AsyncNotifier<DashboardResponseModel> {
  @override
  Future<DashboardResponseModel> build() async {
    return await getDashboardData();
  }

  Future<DashboardResponseModel> getDashboardData() async {
    final dashboardDataSource = ref.read(dashboardDataSourceProvider);
    return await dashboardDataSource.fetchDashboardData();
  }
}
