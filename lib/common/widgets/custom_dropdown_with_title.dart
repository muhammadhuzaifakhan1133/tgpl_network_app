import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/common/widgets/custom_searchable_dropdown.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class CustomDropDownWithTitle extends StatelessWidget {
  final String title;
  final List<Object> items;
  final String Function(Object item)? showItem;
  final void Function(Object?) onChanged;
  final String? Function(Object?)? validator;
  final String? hintText;
  final bool enableSearch;
  final Object? selectedItem;
  const CustomDropDownWithTitle({
    super.key,
    required this.title,
    required this.items,
    this.showItem,
    required this.onChanged,
    this.validator,
    this.hintText,
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
            selectedItem: selectedItem,
            showItem: showItem,
            validator: validator,
            hintText: hintText,
          )
        else
          CustomDropDown(
            items: items,
            selectedItem: selectedItem,
            onChanged: onChanged,
            showItem: showItem,
            validator: validator,
            hintText: hintText,
          ),
      ],
    );
  }
}
