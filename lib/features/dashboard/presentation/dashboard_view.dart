import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_count_containers.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_greeting_text.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_header_profile.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_module_sections.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/regional_managers_section.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                RegionalManagersSection(),
                const SizedBox(height: 5),
                DashboardModulesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
