import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
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
  final bool? enabled;
  final bool isChangeStyleOnDisable;
  final bool obscureText;
  const CustomTextFieldWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.isChangeStyleOnDisable = true,
    this.extraInformation,
    this.multiline = false,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.enabled,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: AppTextstyles.googleJakarta500Grey12),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          obscureText: obscureText,
          enabled: enabled,
          hintText: hintText,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: minLines,
          multiline: multiline,
          suffixIcon: suffixIcon,
          isChangeStyleOnDisable: isChangeStyleOnDisable,
        ),
        if (extraInformation != null) ...[
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              extraInformation!,
              style: AppTextstyles.googleInter400LightGrey12,
            ),
          ),
        ],
      ],
    );
  }
}
