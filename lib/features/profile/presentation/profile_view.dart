import 'package:flutter/material.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/account_settings_section.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/contact_information_section.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/profile_header.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/support_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 30),
              ContactInformationSection(),
              const SizedBox(height: 28),
              AccountSettingsSection(),
              const SizedBox(height: 28),
              SupportSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}
