import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/empty_applications_view.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/applications/presentation/widgets/application_status_container.dart';
import 'package:tgpl_network/features/applications/presentation/widgets/applications_shimmer_widget.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class ApplicationsView extends ConsumerStatefulWidget {
  const ApplicationsView({super.key});

  @override
  ConsumerState<ApplicationsView> createState() => _ApplicationsViewState();
}

class _ApplicationsViewState extends ConsumerState<ApplicationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref
            .read(applicationControllerProvider.notifier)
            .fetchMoreApplications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                showFilterIcon: true,
                onTapFilterIcon: () async {
                  final result = await ref
                      .read(goRouterProvider)
                      .push(AppRoutes.applicationsFilter);
                  if (result != null) {
                    // filter applied or reset
                    ref.invalidate(applicationControllerProvider);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 10),
          state.when(
            skipLoadingOnRefresh: false,
            data: (data) {
              return Expanded(
                child: _ApplicationsListView(
                  data,
                  scrollController: _scrollController,
                ),
              );
            },
            loading: () => Expanded(child: ApplicationsListShimmer()),
            error: (error, stackTrace) =>
                Expanded(child: errorWidget(error.toString())),
          ),
        ],
      ),
    );
  }
}

class _ApplicationsListView extends ConsumerWidget {
  final ApplicationStates data;
  final ScrollController scrollController;
  const _ApplicationsListView(this.data, {required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (data.applications.isEmpty) {
      return ApplicationsEmptyState(
        reason: data.filter.hasActiveFilters
            ? EmptyApplicationsReason.noSearchResults
            : EmptyApplicationsReason.noData,
        onClearFilters: () {
          ref.read(applicationControllerProvider.notifier).clearFilters();
          ref.invalidate(applicationControllerProvider);
        },
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(applicationControllerProvider);
      },
      child: ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: data.applications.length + (data.hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == data.applications.length) {
            return ApplicationStatusShimmerCard();
          }
          return Consumer(
            builder: (context, ref, child) {
              final isExpanded = ref.watch(
                applicationControllerProvider.select(
                  (state) => state.requireValue.isApplicationsExpanded[index],
                ),
              );
              return GestureDetector(
                onTap: () {
                  ref
                      .read(applicationControllerProvider.notifier)
                      .onExpand(index);
                },
                child: ApplicationStatusContainer(
                  isExpanded: isExpanded,
                  application: data.applications[index],
                  index: index,
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
      ),
    );
  }
}
