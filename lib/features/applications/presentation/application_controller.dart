import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/application_model.dart';
import 'package:tgpl_network/features/master_data/providers/application_provider.dart';
import 'package:tgpl_network/features/applications/models/application_status.dart';

final appStatusesProvider = Provider.family
    .autoDispose<List<ApplicationStatus>, String>((ref, id) {
      return [
        ApplicationStatus(title: "Survey Profile", status: true),
        ApplicationStatus(title: "Traffic Trade", status: true),
        ApplicationStatus(title: "Feasibility", status: true),
        ApplicationStatus(title: "Negotiation", status: false),
        ApplicationStatus(title: "Feasibility Finalization", status: true),
        ApplicationStatus(title: "MOU Sign", status: true),
        ApplicationStatus(title: "Joining Fee", status: true),
        ApplicationStatus(title: "Franchise Agreement", status: true),
        ApplicationStatus(title: "Layout", status: true),
        ApplicationStatus(title: "Drawing", status: true),
        ApplicationStatus(title: "Topography", status: true),
        ApplicationStatus(title: "Issuance of Drawing", status: true),
        ApplicationStatus(title: "Applied in Explosive", status: true),
        ApplicationStatus(title: "DC NOC", status: false),
        ApplicationStatus(title: "Capex", status: false),
        ApplicationStatus(title: "Lease Agreement", status: false),
        ApplicationStatus(title: "HOTO", status: false),
        ApplicationStatus(title: "Construction", status: false),
        ApplicationStatus(title: "Inauguration", status: false),
      ];
    });

class ApplicationStates {
  final List<bool> isApplicationsExpanded;

  ApplicationStates({required this.isApplicationsExpanded});

  ApplicationStates copyWith({List<bool>? isApplicationsExpanded}) {
    return ApplicationStates(
      isApplicationsExpanded:
          isApplicationsExpanded ?? this.isApplicationsExpanded,
    );
  }
}

final applicationControllerProvider =
    NotifierProvider.autoDispose<ApplicationController, ApplicationStates>(() {
      return ApplicationController();
    });

class ApplicationController extends Notifier<ApplicationStates> {
  List<ApplicationModel> get applications => ref.read(applicationsProvider);

  @override
  ApplicationStates build() {
    return ApplicationStates(
      isApplicationsExpanded: List.generate(applications.length, (_) => false),
    );
  }

  void onExpand(int index) {
    final newExpandedList = List<bool>.generate(
      state.isApplicationsExpanded.length,
      (i) => i == index ? !state.isApplicationsExpanded[i] : false,
    );
    state = state.copyWith(isApplicationsExpanded: newExpandedList);
  }
}
