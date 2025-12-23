import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class NextStepOrHelpContainer extends StatelessWidget {
  final String? step;
  final String? icon;
  final Color color;
  final String title;
  final String subtitle;
  const NextStepOrHelpContainer({
    super.key,
    this.step,
    this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.4)),
      shadowColor: AppColors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.5, horizontal: 8),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color.withOpacity(0.082),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: step != null
                    ? Text(
                        step!,
                        style: AppTextstyles.googleInter700black28.copyWith(
                          fontSize: 18,
                          color: color,
                        ),
                      )
                    : SvgPicture.asset(icon!, color: color),
              ),
            ),
            const SizedBox(width: 15.5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 13,
                      color: AppColors.black2Color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextstyles.googleInter400Grey14.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
