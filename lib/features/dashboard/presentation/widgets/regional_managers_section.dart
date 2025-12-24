import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_regional_manager_card.dart';

class RegionalManagersSection extends StatelessWidget {
  const RegionalManagersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Regional Managers",
          style: AppTextstyles.neutra700black32.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 5),
        DashboardRegionalManagerCard(region: "Karachi Region", count: 52),
        DashboardRegionalManagerCard(region: "Lahore Region", count: 34),
        DashboardRegionalManagerCard(region: "Hyderabad Region", count: 28),
        DashboardRegionalManagerCard(region: "Sukkur Region", count: 10),
      ],
    );
  }
}
