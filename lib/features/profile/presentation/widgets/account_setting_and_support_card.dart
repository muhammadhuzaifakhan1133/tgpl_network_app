import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class AccountSettingAndSupportCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final bool colorTitle;
  final void Function() onTap;
  const AccountSettingAndSupportCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.colorTitle = false, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.4),
                color: color.withOpacity(0.082),
              ),
              child: Center(child: SvgPicture.asset(icon, color: color)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextstyles.googleInter500LabelColor14.copyWith(
                  fontSize: 15,
                  color: colorTitle ? color : AppColors.black2Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
