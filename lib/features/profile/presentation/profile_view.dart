import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/account_settings_section.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/contact_information_section.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/profile_header.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/support_section.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).value;
    if (user == null) {
      return Center(
        child: Text('No user information available.'),
      );
    }
    return Column(
      children: [
        ProfileHeader(user: user),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 30),
              ContactInformationSection(user: user),
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
