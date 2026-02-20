import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class ApplicationSearchField extends ConsumerStatefulWidget {
  const ApplicationSearchField({super.key});

  @override
  ConsumerState<ApplicationSearchField> createState() =>
      _ApplicationSearchFieldState();
}

class _ApplicationSearchFieldState
    extends ConsumerState<ApplicationSearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // textfield
        Expanded(
          flex: 8,
          child: CustomTextField(
            controller: _searchController,
            hintText: "Search by application ID",
          ),
        ),
        // search button
        Expanded(
          flex: 2,
          child: actionContainer(
            icon: "",
            iconData: Icons.search,
            onTap: () async {
              if (_searchController.text.isEmpty) {
                showSnackBar(context, "Please enter an application ID");
                return;
              }
              String applicationId = _searchController.text.trim();

              bool isValidId = await ref
                  .read(dashboardAsyncControllerProvider.notifier)
                  .validateApplicationId(applicationId);

              if (isValidId) {
                if (context.mounted) {
                  FocusScope.of(context).unfocus();
                }
                _searchController.clear();
                ref
                    .read(goRouterProvider)
                    .push(AppRoutes.applicationDetail(applicationId));
              } else if (context.mounted) {
                showSnackBar(context, "Invalid application ID");
              }
            },
          ),
        ),
      ],
    );
  }
}
