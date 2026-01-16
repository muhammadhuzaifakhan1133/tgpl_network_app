import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

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
  final bool obscureText;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget? hint;
  final void Function()? onTap;
  final bool readOnly;
  final String? title;
  final void Function(String)? onChanged;
  final String? initialValue;
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.validator,
    this.errorText,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.multiline = false,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.obscureText = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.hint,
    this.onTap,
    this.readOnly = false,
    this.title, this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        readOnly: readOnly,
        onChanged: onChanged,
        contextMenuBuilder: readOnly
            ? (context, editableTextState) {
                return AdaptiveTextSelectionToolbar.buttonItems(
                  anchors: editableTextState.contextMenuAnchors,
                  buttonItems: [
                    ContextMenuButtonItem(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: hintText ?? ""));
                        showSnackBar(context, "Copied to clipboard");
                      },
                      label: 'Copy',
                    ),
                    // view detail
                    ContextMenuButtonItem(
                      onPressed: () {
                        _showReadOnlyFieldContent(
                          context,
                          title ?? "",
                          hintText ?? "",
                        );
                      },
                      label: 'View Full Text',
                    ),
                  ],
                );
              }
            : null,
        onTap: onTap,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          hint: hint,
          filled: backgroundColor != null ? true : false,
          hintText: hintText,

          errorText: errorText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
        keyboardType: multiline ? TextInputType.multiline : keyboardType,
        textInputAction: multiline
            ? TextInputAction.newline
            : (textInputAction ?? TextInputAction.next),

        minLines: multiline ? (minLines ?? 3) : 1,
        maxLines: multiline ? (maxLines ?? 5) : 1,
        onFieldSubmitted: (_) => onFieldSubmitted?.call(),
      ),
    );
  }

  void _showReadOnlyFieldContent(
    BuildContext context,
    String title,
    String value,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              SingleChildScrollView(
                child: SelectableText(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
