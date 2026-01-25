import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/dashboard/models/module_model.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/features/dashboard/data/module_provider.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class DashboardModulesSection extends ConsumerWidget {
  const DashboardModulesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(modulesProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "All Modules",
            style: AppTextstyles.neutra700black32.copyWith(fontSize: 24),
          ),
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < modules.length; i++)
          _DashboardModuleContainer(
            module: modules[i],
            index: i,
          ),
      ],
    );
  }
}

class _DashboardModuleContainer extends ConsumerWidget {
  final ModuleModel module;
  final int index;
  const _DashboardModuleContainer({required this.module, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(dashboardControllerProvider.notifier);
    final isExpanded = ref.watch(
      dashboardControllerProvider.select((s) => s.isModulesExpanded[index]),
    );
    return Column(
      children: [
        DashboardModuleContainerComponent(
          isModule: true,
          color: module.color,
          icon: module.icon,
          title: module.title,
          isExpanded: isExpanded,
          subtitle: "${module.count} active items",
          count: module.count,
          onTap: () {
            controller.onModuleExpand(index);
          },
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Column(
                  children: [
                    for (var subModule in module.subModules) ...[
                      DashboardModuleContainerComponent(
                        color: module.color,
                        title: subModule.title,
                        subtitle: "${subModule.count} active items",
                        count: subModule.count,
                        onTap: () {
                          ref
                              .read(goRouterProvider)
                              .push(
                                AppRoutes.moduleApplications(
                                  module.title,
                                  subModule.title,
                                ),
                              );
                        },
                      ),
                    ],
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

class DashboardModuleContainerComponent extends StatelessWidget {
  const DashboardModuleContainerComponent({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isExpanded = false,
    this.icon,
    required this.count,
    this.isModule = false,
  });

  final Color color;
  final String? icon;
  final String title;
  final String subtitle;
  final int count;
  final void Function() onTap;
  final bool isExpanded;
  final bool isModule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.4),
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  height: 48,
                  width: 48,
                  // margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.082),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(child: SvgPicture.asset(icon!, color: color)),
                ),
                const SizedBox(width: 16),
              ],
              if (icon == null) const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTextstyles.googleInter500LabelColor14.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTextstyles.googleInter400Grey14.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.082),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "$count",
                      style: AppTextstyles.googleInter700black28.copyWith(
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onTap,
                    icon: AnimatedRotation(
                      turns: !isModule ? -0.25 : (isExpanded ? 0.5 : 0),
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        Icons.expand_more,
                        color: AppColors.expandIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
