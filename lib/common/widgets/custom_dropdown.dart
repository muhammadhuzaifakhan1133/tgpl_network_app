import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item)? displayString;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final T? selectedItem;
  const CustomDropDown({
    super.key,
    required this.items,
    this.displayString,
    required this.onChanged,
    this.validator,
    this.hintText,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      isDense: true,
      initialValue: selectedItem,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                displayString != null ? displayString!(item) : item.toString(),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }
}
