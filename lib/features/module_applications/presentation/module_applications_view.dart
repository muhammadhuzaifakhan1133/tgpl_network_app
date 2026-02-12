import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/empty_applications_view.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/module_applications/presentation/module_applications_controller.dart';
import 'package:tgpl_network/features/module_applications/presentation/widgets/module_application_container.dart';
import 'package:tgpl_network/features/module_applications/presentation/widgets/module_applications_shimmer.dart';

class ModuleApplicationsView extends ConsumerStatefulWidget {
  final SubModuleModel subModule;
  const ModuleApplicationsView({super.key, required this.subModule});

  @override
  ConsumerState<ModuleApplicationsView> createState() =>
      _ModuleApplicationsViewState();
}

class _ModuleApplicationsViewState
    extends ConsumerState<ModuleApplicationsView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref
            .read(
              moduleApplicationsAsyncControllerProvider(
                widget.subModule,
              ).notifier,
            )
            .fetchMoreApplications();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Builder(
              builder: (context) {
                final controller = ref.watch(
                  moduleApplicationsAsyncControllerProvider(
                    widget.subModule,
                  ).notifier,
                );
                return _moduleApplicationCustomBar(
                  onSearch: controller.onSearchQueryChanged,
                  onCrossSearch: controller.clearSearch,
                );
              },
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(
                    moduleApplicationsAsyncControllerProvider(widget.subModule),
                  );

                  return state.when(
                    skipLoadingOnRefresh: false,
                    data: (data) {
                      if (data.applications.isEmpty) {
                        return ApplicationsEmptyState(
                          reason: data.searchQuery?.isNotEmpty ?? false
                              ? EmptyApplicationsReason.noSearchResults
                              : EmptyApplicationsReason.noData,
                          onClearFilters: () {
                            _searchController.clear();
                            final controller = ref.read(
                              moduleApplicationsAsyncControllerProvider(
                                widget.subModule,
                              ).notifier,
                            );
                            controller.clearSearch();
                          },
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(
                            moduleApplicationsAsyncControllerProvider(
                              widget.subModule,
                            ),
                          );
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              data.applications.length +
                              (data.hasMoreData ? 1 : 0),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemBuilder: (context, index) {
                            if (index == data.applications.length) {
                              return const ModuleApplicationShimmerCard();
                            }
                            return ModuleApplicationContainer(
                              application: data.applications[index],
                              submoduleName: widget.subModule.title,
                            );
                          },
                        ),
                      );
                    },
                    error: (e, s) => errorWidget(e.toString()),
                    loading: () => ModuleApplicationsShimmer(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar _moduleApplicationCustomBar({
    required Function(String) onSearch,
    required VoidCallback onCrossSearch,
  }) {
    return CustomAppBar(
      title: "Applications (${widget.subModule.count})",
      subtitle: "",
      showBackButton: true,
      onSearchChanged: onSearch,
      onCrossSearch: onCrossSearch,
      onCancelSearchField: onCrossSearch,
      controller: _searchController,
      subtitleWidget: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: widget.subModule.moduleName,
              style: AppTextstyles.googleInter400Grey14.copyWith(
                decoration: TextDecoration.underline,
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: ' / ',
              style: AppTextstyles.googleInter400Grey14.copyWith(
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: widget.subModule.title,
              style: AppTextstyles.googleInter400Grey14.copyWith(
                decoration: TextDecoration.underline,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
      showSearchIcon: true,
      showFilterIcon: false,
    );
  }
}
