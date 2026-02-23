import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/data/dashboard_data_source.dart';
import 'package:tgpl_network/features/dashboard/models/application_suggestions.dart';
import 'package:tgpl_network/features/dashboard/models/dashboard_response_model.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/dashboard/data/module_provider.dart';

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
  String selectedSearchCategory;
  List<ApplicationSuggestion> searchSuggestions;

  DashboardState({required this.isModulesExpanded, required this.selectedSearchCategory, this.searchSuggestions = const []});

  DashboardState copyWith({List<bool>? isModulesExpanded, String? selectedSearchCategory, List<ApplicationSuggestion>? searchSuggestions}) {
    return DashboardState(
      isModulesExpanded: isModulesExpanded ?? this.isModulesExpanded,
      selectedSearchCategory: selectedSearchCategory ?? this.selectedSearchCategory,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
    );
  }
}

class DashboardController extends Notifier<DashboardState> {
  List<ModuleModel> get modules => ref.read(modulesProvider);

  Map<String, String> get searchCategories => {
        "App ID": "applicationId",
        "Dealer Name": "applicantName",
        "Site Name": "proposedSiteName1",
      };

  @override
  DashboardState build() {
    return DashboardState(
      isModulesExpanded: List<bool>.generate(modules.length, (_) => false),
      selectedSearchCategory: searchCategories.keys.first,
    );
  }

  void onModuleExpand(int index) {
    final newExpandedList = List<bool>.generate(
      state.isModulesExpanded.length,
      (i) => i == index ? !state.isModulesExpanded[i] : false,
    );

    state = state.copyWith(isModulesExpanded: newExpandedList);
  }

  void onChangeSearchCategory(String? category) {
    if (category == null) return;
    state = state.copyWith(selectedSearchCategory: category);
  }

  Future<List<ApplicationSuggestion>> fetchSearchSuggestions(String query, String field) async {
    final dashboardDataSource = ref.read(dashboardDataSourceProvider);
    final suggestions = await dashboardDataSource.fetchSearchSuggestions(query, field);
    state = state.copyWith(searchSuggestions: suggestions);
    return suggestions;
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
