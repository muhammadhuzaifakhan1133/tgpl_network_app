import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';

class CustomSearchableDropDown<T extends Object> extends StatelessWidget {
  final List<T>? items;
  final Future<List<T>> Function(String query)? asyncItems; // 🔹 NEW
  final String Function(T item)? displayString;
  final List<String> Function(T item)? searchableStrings;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final T? initialValue;
  final bool showClearButton;
  final VoidCallback? onClear;
  final Function(TextEditingController)? assignController;

  const CustomSearchableDropDown({
    super.key,
    this.items,
    this.asyncItems, // 🔹 NEW
    required this.displayString,
    required this.searchableStrings,
    required this.onChanged,
    this.validator,
    this.hintText,
    this.initialValue,
    this.showClearButton = false,
    this.onClear,
    this.assignController,
  }) : assert(
          items != null || asyncItems != null,
          'Either items or asyncItems must be provided',
        );

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

          // 🔹 Handles both sync and async
          optionsBuilder: (textEditingValue) async {
            final query = textEditingValue.text;

            // Async path
            if (asyncItems != null) {
              return await asyncItems!(query);
            }

            // Sync path
            final list = items ?? [];
            if (query.isEmpty) return list;

            final lowerQuery = query.toLowerCase();
            return list.where((item) {
              if (searchableStrings != null) {
                return searchableStrings!(item)
                    .any((f) => f.toLowerCase().contains(lowerQuery));
              }
              return item.toString().toLowerCase().contains(lowerQuery);
            });
          },

          onSelected: (selection) {
            state.didChange(selection);
            onChanged?.call(selection);
          },

          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            if (assignController != null) {
              assignController!(controller);
            }
            return CustomTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              errorText: state.errorText,
              onFieldSubmitted: onFieldSubmitted,
              showClearButton: showClearButton,
              onClear: () {
                controller.clear();
                state.didChange(null);
                onChanged?.call(null);
                onClear?.call();
              },
            );
          },

          // 🔹 Loading indicator while fetching
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: options.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('No results found'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return ListTile(
                              title: Text(
                                displayString?.call(option) ??
                                    option.toString(),
                              ),
                              onTap: () => onSelected(option),
                            );
                          },
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}