import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/module_applications/data/module_applications_data_source.dart';

final moduleApplicationsAsyncControllerProvider =
    AsyncNotifierProvider.family<
      ModuleApplicationsAyncController,
      ModuleApplicationsState,
      SubModuleModel
    >((module) {
      return ModuleApplicationsAyncController(module);
    });

class ModuleApplicationsState {
  final List<ApplicationModel> applications;
  final int page;
  final bool hasMoreData;
  final String? searchQuery;

  ModuleApplicationsState({
    required this.applications,
    required this.page,
    required this.hasMoreData,
    this.searchQuery,
  });

  ModuleApplicationsState copyWith({
    List<ApplicationModel>? applications,
    int? page,
    bool? hasMoreData,
    String? searchQuery,
    bool resetSearch = false,
  }) {
    return ModuleApplicationsState(
      applications: applications ?? this.applications,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      searchQuery: resetSearch ? null : searchQuery ?? this.searchQuery,
    );
  }
}

class ModuleApplicationsAyncController
    extends AsyncNotifier<ModuleApplicationsState> {
  final SubModuleModel subModule;
  ModuleApplicationsAyncController(this.subModule);

  @override
  Future<ModuleApplicationsState> build() async {
    final applications = await _getApplications(page: 1);
    return ModuleApplicationsState(
      applications: applications,
      page: 1,
      hasMoreData: applications.length >= ApplicationModel.pageSize,
      searchQuery: state.value?.searchQuery,
    );
  }

  Future<List<ApplicationModel>> _getApplications({required int page}) async {
    final moduleApplicationDataSource = ref.read(
      moduleApplicationsDataSourceProvider,
    );
    return await moduleApplicationDataSource.getApplicationsForSubModule(
      dbSubModuleCondition: subModule.dbCondition,
      page: page,
      query: state.value?.searchQuery,
    );
  }

  Future<void> fetchMoreApplications() async {
    final nextPage = state.requireValue.page + 1;
    final newApplications = await _getApplications(page: nextPage);
    final applications = [
      ...state.requireValue.applications,
      ...newApplications,
    ];
    state = AsyncValue.data(
      state.requireValue.copyWith(
        applications: applications,
        page: nextPage,
        hasMoreData: newApplications.length >= ApplicationModel.pageSize,
      ),
    );
  }

  Timer? _debounceTimer;
  void onSearchQueryChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query == state.value?.searchQuery || state.isLoading) {
        return;
      }
      state = AsyncValue.data(state.requireValue.copyWith(searchQuery: query));
      ref.invalidateSelf();
    });
  }

  void clearSearch() {
    state = AsyncValue.data(state.requireValue.copyWith(resetSearch: true));
    ref.invalidateSelf();
  }
}
