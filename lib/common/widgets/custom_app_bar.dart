import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final bool showSearchIcon;
  final bool showFilterIcon;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    this.showSearchIcon = false,
    this.showFilterIcon = false,
  });

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  bool isSearchFieldActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        children: [
          if (widget.showBackButton)
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.actionContainerColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ),
          const SizedBox(width: 12),
          if (!isSearchFieldActive)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: AppTextstyles.googleInter700black28.copyWith(
                            fontSize: 20,
                            color: AppColors.black2Color,
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: AppTextstyles.googleInter400Grey14.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (widget.showSearchIcon)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearchFieldActive = true;
                            });
                            print(isSearchFieldActive);
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.actionContainerColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: AppColors.subHeadingColor,
                              ),
                            ),
                          ),
                        ),
                      if (widget.showFilterIcon) ...[
                        const SizedBox(width: 8),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColors.actionContainerColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.filter_alt_outlined,
                              color: AppColors.subHeadingColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          if (isSearchFieldActive)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Search",
                      height: 50,
                      backgroundColor: AppColors.actionContainerColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearchFieldActive = false;
                      });
                    },
                    child: SvgPicture.asset(AppImages.crossIconSvg, height: 40),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
