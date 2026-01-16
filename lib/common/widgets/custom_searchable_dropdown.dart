import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';

class CustomSearchableDropDown<T extends Object> extends StatelessWidget {
  final List<T> items;
  final String Function(T item)? displayString;
  final List<String> Function(T item)? searchableStrings;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final T? initialValue;

  /// 🔹 NEW
  final bool showClearButton;
  final VoidCallback? onClear;

  const CustomSearchableDropDown({
    super.key,
    required this.items,
    required this.displayString,
    required this.searchableStrings,
    required this.onChanged,
    this.validator,
    this.hintText,
    this.initialValue,
    this.showClearButton = false,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: initialValue,
      validator: validator,
      builder: (state) {
        return Autocomplete<T>(
          initialValue: initialValue != null
              ? TextEditingValue(
                  text: displayString != null
                      ? displayString!(initialValue!)
                      : initialValue.toString(),
                )
              : const TextEditingValue(),

          displayStringForOption:
              displayString ?? RawAutocomplete.defaultStringForOption,

          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) return items;

            final query = textEditingValue.text.toLowerCase();
            return items.where((item) {
              if (searchableStrings != null) {
                return searchableStrings!(item)
                    .any((f) => f.toLowerCase().contains(query));
              }
              return item.toString().toLowerCase().contains(query);
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
            final hasValue = controller.text.isNotEmpty;

            return CustomTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              errorText: state.errorText,
              onFieldSubmitted: onFieldSubmitted,
              showClearButton: showClearButton && hasValue,
              onClear: () {
                controller.clear();
                state.didChange(null);
                onChanged?.call(null);
                onClear?.call();
              },
            );
          },
        );
      },
    );
  }
}
