import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;
  final TextInputType? keyboardType;
  final bool multiline;
  final int? minLines;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool isChangeStyleOnDisable;
  final bool obscureText;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.validator,
    this.errorText,
    this.isChangeStyleOnDisable = true,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.multiline = false,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.enabled,
    this.obscureText = false,
    this.width,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isMultiline = multiline;
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: backgroundColor != null ? true : false,
          hintText: hintText,
          errorText: errorText,
          suffixIcon: suffixIcon,
          disabledBorder: isChangeStyleOnDisable
              ? null
              : OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
        keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
        textInputAction: isMultiline
            ? TextInputAction.newline
            : (textInputAction ?? TextInputAction.next),

        minLines: isMultiline ? (minLines ?? 3) : 1,
        maxLines: isMultiline ? (maxLines ?? 5) : 1,
        onFieldSubmitted: (_) => onFieldSubmitted?.call(),
      ),
    );
  }
}
