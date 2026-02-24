import 'dart:async';

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
  List<ApplicationSuggestion> searchSuggestions;

  DashboardState({required this.isModulesExpanded, this.searchSuggestions = const []});

  DashboardState copyWith({List<bool>? isModulesExpanded, List<ApplicationSuggestion>? searchSuggestions}) {
    return DashboardState(
      isModulesExpanded: isModulesExpanded ?? this.isModulesExpanded,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
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

  Timer? _debounceTimer;
  Future<List<ApplicationSuggestion>> fetchSearchSuggestions(String query) async {
    _debounceTimer?.cancel();
    final completer = Completer<List<ApplicationSuggestion>>();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final dashboardDataSource = ref.read(dashboardDataSourceProvider);
        final suggestions = await dashboardDataSource.fetchSearchSuggestions(query);
        completer.complete(suggestions);
      } catch (e) {
        completer.completeError(e);
      }
    });
    return completer.future;
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
