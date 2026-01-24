import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/applications/presentation/widgets/application_status_container.dart';
import 'package:tgpl_network/features/applications/presentation/widgets/applications_shimmer_widget.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class ApplicationsView extends ConsumerWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(applicationControllerProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Builder(
            builder: (context) {
              return CustomAppBar(
                title: "Applications",
                subtitle: "Process status tracking",
                showSearchIcon: true,
                showFilterIcon: true,
                onTapFilterIcon: () {
                  ref.read(goRouterProvider).push(
                        AppRoutes.applicationsFilter,
                      );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          state.when(
            data: (data) {
              return Expanded(
            child: _ApplicationsListView(data),
          );
            },
            loading: () => Expanded(
              child: ApplicationsListShimmer(),
            ),
            error: (error, stackTrace) => Expanded(
              child: errorWidget(error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplicationsListView extends StatelessWidget {
  final ApplicationStates  data;
  const _ApplicationsListView(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: data.searchedApplications.length,
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ref, child) {
            final isExpanded = ref.watch(
              applicationControllerProvider.select(
                (state) => state.requireValue.isApplicationsExpanded[index],
              ),
            );
            return GestureDetector(
              onTap: () {
                ref.read(applicationControllerProvider.notifier).onExpand(index);
              },
              child: ApplicationStatusContainer(
                isExpanded: isExpanded,
                application: data.searchedApplications[index],
                index: index,
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
    );
  }
}
