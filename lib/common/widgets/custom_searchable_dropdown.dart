import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';

class CustomSearchableDropDown<T extends Object> extends StatelessWidget {
  final List<T> items;

  /// What to show in the text field & selected value
  final String Function(T item)? displayString;

  /// Fields used for searching (id, email, name, etc.)
  final List<String> Function(T item)? searchableStrings;

  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final T? initialValue;

  const CustomSearchableDropDown({
    super.key,
    required this.items,
    required this.displayString,
    required this.searchableStrings,
    required this.onChanged,
    this.validator,
    this.hintText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: initialValue,
      validator: validator,
      builder: (state) {
        return Autocomplete<T>(
          initialValue: initialValue != null
              ? TextEditingValue(text: displayString != null ? displayString!(initialValue!): initialValue.toString())
              : const TextEditingValue(),

          displayStringForOption: displayString ?? RawAutocomplete.defaultStringForOption,

          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return items;
            }

            final query = textEditingValue.text.toLowerCase();

            return items.where((item) {
              if (searchableStrings != null) {

              return searchableStrings!(item).any(
                (field) => field.toLowerCase().contains(query),
              );
              } else {
                return item.toString().toLowerCase().contains(query);
              }
            });
          },

          onSelected: (selection) {
            state.didChange(selection);
            onChanged?.call(selection);
          },

          fieldViewBuilder: (
            context,
            controller,
            focusNode,
            onFieldSubmitted,
          ) {
            return CustomTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              errorText: state.errorText,
              onFieldSubmitted: onFieldSubmitted,
            );
          },
        );
      },
    );
  }
}
