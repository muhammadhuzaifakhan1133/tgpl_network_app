import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/applications/models/application_status.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_controller.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';

final appStatusesProvider = Provider.family
    .autoDispose<List<ApplicationStatus>, int>((ref, index) {
      final app = ref
          .read(applicationControllerProvider)
          .requireValue
          .searchedApplications[index];
      return [
        ApplicationStatus(title: "Survey Profile", status: app.surveyDealerProfileDone != 0),
        ApplicationStatus(title: "Traffic Trade", status: app.trafficTradeDone != 0),
        ApplicationStatus(title: "Feasibility", status: app.feasibilityDone != 0),
        ApplicationStatus(title: "Negotiation", status: app.negotiationDone != 0),
        ApplicationStatus(title: "Feasibility Finalization", status: app.feasibilityFinalizationDone != 0),
        ApplicationStatus(title: "MOU Sign", status: app.mouSignOffDone != 0),
        ApplicationStatus(title: "Joining Fee", status: app.joiningFeeDone != 0),
        ApplicationStatus(title: "Franchise Agreement", status: app.franchiseAgreementDone != 0),
        ApplicationStatus(title: "Layout", status: app.explosiveLayoutDone != 0),
        ApplicationStatus(title: "Drawing", status: app.drawingsDone != 0),
        ApplicationStatus(title: "Topography", status: app.topographyDone != 0),
        ApplicationStatus(title: "Issuance of Drawing", status: app.issuanceOfDrawingsDone != 0),
        ApplicationStatus(title: "Applied in Explosive", status: app.appliedInExplosiveDone != 0),
        ApplicationStatus(title: "DC NOC", status: app.dcNocDone != 0),
        ApplicationStatus(title: "Capex", status: app.capexDone != 0),
        ApplicationStatus(title: "Lease Agreement", status: app.leaseAgreementDone != 0),
        ApplicationStatus(title: "HOTO", status: app.hotoDone != 0),
        ApplicationStatus(title: "Construction", status: app.constructionDone != 0),
        ApplicationStatus(title: "Inauguration", status: app.inaugurationDone != 0),
      ];
    });

class ApplicationStates {
  final List<bool> isApplicationsExpanded;
  final List<ApplicationModel> allApplications;
  final List<ApplicationModel> searchedApplications;
  final FilterSelectionState filter;

  ApplicationStates({required this.isApplicationsExpanded, required this.allApplications, required this.searchedApplications, required this.filter});

  ApplicationStates copyWith({List<bool>? isApplicationsExpanded, List<ApplicationModel>? allApplications, List<ApplicationModel>? searchedApplications, FilterSelectionState? filter}) {
    return ApplicationStates(
      isApplicationsExpanded:
          isApplicationsExpanded ?? this.isApplicationsExpanded,
      allApplications: allApplications ?? this.allApplications,
      searchedApplications: searchedApplications ?? this.searchedApplications,
      filter: filter ?? this.filter,
    );
  }
}

final applicationControllerProvider =
    AsyncNotifierProvider.autoDispose<ApplicationController, ApplicationStates>(() {
      return ApplicationController();
    });

class ApplicationController extends AsyncNotifier<ApplicationStates> {
  // List<ApplicationModel> get applications => ref.read(applicationsProvider);

  @override
  Future<ApplicationStates> build() async {
    final applications = await getApplications();
    final filter = ref.read(filterSelectionProvider);
    return ApplicationStates(
      isApplicationsExpanded: List.generate(applications.length, (_) => false),
      allApplications: applications,
      searchedApplications: applications,
      filter: filter,
    );
  }

  Future<List<ApplicationModel>> getApplications() async {
    final masterDataSource = ref.read(masterDataLocalDataSourceProvider);
    return await masterDataSource.getApplications();
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


  void onSearchApplications(String query) {
    
  }



  void _searchApplications(String query) {
    final allApplications = state.requireValue.allApplications;
    if (query.isEmpty) {
      state = AsyncValue.data(
        state.requireValue.copyWith(searchedApplications: allApplications),
      );
      return;
    }
    final filteredApplications = allApplications.where((app) {
      final entryCodeLower = app.entryCode.toString().toLowerCase();
      final dealerNameLower = app.dealerName.toString().toLowerCase();
      final cityLower = app.cityName.toString().toLowerCase();
      final dateLower = app.addDate.toString().formatTod_MMM_yyyy().toLowerCase();
      final searchLower = query.trim().toLowerCase();
      return dealerNameLower.contains(searchLower) ||
          cityLower.contains(searchLower) ||
          entryCodeLower.contains(searchLower) || dateLower.contains(searchLower);
    }).toList();

    state = AsyncValue.data(
      state.requireValue.copyWith(searchedApplications: filteredApplications),
    );
  }
}