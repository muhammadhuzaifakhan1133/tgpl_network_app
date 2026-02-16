import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/applications/models/application_status.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_controller.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
// import 'package:tgpl_network/utils/extensions/datetime_extension.dart';

final appStatusesProvider = Provider.family
    .autoDispose<List<ApplicationStatus>, ApplicationModel>((ref, application) {
      final app = application;
      return [
        ApplicationStatus(
          title: "Survey Profile",
          status: app.surveynDealerProfileDone != 0,
          dueDate: app.siteSurveyDealerProfileDueDate ?? '',
          completedDate: app.siteSurveyDealerProfileDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Traffic Trade",
          status: app.trafficTradeDone != 0,
          dueDate: app.trafficTradeDueDate ?? '',
          completedDate: app.trafficTradeDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Feasibility",
          status: app.feasibilityDone != 0,
          dueDate: app.feasibilityDueDate ?? '',
          completedDate: app.feasibilityDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Negotiation",
          status: app.negotiationDone != 0,
          dueDate: app.negotiationDueDate ?? '',
          completedDate: app.negotiationDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Feasibility Finalization",
          status: app.feasibilityfinalizationDone != 0,
          dueDate: app.feasibilityfinalizationDueDate ?? '',
          completedDate: app.feasibilityfinalizationDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "MOU Sign",
          status: app.mouSignOFFDone != 0,
          dueDate: app.mouSignOFFDueDate ?? '',
          completedDate: app.mouSignOFFDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Joining Fee",
          status: app.joiningFeeDone != 0,
          dueDate: app.joiningFeeDueDate ?? '',
          completedDate: app.joiningFeeDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Franchise Agreement",
          status: app.franchiseAgreementDone != 0,
          dueDate: app.franchiseAgreementDueDate ?? '',
          completedDate: app.franchiseAgreementDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Layout",
          status: app.explosiveLayoutDone != 0,
          dueDate: app.explosiveLayoutDueDate ?? '',
          completedDate: app.explosiveLayoutDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Drawing",
          status: app.drawingsDone != 0,
          dueDate: app.drawingsDueDate ?? '',
          completedDate: app.drawingsDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Topography",
          status: app.topographyDone != 0,
          dueDate: app.topographyDueDate ?? '',
          completedDate: app.topographyDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Issuance of Drawing",
          status: app.issuanceofDrawingsDone != 0,
          dueDate: app.issuanceofDrawingsDueDate ?? '',
          completedDate: app.issuanceofDrawingsDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Applied in Explosive",
          status: app.appliedInExplosiveDone != 0,
          dueDate: app.appliedInExplosiveDueDate ?? '',
          completedDate: app.appliedInExplosiveDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "DC NOC",
          status: app.dcnocDone != 0,
          dueDate: app.dcnocDueDate ?? '',
          completedDate: app.dcnocDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Capex",
          status: app.capexDone != 0,
          dueDate: app.capaxDueDate ?? '',
          completedDate: app.capaxDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Lease Agreement",
          status: app.leaseAgreementDone != 0,
          dueDate: app.leaseAgreementDueDate ?? '',
          completedDate: app.leaseAgreementDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "HOTO",
          status: app.hotoDone != 0,
          dueDate: app.hotoDueDate ?? '',
          completedDate: app.hotoDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Construction",
          status: app.constructionDone != 0,
          dueDate: app.constructionDueDate ?? '',
          completedDate: app.constructionDoneDate ?? '',
        ),
        ApplicationStatus(
          title: "Inauguration",
          status: app.inaugurationDone != 0,
          dueDate: app.inaugurationDueDate ?? '',
          completedDate: app.inaugurationDoneDate ?? '',
        ),
      ];
    });

class ApplicationStates {
  final int page;
  final List<bool> isApplicationsExpanded;
  final List<ApplicationModel> applications;
  final FilterSelectionState filter;
  final bool hasMoreData;

  ApplicationStates({
    required this.isApplicationsExpanded,
    required this.applications,
    required this.filter,
    required this.hasMoreData,
    this.page = 1,
  });

  ApplicationStates copyWith({
    List<bool>? isApplicationsExpanded,
    List<ApplicationModel>? applications,
    FilterSelectionState? filter,
    int? page,
    bool? hasMoreData,
  }) {
    return ApplicationStates(
      isApplicationsExpanded:
          isApplicationsExpanded ?? this.isApplicationsExpanded,
      applications: applications ?? this.applications,
      filter: filter ?? this.filter,
      page: page ?? this.page,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}

final applicationControllerProvider =
    AsyncNotifierProvider.autoDispose<ApplicationController, ApplicationStates>(
      () {
        return ApplicationController();
      },
    );

class ApplicationController extends AsyncNotifier<ApplicationStates> {
  // List<ApplicationModel> get applications => ref.read(applicationsProvider);

  @override
  Future<ApplicationStates> build() async {
    final filter = ref.read(filterSelectionProvider);
    final applications = await _getApplications(filters: filter, page: 1);
    return ApplicationStates(
      isApplicationsExpanded: List.generate(applications.length, (_) => false),
      applications: applications,
      filter: filter,
      page: 1,
      hasMoreData: applications.length >= ApplicationModel.pageSize,
    );
  }

  Future<List<ApplicationModel>> _getApplications({
    required FilterSelectionState? filters,
    required int page,
  }) async {
    final masterDataSource = ref.read(masterDataLocalDataSourceProvider);
    return await masterDataSource.getApplications(page: page, filters: filters);
  }

  Future<void> fetchMoreApplications() async {
    final nextPage = state.requireValue.page + 1;
    final filter = state.requireValue.filter;
    final newApplications = await _getApplications(
      filters: filter,
      page: nextPage,
    );
    final applications = [
      ...state.requireValue.applications,
      ...newApplications,
    ];
    final isExpandedList = [
      ...state.requireValue.isApplicationsExpanded,
      ...List.generate(newApplications.length, (_) => false),
    ];
    state = AsyncValue.data(
      state.requireValue.copyWith(
        applications: applications,
        isApplicationsExpanded: isExpandedList,
        page: nextPage,
        hasMoreData: newApplications.length >= ApplicationModel.pageSize,
      ),
    );
  }

  void onExpand(int index) {
    final newExpandedList = List<bool>.generate(
      state.requireValue.isApplicationsExpanded.length,
      (i) => i == index ? !state.requireValue.isApplicationsExpanded[i] : false,
    );
    state = AsyncValue.data(
      state.requireValue.copyWith(isApplicationsExpanded: newExpandedList),
    );
  }

  void clearFilters() {
    ref.read(filterSelectionProvider.notifier).clearAll();
  }
}
