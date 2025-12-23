import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/common/widgets/custom_searchable_dropdown.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class CustomDropDownWithTitle<T extends Object> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String Function(T item)? displayString;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final bool enableSearch;
  final T? selectedItem;
  final List<String> Function(T)? searchableStrings;
  const CustomDropDownWithTitle({
    super.key,
    required this.title,
    required this.items,
    this.displayString,
    required this.onChanged,
    this.validator,
    this.hintText,
    this.searchableStrings,
    this.enableSearch = false, required this.selectedItem,
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
        if (enableSearch)
          CustomSearchableDropDown(
            items: items,
            onChanged: onChanged,
            initialValue: selectedItem,
            displayString: displayString,
            searchableStrings: searchableStrings,
            validator: validator,
            hintText: hintText,
          )
        else
          CustomDropDown(
            items: items,
            selectedItem: selectedItem,
            onChanged: onChanged,
            displayString: displayString,
            validator: validator,
            hintText: hintText,
          ),
      ],
    );
  }
}
