import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';
import 'package:tgpl_network/features/home_shell/presentation/widgets/nav_item.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class HomeShellView extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const HomeShellView({super.key, required this.navigationShell});

  void onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(snackbarMessageProvider, (prev, next) {
      final message = next;
      if (message != null && message.isNotEmpty) {
        showSnackBar(context, message);
        // Clear the message after showing
        Future.microtask(() {
          ref.read(snackbarMessageProvider.notifier).state = null;
        });
      }
    });
    final state = ref.watch(homeShellControllerProvider);
    bool isLoading = state.isLoading;
    return Scaffold(
      body: navigationShell,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavItem(
              index: 0,
              iconPath: AppImages.dashboardInactiveSvg,
              label: "Dashboard",
              isLoading: isLoading,
              context: context,
              navigationShell: navigationShell,
              onTap: onTap,
            ),
            buildNavItem(
              index: 1,
              iconPath: AppImages.applicationsInactiveSvg,
              label: "Application",
              isLoading: isLoading,
              context: context,
              navigationShell: navigationShell,
              onTap: onTap,
            ),
            buildNavItem(
              index: 2,
              iconPath: AppImages.mapInactiveSvg,
              label: "Map",
              isLoading: isLoading,
              context: context,
              navigationShell: navigationShell,
              onTap: onTap,
            ),
            buildNavItem(
              index: 3,
              iconPath: "",
              iconWidget: Icon(
                Icons.cloud_sync_sharp,
                color: navigationShell.currentIndex == 3
                    ? AppColors.primary
                    : AppColors.grey,
                size: 20,
              ),
              label: "Sync Data",
              isLoading: isLoading,
              context: context,
              navigationShell: navigationShell,
              onTap: onTap,
            ),
            buildNavItem(
              index: 4,
              iconPath: AppImages.profileInactiveSvg,
              label: "Profiles",
              isLoading: isLoading,
              context: context,
              navigationShell: navigationShell,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
