import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<Object> items;
  final String Function(Object item)? showItem;
  final void Function(Object?) onChanged;
  final String? Function(Object?)? validator;
  final String? hintText;
  final Object? selectedItem;
  const CustomDropDown({super.key, required this.items, this.showItem, required this.onChanged, this.validator, this.hintText, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Object>(
      initialValue: selectedItem,
      items: items.map((item) => DropdownMenuItem<Object>(
        value: item,
        child: Text(showItem != null ? showItem!(item) : item.toString()))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }
}
