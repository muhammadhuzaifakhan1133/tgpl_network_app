import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/app_status_category.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/audit_perform/data/sample_data.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_page.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

final inauguratedSiteProvider = FutureProvider<List<ApplicationModel>>((ref) {
  final masterDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return masterDataSource.getApplications(
    filters: FilterSelectionState(
      selectedStatus: AppStatusCategory(
        type: AppStatusCategoryType.inaugurated,
        statusIds: AppStatusCategoryType.inaugurated.statusIds,
      ),
    ),
  );
});

final currentAuditPerformPageIndexProvider =
    NotifierProvider<CurrentAuditPerformPageIndexNotifier, int>(
      () => CurrentAuditPerformPageIndexNotifier(),
    );

class CurrentAuditPerformPageIndexNotifier extends Notifier<int> {
  @override
  int build() {
    return 0; // Start with the first page
  }

  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      state++;
    }
  }

  void previousPage() {
    if (state > 0) {
      state--;
    }
  }

  void goToPage(int pageIndex, int totalPages) {
    if (pageIndex >= 0 && pageIndex < totalPages) {
      state = pageIndex;
    }
  }
}

final auditPerformControllerProvider =
    AsyncNotifierProvider<AuditPerformController, AuditPerformState>(
      () => AuditPerformController(),
    );

class AuditPerformState {
  final List<AuditPage> pages;

  AuditPerformState({required this.pages});

  AuditPerformState copyWith({List<AuditPage>? pages}) {
    return AuditPerformState(pages: pages ?? this.pages);
  }
}

class AuditPerformController extends AsyncNotifier<AuditPerformState> {
  @override
  FutureOr<AuditPerformState> build() async {
    return AuditPerformState(pages: await getAuditPages());
  }

  Future<List<AuditPage>> getAuditPages() async {
    await Future.delayed(Duration(seconds: 1));
    return auditPages;
  }
}
