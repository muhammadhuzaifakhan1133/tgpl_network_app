import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/common/widgets/custom_searchable_dropdown.dart';
import 'package:tgpl_network/features/dashboard/models/application_suggestions.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class ApplicationSearchField extends ConsumerStatefulWidget {
  const ApplicationSearchField({super.key});

  @override
  ConsumerState<ApplicationSearchField> createState() =>
      _ApplicationSearchFieldState();
}

class _ApplicationSearchFieldState
    extends ConsumerState<ApplicationSearchField> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(dashboardControllerProvider.notifier);
    final searchCategories = controller.searchCategories;
    final selectedSearchCategory = ref.watch(dashboardControllerProvider.select((s) => s.selectedSearchCategory));
    return Row(
      children: [
        // textfield
        Expanded(
          flex: 6,
          child: CustomSearchableDropDown<ApplicationSuggestion>(
            displayString: (item) {
              return "${item.applicationId} - ${item.applicantName} - ${item.proposedSiteName}";
            },
            assignController: (controller) {
              _searchController = controller;
            },
            onChanged: (item) {
              if (item == null) return;
              FocusScope.of(context).unfocus();
              _searchController.clear();
              ref
                    .read(goRouterProvider)
                    .push(AppRoutes.applicationDetail(item.applicationId));
            },
            searchableStrings: (item) => [
              if (selectedSearchCategory == "App ID") item.applicationId,
              if (selectedSearchCategory == "Dealer Name") item.applicantName,
              if (selectedSearchCategory == "Site Name") item.proposedSiteName,
            ],
            hintText: "Search by $selectedSearchCategory",
            asyncItems: (query) {
              if (query.isEmpty) {
                return Future.value([]);
              }
              return controller.fetchSearchSuggestions(
                query,
                searchCategories[selectedSearchCategory]!,
              );
            },
          ),
        ),
        SizedBox(width: 5.w),
        // search button
        // Expanded(
        //   flex: 2,
        //   child: actionContainer(
        //     icon: "",
        //     iconData: Icons.search,
        //     onTap: () async {
        //       if (_searchController.text.isEmpty) {
        //         showSnackBar(context, "Please enter an application ID");
        //         return;
        //       }
        //       String applicationId = _searchController.text.trim();

        //       bool isValidId = await ref
        //           .read(dashboardAsyncControllerProvider.notifier)
        //           .validateApplicationId(applicationId);

        //       if (isValidId) {
        //         if (context.mounted) {
        //           FocusScope.of(context).unfocus();
        //         }
        //         _searchController.clear();
        //         ref
        //             .read(goRouterProvider)
        //             .push(AppRoutes.applicationDetail(applicationId));
        //       } else if (context.mounted) {
        //         showSnackBar(context, "Invalid application ID");
        //       }
        //     },
        //   ),
        // ),
        Expanded(
          flex: 4,
          child: CustomDropDown(
                items: searchCategories.keys.toList(),
                selectedItem: selectedSearchCategory,
                onChanged: (value) {
                  controller.onChangeSearchCategory(value);
                },
              ),
        )
      ],
    );
  }
}
