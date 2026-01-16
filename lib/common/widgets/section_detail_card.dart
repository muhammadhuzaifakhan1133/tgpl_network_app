import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class SectionDetailCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onToggleExpanded;
  final bool? isExpanded;
  const SectionDetailCard({
    required this.title,
    required this.children,
    this.onToggleExpanded,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final Widget title = Text(
      this.title,
      style: AppTextstyles.googleInter700black28.copyWith(
        fontSize: 24,
        color: AppColors.black2Color,
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isExpanded != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title,
                IconButton(
                  icon: Icon(
                    isExpanded! ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: onToggleExpanded,
                ),
              ],
            ),
          if (isExpanded == null) title,
          const SizedBox(height: 10),
          if (isExpanded ?? true) ...[...children],
        ],
      ),
    );
  }
}
