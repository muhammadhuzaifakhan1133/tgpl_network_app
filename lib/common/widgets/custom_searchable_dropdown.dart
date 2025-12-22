import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomSearchableDropDown extends StatelessWidget {
  final List<Object> items;
  final Object? selectedItem;
  final String Function(Object item)? showItem;
  final void Function(Object?) onChanged;
  final String? Function(Object?)? validator;
  final String? hintText;
  const CustomSearchableDropDown({super.key, required this.items, this.showItem, required this.onChanged, this.validator, this.hintText, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Object>(
      items:(filter, loadProps) => items,
      compareFn: (item1, item2) {
        return item1 == item2;
      },
      selectedItem: selectedItem,
      onChanged: onChanged,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      ),
      validator: validator,
    );
  }
}
