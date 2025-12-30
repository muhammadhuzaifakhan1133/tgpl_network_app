import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/applications/presentation/dialogs/filter_selection_dialog.dart';
import 'package:tgpl_network/features/applications/presentation/widgets/application_status_container.dart';

class ApplicationsView extends ConsumerWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationController = ref.read(
      applicationControllerProvider.notifier,
    );
    return Column(
      children: [
        Builder(
          builder: (context) {
            return CustomAppBar(
              title: "Applications",
              subtitle: "Process status tracking",
              showSearchIcon: true,
              showFilterIcon: true,
              onTapFilterIcon: () {
                filterSelectionDialog(context);
              },
            );
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: applicationController.applications.length,
            itemBuilder: (context, index) {
              return Consumer(
                builder: (context, ref, child) {
                  final isExpanded = ref.watch(
                    applicationControllerProvider.select(
                      (state) => state.isApplicationsExpanded[index],
                    ),
                  );
                  return GestureDetector(
                    onTap: () {
                      applicationController.onExpand(index);
                    },
                    child: ApplicationStatusContainer(
                      isExpanded: isExpanded,
                      application: applicationController.applications[index],
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
          ),
        ),
      ],
    );
  }
}
