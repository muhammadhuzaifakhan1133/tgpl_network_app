import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/master_data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({super.key, required this.user});

  String _getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    for (var part in names) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.nextStep1Color,
                  AppColors.headerDarkBlueColor,
                ],
              ),
            ),
            child: Center(
              child: Text(
                _getInitials(user.userName),
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 24,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName,
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 20,
                    color: AppColors.black2Color,
                  ),
                ),
                // TODO: add position field in user model
                Text(
                  user.fullName,
                  style: AppTextstyles.googleInter400Grey14.copyWith(
                    fontSize: 16,
                    color: AppColors.black2Color,
                  ),
                ),
                Text(
                  "Emp ID: ${user.userId}",
                  style: AppTextstyles.googleInter400Grey14.copyWith(
                    fontSize: 16,
                    color: AppColors.extraInformationColor,
                  ),
                ),
              ],
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 11),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(25),
          //         gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //             AppColors.nextStep1Color,
          //             AppColors.headerDarkBlueColor,
          //           ],
          //         ),
          //       ),
          //       child: Text(
          //         '228',
          //         style: AppTextstyles.googleInter700black28.copyWith(
          //           fontSize: 13,
          //           color: AppColors.white,
          //         ),
          //       ),
          //     ),
          //     Text(
          //       "Completed",
          //       style: AppTextstyles.googleInter500LabelColor14.copyWith(
          //         fontSize: 13,
          //         color: AppColors.black2Color,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
