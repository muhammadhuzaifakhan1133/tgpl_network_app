import 'package:flutter/material.dart';

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
  final bool showClearWhenReadOnly;

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
    this.showClearWhenReadOnly = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.controller?.text ??
        widget.initialValue ??
        '';

    widget.controller?.addListener(_controllerListener);
  }

  void _controllerListener() {
    setState(() {
      _currentValue = widget.controller?.text ?? '';
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_controllerListener);
    super.dispose();
  }

  bool get _hasValue => _currentValue.isNotEmpty;

  Widget? _buildSuffixIcon() {
    if (widget.showClearButton &&
        widget.onClear != null &&
        _hasValue &&
        (widget.showClearWhenReadOnly || !widget.readOnly)) {
      return IconButton(
        icon: const Icon(Icons.close, size: 18),
        splashRadius: 18,
        onPressed: () {
          widget.onClear?.call();

          if (widget.controller == null) {
            setState(() {
              _currentValue = '';
            });
          }
        },
      );
    }
    return widget.suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.controller == null ? widget.initialValue : null,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        focusNode: widget.focusNode,
        onChanged: (v) {
          if (widget.controller == null) {
            setState(() {
              _currentValue = v;
            });
          }
          widget.onChanged?.call(v);
        },
        decoration: InputDecoration(
          fillColor: widget.backgroundColor,
          filled: widget.backgroundColor != null,
          hint: widget.hint,
          hintText: widget.hintText,
          errorText: widget.errorText,
          suffixIcon: _buildSuffixIcon(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: widget.validator,
        keyboardType:
            widget.multiline ? TextInputType.multiline : widget.keyboardType,
        textInputAction: widget.multiline
            ? TextInputAction.newline
            : (widget.textInputAction ?? TextInputAction.next),
        minLines: widget.multiline ? (widget.minLines ?? 3) : 1,
        maxLines: widget.multiline ? (widget.maxLines ?? 5) : 1,
        onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
      ),
    );
  }
}
