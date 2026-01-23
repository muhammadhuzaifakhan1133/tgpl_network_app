import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/sync_status_provider.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_count_containers.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_greeting_text.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_header_profile.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_module_sections.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/sync_status_widget.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/features/home_shell/presentation/home_shell_controller.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeShellControllerProvider);
    if (homeState.isLoading) {
      return DashboardShimmerView();
    }
    final dashboardState = ref.watch(dashboardAsyncControllerProvider);
    bool isLoading = dashboardState.isLoading;
    if (isLoading) {
      return DashboardShimmerView();
    }
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              DashboardHeaderProfile(),
              const SizedBox(height: 30),
              DashboardGreetingText(),
              const SizedBox(height: 10),
              DashboardCountContainers(),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              // RegionalManagersSection(),
              Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(syncStatusProvider);
                  return state.when(
                    data: (state) => SyncStatusCard(
                      status: state.status,
                      lastSyncTime: state.lastSyncTime,
                      onResync: () {
                        ref.read(syncStatusProvider.notifier).resyncData();
                      },
                    ),
                    loading: () => SyncStatusCard(
                      status: SyncStatus.syncing,
                      lastSyncTime: state.value?.lastSyncTime ?? "Never",
                    ),
                    error: (e, st) => SyncStatusCard(
                      status: SyncStatus.offline,
                      lastSyncTime: state.value?.lastSyncTime ?? "Never",
                      onResync: () {
                        ref.read(syncStatusProvider.notifier).resyncData();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              DashboardModulesSection(),
            ],
          ),
        ),
      ],
    );
  }
}
