import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class ApplicationsEmptyState extends StatelessWidget {
  final EmptyApplicationsReason reason;
  final VoidCallback? onClearFilters;

  const ApplicationsEmptyState({
    super.key,
    required this.reason,
    this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final config = _stateConfig(reason);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: config.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                config.icon,
                size: 64,
                color: config.color,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              config.title,
              style: AppTextstyles.googleInter700black28.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              config.subtitle,
              style: AppTextstyles.neutra500grey12.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            _buildActions(config),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(_EmptyStateConfig config) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: config.actions,
    );
  }

  _EmptyStateConfig _stateConfig(EmptyApplicationsReason reason) {
    switch (reason) {
      case EmptyApplicationsReason.noSearchResults:
        return _EmptyStateConfig(
          icon: Icons.search_off_rounded,
          color: AppColors.primary,
          title: "No results found",
          subtitle: "Try adjusting your search or filters.",
          actions: [
            if (onClearFilters != null)
              OutlinedButton.icon(
                onPressed: onClearFilters,
                icon: const Icon(Icons.clear),
                label: const Text("Clear filters"),
              ),
          ],
        );

      
      case EmptyApplicationsReason.noData:
        return _EmptyStateConfig(
          icon: Icons.folder_open_rounded,
          color: AppColors.primary,
          title: "No applications yet",
          subtitle: "Start by syncing data or creating a new application.",
          actions: [],
        );
    }
  }
}

class _EmptyStateConfig {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  _EmptyStateConfig({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.actions,
  });
}

enum EmptyApplicationsReason {
  noData,
  noSearchResults,
}
