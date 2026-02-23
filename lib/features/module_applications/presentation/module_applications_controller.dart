import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/features/application_detail/data/application_detail_data_source.dart';
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

final selectedTabProviderForModuleApplications =
    StateProvider.autoDispose<String>((ref) => "All");

class ModuleApplicationsState {
  final List<ApplicationModel> applications;
  final int totalOverDueCount;
  final int totalInProgressCount;
  final int page;
  final bool hasMoreData;
  final String? searchQuery;
  final bool applyingFilter;

  ModuleApplicationsState({
    required this.applications,
    required this.totalOverDueCount,
    required this.totalInProgressCount,
    required this.page,
    required this.hasMoreData,
    this.searchQuery,
    this.applyingFilter = false,
  });

  ModuleApplicationsState copyWith({
    List<ApplicationModel>? applications,
    int? totalOverDueCount,
    int? totalInProgressCount,
    int? page,
    bool? hasMoreData,
    String? searchQuery,
    bool resetSearch = false,
    bool? applyingFilter,
  }) {
    return ModuleApplicationsState(
      applications: applications ?? this.applications,
      totalOverDueCount: totalOverDueCount ?? this.totalOverDueCount,
      totalInProgressCount: totalInProgressCount ?? this.totalInProgressCount,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      searchQuery: resetSearch ? null : searchQuery ?? this.searchQuery,
      applyingFilter: applyingFilter ?? this.applyingFilter,
    );
  }
}

class ModuleApplicationsAyncController
    extends AsyncNotifier<ModuleApplicationsState> {
  final SubModuleModel subModule;
  ModuleApplicationsAyncController(this.subModule);

  @override
  Future<ModuleApplicationsState> build() async {
    final data = await _getApplications(page: 1);
    final applications = data.$1;
    final totalOverDueCount = data.$2;
    final totalInProgressCount = data.$3;
    return ModuleApplicationsState(
      applications: applications,
      totalOverDueCount: totalOverDueCount,
      totalInProgressCount: totalInProgressCount,
      page: 1,
      hasMoreData: applications.length >= ApplicationModel.pageSize,
      searchQuery: state.value?.searchQuery,
    );
  }

  bool get showFilter => !(subModule.moduleName.startsWith("History") || subModule.title.startsWith("Open")); 

  Future<void> onSelectedTabChange(String selectedTab) async {
    ref.read(selectedTabProviderForModuleApplications.notifier).state =
        selectedTab;
    state = AsyncValue.data(state.requireValue.copyWith(applyingFilter: true));
    final data = await _getApplications(page: 1);
    final applications = data.$1;
    final totalOverDueCount = data.$2;
    final totalInProgressCount = data.$3;
    state = AsyncValue.data(
      state.requireValue.copyWith(
        applications: applications,
        totalOverDueCount: totalOverDueCount,
        totalInProgressCount: totalInProgressCount,
        page: 1,
        hasMoreData: applications.length >= ApplicationModel.pageSize,
        applyingFilter:
            false, // set applyingFilter back to false after data is loaded
      ),
    );
  }

  Future<(List<ApplicationModel>, int, int)> _getApplications({
    required int page,
  }) async {
    final moduleApplicationDataSource = ref.read(
      moduleApplicationsDataSourceProvider,
    );
    // await moduleApplicationDataSource.temp();
    final user = ref.read(userProvider).value;
    return await moduleApplicationDataSource.getApplicationsForSubModule(
      dbSubModuleCondition: subModule.dbCondition,
      page: page,
      query: state.value?.searchQuery,
      userPositionId: user?.positionId ?? 0,
      dueDateDbColumnName: subModule.dueDateDbColumnName,
      isInSurvey: subModule.title.startsWith("Survey"),
      isInTrafficTrade: subModule.title.startsWith("Traffic"),
      isCalculateCounts: showFilter,
      isOverDueFilterApplied: ref
          .read(selectedTabProviderForModuleApplications)
          .startsWith("Overdue"),
      isInProgressFilterApplied: ref
          .read(selectedTabProviderForModuleApplications)
          .startsWith("In Progress"),
    );
  }
  bool loadingMore = false;
  Future<void> fetchMoreApplications() async {
    if (loadingMore || !state.requireValue.hasMoreData) return;
    loadingMore = true;
    final nextPage = state.requireValue.page + 1;
    final data = await _getApplications(page: nextPage);
    final applications = [...state.requireValue.applications, ...data.$1];
    state = AsyncValue.data(
      state.requireValue.copyWith(
        applications: applications,
        totalOverDueCount: data.$2,
        totalInProgressCount: data.$3,
        page: nextPage,
        hasMoreData: data.$1.length >= ApplicationModel.pageSize,
        searchQuery: state.value?.searchQuery,
      ),
    );
    loadingMore = false;
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

  Future<void> syncApplication(String applicationId) async {
    final applicationDetailDataSource = ref.read(
      applicationDetailDataSourceProvider,
    );
    await applicationDetailDataSource.syncApplicationFromServer(applicationId);
    ref.invalidateSelf();
  }
}
