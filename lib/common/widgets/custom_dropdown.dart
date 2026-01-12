import 'package:flutter/material.dart';

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
  }) : assert(
          isMultiSelect ? onMultiChanged != null : onChanged != null,
          'Provide onMultiChanged for multi-select or onChanged for single-select',
        );

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  List<T> _selectedItems = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isMultiSelect && widget.selectedItems != null) {
      _selectedItems = List.from(widget.selectedItems!);
      _updateDisplayText();
    }
  }

  @override
  void didUpdateWidget(CustomDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMultiSelect && widget.selectedItems != oldWidget.selectedItems) {
      _selectedItems = List.from(widget.selectedItems ?? []);
      _updateDisplayText();
    }
  }

  void _updateDisplayText() {
    if (_selectedItems.isEmpty) {
      _textController.clear();
    } else {
      final displayTexts = _selectedItems.map((item) {
        return widget.displayString != null
            ? widget.displayString!(item)
            : item.toString();
      }).toList();
      _textController.text = displayTexts.join(', ');
    }
  }

  void _showMultiSelectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(widget.hintText ?? 'Select Items'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    final isSelected = _selectedItems.contains(item);
                    final displayText = widget.displayString != null
                        ? widget.displayString!(item)
                        : item.toString();

                    return CheckboxListTile(
                      title: Text(displayText),
                      value: isSelected,
                      onChanged: (bool? checked) {
                        setDialogState(() {
                          if (checked == true) {
                            if (widget.maxSelection == null ||
                                _selectedItems.length < widget.maxSelection!) {
                              _selectedItems.add(item);
                            }
                          } else {
                            _selectedItems.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedItems.clear();
                      _updateDisplayText();
                    });
                    Navigator.of(context).pop();
                    widget.onMultiChanged?.call(_selectedItems);
                  },
                  child: const Text('Clear'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _updateDisplayText();
                    });
                    Navigator.of(context).pop();
                    widget.onMultiChanged?.call(_selectedItems);
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMultiSelect) {
      return FormField<List<T>>(
        validator: (value) =>
            widget.multiValidator?.call(_selectedItems),
        initialValue: _selectedItems,
        builder: (FormFieldState<List<T>> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _showMultiSelectDialog,
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    errorText: state.errorText,
                  ),
                  child: Text(
                    _selectedItems.isEmpty
                        ? ''
                        : _textController.text,
                    style: _selectedItems.isEmpty
                        ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).hintColor,
                            )
                        : null,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    // Single select mode (original functionality)
    return DropdownButtonFormField<T>(
      isExpanded: true,
      isDense: true,
      value: widget.selectedItem,
      items: widget.items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                widget.displayString != null
                    ? widget.displayString!(item)
                    : item.toString(),
              ),
            ),
          )
          .toList(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: widget.validator,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

// Example usage:
/*
// Single Select
CustomDropDown<String>(
  items: ['Option 1', 'Option 2', 'Option 3'],
  hintText: 'Select an option',
  selectedItem: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)

// Multi Select
CustomDropDown<String>(
  items: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  hintText: 'Select multiple options',
  selectedItems: selectedValues,
  isMultiSelect: true,
  maxSelection: 3, // Optional: limit number of selections
  onMultiChanged: (values) {
    setState(() {
      selectedValues = values;
    });
  },
  multiValidator: (values) {
    if (values == null || values.isEmpty) {
      return 'Please select at least one option';
    }
    return null;
  },
)
*/