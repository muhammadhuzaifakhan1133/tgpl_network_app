import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
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
  final bool showClearButton;
  final VoidCallback? onClear;
  final bool autoFocus;

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
    this.title,
    this.onChanged,
    this.initialValue,
    this.showClearButton = false,
    this.onClear,
    this.autoFocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _internalController;
  late FocusNode _effectiveFocusNode;
  String? _validationError;

  @override
  void initState() {
    super.initState();
    _internalController =
        widget.controller ??
        TextEditingController(text: widget.initialValue ?? '');

    _effectiveFocusNode = widget.focusNode ?? FocusNode();
  }

  bool get _hasValue => _internalController.text.isNotEmpty;
  bool get _hasError => _validationError != null || widget.errorText != null;

  Widget? _buildSuffixIcon() {
    if (widget.showClearButton && (_hasValue || widget.readOnly)) {
      return IconButton(
        icon: Icon(Icons.close, size: 18.w),
        splashRadius: 18.r,
        onPressed: () {
          widget.onClear?.call();

          _internalController.clear();
          widget.onChanged?.call('');
          setState(() {
            _validationError = null; // Clear validation error
          });

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _effectiveFocusNode.requestFocus();
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _effectiveFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        _internalController.dispose();
      }
      _internalController =
          widget.controller ??
          TextEditingController(text: widget.initialValue ?? '');
    }

    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        _effectiveFocusNode.dispose();
      }
      _effectiveFocusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height:
          widget.height ??
          (widget.multiline ? null : (_hasError ? 70.h : 46.h)),
      child: TextFormField(
        controller: _internalController,
        autofocus: widget.autoFocus,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        focusNode: _effectiveFocusNode,
        onChanged: (v) {
          widget.onChanged?.call(v);
        },
        decoration: InputDecoration(
          fillColor: widget.backgroundColor,
          filled: widget.backgroundColor != null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: widget.multiline ? 12.h : 0,
          ),
          hint: widget.hint,
          hintText: widget.hintText,
          errorText: widget.errorText,
          suffixIcon: _buildSuffixIcon(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        validator: (value) {
          final error = widget.validator?.call(value);
          // Schedule setState for after the validation completes
          if (_validationError != error) {
            setState(() {
              _validationError = error;
            });
          }
          return error;
        },
        keyboardType: widget.multiline
            ? TextInputType.multiline
            : widget.keyboardType,
        textInputAction: widget.multiline
            ? TextInputAction.newline
            : (widget.textInputAction ?? TextInputAction.next),
        minLines: widget.multiline ? (widget.minLines ?? 3) : 1,
        maxLines: widget.multiline ? (widget.maxLines ?? 5) : 1,
        onFieldSubmitted: (_) {
          FocusScope.of(context).nextFocus();
          widget.onFieldSubmitted?.call();
        },
      ),
    );
  }
}
