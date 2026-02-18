import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/routes/app_router.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item)? displayString;
  final void Function(T?)? onChanged;
  final void Function(List<T>)? onMultiChanged;
  final String? Function(T?)? validator;
  final String? Function(List<T>)? multiValidator;
  final String? hintText;
  final T? selectedItem;
  final List<T>? selectedItems;
  final bool isMultiSelect;
  final int? maxSelection;
  final bool showClearButton;
  final VoidCallback? onClear;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextStyle Function(T item)? itemTextStyle;

  const CustomDropDown({
    super.key,
    required this.items,
    this.displayString,
    this.onChanged,
    this.onMultiChanged,
    this.validator,
    this.multiValidator,
    this.hintText,
    this.selectedItem,
    this.selectedItems,
    this.isMultiSelect = false,
    this.maxSelection,
    this.showClearButton = false,
    this.onClear,
    this.backgroundColor,
    this.textStyle,
    this.itemTextStyle,
  }) : assert(isMultiSelect ? onMultiChanged != null : onChanged != null);

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  List<T> _selectedItems = [];
  final TextEditingController _textController = TextEditingController();
  String? _validationError;

  bool get _hasValue => widget.isMultiSelect
      ? _selectedItems.isNotEmpty
      : widget.selectedItem != null;

  @override
  void initState() {
    super.initState();
    if (widget.isMultiSelect && widget.selectedItems != null) {
      _selectedItems = List.from(widget.selectedItems!);
      _updateDisplayText();
    }
  }

  void _updateDisplayText() {
    if (_selectedItems.isEmpty) {
      _textController.clear();
    } else {
      _textController.text = _selectedItems
          .map(
            (e) => widget.displayString != null
                ? widget.displayString!(e)
                : e.toString(),
          )
          .join(', ');
    }
  }

  void _clear() {
    setState(() {
      _selectedItems.clear();
      _textController.clear();
      _validationError = null;
    });
    widget.onChanged?.call(null);
    widget.onMultiChanged?.call([]);
    widget.onClear?.call();
  }

  bool get _hasError => _validationError != null;

  @override
  Widget build(BuildContext context) {
    if (widget.isMultiSelect) {
      return FormField<List<T>>(
        validator: (value) {
          final error = widget.multiValidator?.call(_selectedItems);
          // Schedule setState for after the validation completes
          if (_validationError != error) {
            setState(() {
              _validationError = error;
            });
          }
          return error;
        },
        builder: (state) {
          return SizedBox(
            height: _hasError ? 70.h : 46.h,
            child: InkWell(
              onTap: showMultiSelectDialog,
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  errorText: state.errorText,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  suffixIcon: widget.showClearButton && _hasValue
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _clear,
                        )
                      : const Icon(Icons.arrow_drop_down),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  _selectedItems.isEmpty
                      ? widget.hintText ?? ''
                      : _textController.text,
                  overflow: TextOverflow.ellipsis,
                  style: widget.textStyle,
                ),
              ),
            ),
          );
        },
      );
    }

    return SizedBox(
      height: _hasError ? 70.h : 46.h,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        value: widget.selectedItem,
        items: widget.items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  widget.displayString != null
                      ? widget.displayString!(item)
                      : item.toString(),
                  style: widget.itemTextStyle != null
                      ? widget.itemTextStyle!(item)
                      : widget.textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
            .toList(),
        onChanged: widget.onChanged,
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
        style: widget.selectedItem != null && widget.itemTextStyle != null
            ? widget.itemTextStyle!(widget.selectedItem!)
            : widget.textStyle,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: widget.backgroundColor,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          maintainHintSize: false,
          filled: widget.backgroundColor != null,
          suffixIcon: widget.showClearButton && _hasValue
              ? IconButton(icon: const Icon(Icons.close), onPressed: _clear)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      ),
    );
  }

  void showMultiSelectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final tempSelectedItems = List<T>.from(_selectedItems);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Items'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.items.map((item) {
                    final isSelected = tempSelectedItems.contains(item);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(
                        widget.displayString != null
                            ? widget.displayString!(item)
                            : item.toString(),
                      ),
                      onChanged: (selected) {
                        setState(() {
                          if (selected == true) {
                            if (widget.maxSelection == null ||
                                tempSelectedItems.length <
                                    widget.maxSelection!) {
                              tempSelectedItems.add(item);
                            }
                          } else {
                            tempSelectedItems.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                Consumer(
                  builder: (context, ref, _) {
                    return TextButton(
                      onPressed: () {
                        ref.read(goRouterProvider).pop();
                      },
                      child: const Text('Cancel'),
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, _) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedItems = tempSelectedItems;
                          _updateDisplayText();
                        });
                        widget.onMultiChanged?.call(_selectedItems);
                        ref.read(goRouterProvider).pop();
                      },
                      child: const Text('OK'),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
