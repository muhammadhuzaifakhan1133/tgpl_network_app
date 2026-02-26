import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/audit_template_selection/presentation/audit_template_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class AuditTemplateSelectionView extends ConsumerWidget {
  const AuditTemplateSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(auditTemplateControllerProvider.notifier);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: "Select a template",
              subtitle: "",
              subtitleWidget: SizedBox.shrink(),
              showBackButton: true,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Search templates",
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20.w,
                        color: AppColors.grey,
                      ),
                      onChanged: (value) {
                        controller.filterTemplates(value);
                      },
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, _) {
                          final templates = ref.watch(
                            auditTemplateControllerProvider,
                          );
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: templates.length,
                            itemBuilder: (context, index) {
                              final template = templates[index];
                              return _auditTemplateCard(
                                icon: template.icon,
                                label: template.label,
                                description: template.description,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _auditTemplateCard({
    required IconData icon,
    required String label,
    required String description,
  }) {
    return Card(
      color: AppColors.white,
      child: Consumer(
        builder: (context, ref, _) {
          return ListTile(
            leading: Container(
              height: 45.h,
              width: 45.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Icon(icon, size: 22.w, color: AppColors.primary),
              ),
            ),
            title: Text(label),
            subtitle: Text(description),
            onTap: () {
              ref.read(goRouterProvider).push(AppRoutes.auditPerform);
            },
          );
        }
      ),
    );
  }
}
