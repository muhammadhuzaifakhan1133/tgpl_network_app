import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_search/dashboard_search_controller.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_module_sections.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class DashboardSearchView extends ConsumerWidget {
  const DashboardSearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(dashboardSearchControllerProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.updateSearchResults("");
                    ref.read(goRouterProvider).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Search modules and sub-modules',
                    onChanged: controller.updateSearchResults,
                    showClearButton: true,
                    autoFocus: true,
                    backgroundColor: AppColors.actionContainerColor,
                    onClear: () {
                      controller.updateSearchResults("");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final searchResults = ref.watch(
                    dashboardSearchControllerProvider,
                  );
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final subModule = searchResults[index];
                      return DashboardModuleContainerComponent(
                        color: subModule.moduleColor,
                        icon: subModule.moduleIcon,
                        title: subModule.title,
                        subtitle: subModule.moduleName,
                        count: subModule.count,
                        onTap: () {
                          ref
                              .read(goRouterProvider)
                              .push(AppRoutes.moduleApplications, extra: subModule);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
