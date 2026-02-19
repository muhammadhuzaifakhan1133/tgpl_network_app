import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? extraInformation;
  final bool multiline;
  final int? minLines;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool showClearButton;
  final VoidCallback? onClear;
  final bool isRequired;
  final bool greyedOutWhenReadOnly;

  const CustomTextFieldWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.extraInformation,
    this.multiline = false,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.initialValue,
    this.showClearButton = false,
    this.onClear,
    this.isRequired = false,
    this.greyedOutWhenReadOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(title, style: AppTextstyles.googleJakarta500Grey12),
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextstyles.googleJakarta500Grey12,
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: AppTextstyles.googleJakarta500Grey12.copyWith(
                    color: Colors.red,
                    fontSize: 14.sp,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          multiline: multiline,
          minLines: minLines,
          maxLines: maxLines,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          initialValue: initialValue,
          title: title,
          showClearButton: showClearButton,
          onClear: onClear,
          backgroundColor: readOnly && greyedOutWhenReadOnly
              ? AppColors.grey[100]
              : null,
        ),
        if (extraInformation != null) ...[
          SizedBox(height: 2.h),
          Text(
            extraInformation!,
            style: AppTextstyles.googleInter400LightGrey12,
          ),
        ],
      ],
    );
  }
}
