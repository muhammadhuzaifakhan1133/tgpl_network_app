import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/app_status_category.dart';
import 'package:tgpl_network/common/widgets/custom_searchable_dropdown.dart';
import 'package:tgpl_network/features/dashboard/models/application_suggestions.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class ApplicationSearchField extends ConsumerWidget {
  ApplicationSearchField({super.key});
  
  late final TextEditingController _searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(dashboardControllerProvider.notifier);
    return Row(
      children: [
        // textfield
        Expanded(
          child: CustomSearchableDropDown<ApplicationSuggestion>(
            displayString: (item) {
              return "(${item.applicationId}) - ${item.applicantName} - ${item.proposedSiteName}";
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
            hintText: "App. ID, Dealer, Site Name, Contact #.",
            asyncItems: (query) {
              if (query.isEmpty) {
                return Future.value([]);
              }
              return controller.fetchSearchSuggestions(query);
            },
            optionIndicatorColor: (item) =>
                AppStatusCategory.getColorForStatusId(item.statusId),
          ),
        ),
      ],
    );
  }
}
