import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
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
      return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Center(child: Text('No user information available.')),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            showBackButton: true,
            title: "Profile",
            subtitle: "Manage your profile information",
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                ProfileHeader(user: user),
                SizedBox(height: 30.h),
                ContactInformationSection(user: user),
                SizedBox(height: 28.h),
                AccountSettingsSection(),
                SizedBox(height: 28.h),
                SupportSection(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
