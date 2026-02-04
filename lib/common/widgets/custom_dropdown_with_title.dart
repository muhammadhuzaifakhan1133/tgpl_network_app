import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown.dart';
import 'package:tgpl_network/common/widgets/custom_searchable_dropdown.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

/// 🔥 Alternative: Generic async dropdown that accepts either static list or provider
class SmartCustomDropDownWithTitle<T extends Object, D> extends ConsumerWidget {
  final String title;

  /// Either provide static items OR asyncProvider (not both)
  final List<T>? items;
  final ProviderListenable<AsyncValue<D>>? asyncProvider;
  final List<T> Function(D data)? itemsBuilder;

  final String Function(T item)? displayString;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final String? loadingHintText;
  final bool enableSearch;
  final T? selectedItem;
  final List<String> Function(T)? searchableStrings;
  final List<T>? selectedItems;
  final bool isMultiSelect;
  final int? maxSelection;
  final String? Function(List<T>)? multiValidator;
  final void Function(List<T>)? onMultiChanged;
  final bool showClearButton;
  final VoidCallback? onClear;
  final bool isRequired;

  const SmartCustomDropDownWithTitle({
    super.key,
    required this.title,
    this.items,
    this.asyncProvider,
    this.itemsBuilder,
    this.displayString,
    this.onChanged,
    this.validator,
    this.hintText,
    this.loadingHintText,
    this.searchableStrings,
    this.enableSearch = false,
    this.selectedItem,
    this.selectedItems,
    this.isMultiSelect = false,
    this.maxSelection,
    this.multiValidator,
    this.onMultiChanged,
    this.showClearButton = false,
    this.onClear,
    this.isRequired = false,
  }) : assert(
         (items != null && asyncProvider == null) ||
             (items == null && asyncProvider != null && itemsBuilder != null),
         'Provide either items OR (asyncProvider + itemsBuilder)',
       );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Static items mode
    if (items != null) {
      return _CustomDropDownWithTitle<T>(
        title: title,
        items: items!,
        displayString: displayString,
        onChanged: onChanged,
        validator: validator,
        hintText: hintText,
        searchableStrings: searchableStrings,
        enableSearch: enableSearch,
        selectedItem: selectedItem,
        selectedItems: selectedItems,
        isMultiSelect: isMultiSelect,
        maxSelection: maxSelection,
        multiValidator: multiValidator,
        onMultiChanged: onMultiChanged,
        showClearButton: showClearButton,
        onClear: onClear,
        isRequired: isRequired,
      );
    }

    // Async provider mode
    final asyncState = ref.watch(asyncProvider!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextstyles.googleJakarta500Grey12,
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: AppTextstyles.googleJakarta500Grey12.copyWith(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        asyncState.when(
          data: (data) {
            final asyncItems = itemsBuilder!(data);

            if (enableSearch) {
              return CustomSearchableDropDown(
                items: asyncItems,
                onChanged: onChanged,
                initialValue: selectedItem,
                displayString: displayString,
                searchableStrings: searchableStrings,
                validator: validator,
                hintText: hintText ?? "Select ${title.toLowerCase()}",
                showClearButton: showClearButton,
                onClear: onClear,
              );
            }

            return CustomDropDown(
              items: asyncItems,
              selectedItem: selectedItem,
              selectedItems: selectedItems,
              displayString: displayString,
              onChanged: onChanged,
              onMultiChanged: onMultiChanged,
              validator: validator,
              multiValidator: multiValidator,
              hintText: hintText ?? "Select ${title.toLowerCase()}",
              isMultiSelect: isMultiSelect,
              maxSelection: maxSelection,
              showClearButton: showClearButton,
              onClear: onClear,
            );
          },
          loading: () {
            if (enableSearch) {
              return CustomSearchableDropDown<T>(
                items: const [],
                onChanged: onChanged,
                initialValue: selectedItem,
                displayString: displayString,
                hintText:
                    loadingHintText ?? "Loading ${title.toLowerCase()}...",
                searchableStrings: (_) => [],
              );
            }

            return CustomDropDown<T>(
              items: const [],
              selectedItem: selectedItem,
              onChanged: onChanged,
              hintText: loadingHintText ?? "Loading ${title.toLowerCase()}...",
              isMultiSelect: isMultiSelect,
              onMultiChanged: onMultiChanged,
            );
          },
          error: (error, stack) {
            if (enableSearch) {
              return CustomSearchableDropDown<T>(
                items: const [],
                onChanged: onChanged,
                initialValue: selectedItem,
                displayString: displayString,
                hintText: "Error loading ${title.toLowerCase()}",
                searchableStrings: (_) => [],
              );
            }

            return CustomDropDown<T>(
              items: const [],
              selectedItem: selectedItem,
              onChanged: onChanged,
              hintText: "Error loading ${title.toLowerCase()}",
              isMultiSelect: isMultiSelect,
              onMultiChanged: onMultiChanged,
            );
          },
        ),
      ],
    );
  }
}

class _CustomDropDownWithTitle<T extends Object> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String Function(T item)? displayString;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final bool enableSearch;
  final T? selectedItem;
  final List<String> Function(T)? searchableStrings;
  final List<T>? selectedItems;
  final bool isMultiSelect;
  final int? maxSelection;
  final String? Function(List<T>)? multiValidator;
  final void Function(List<T>)? onMultiChanged;
  final bool showClearButton;
  final VoidCallback? onClear;
  final bool isRequired;

  const _CustomDropDownWithTitle({
    super.key,
    required this.title,
    required this.items,
    this.displayString,
    this.onChanged,
    this.validator,
    this.hintText,
    this.searchableStrings,
    this.enableSearch = false,
    this.selectedItem,
    this.selectedItems,
    this.isMultiSelect = false,
    this.maxSelection,
    this.multiValidator,
    this.onMultiChanged,
    this.showClearButton = false,
    this.onClear,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    assert(!(enableSearch && isMultiSelect));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextstyles.googleJakarta500Grey12,
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: AppTextstyles.googleJakarta500Grey12.copyWith(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
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
            showClearButton: showClearButton,
            onClear: onClear,
          )
        else
          CustomDropDown(
            items: items,
            selectedItem: selectedItem,
            selectedItems: selectedItems,
            displayString: displayString,
            onChanged: onChanged,
            onMultiChanged: onMultiChanged,
            validator: validator,
            multiValidator: multiValidator,
            hintText: hintText,
            isMultiSelect: isMultiSelect,
            maxSelection: maxSelection,
            showClearButton: showClearButton,
            onClear: onClear,
          ),
      ],
    );
  }
}
