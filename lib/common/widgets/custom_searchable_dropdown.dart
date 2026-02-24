import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';

class CustomSearchableDropDown<T extends Object> extends StatefulWidget {
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
  final Color Function(T item)? optionIndicatorColor;

  const CustomSearchableDropDown({
    super.key,
    this.items,
    this.asyncItems, // 🔹 NEW
    required this.displayString,
    required this.onChanged,
    this.searchableStrings,
    this.validator,
    this.hintText,
    this.initialValue,
    this.showClearButton = false,
    this.onClear,
    this.assignController,
    this.optionIndicatorColor,
  }) : assert(
         items != null || asyncItems != null,
         'Either items or asyncItems must be provided',
       );

  @override
  State<CustomSearchableDropDown<T>> createState() =>
      _CustomSearchableDropDownState<T>();
}

class _CustomSearchableDropDownState<T extends Object>
    extends State<CustomSearchableDropDown<T>> {
  String _lastQuery = '';

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      builder: (state) {
        return Autocomplete<T>(
          initialValue: widget.initialValue != null
              ? TextEditingValue(
                  text: widget.displayString != null
                      ? widget.displayString!(widget.initialValue!)
                      : widget.initialValue.toString(),
                )
              : const TextEditingValue(),

          displayStringForOption:
              widget.displayString ?? RawAutocomplete.defaultStringForOption,

          optionsBuilder: (textEditingValue) async {
            final query = textEditingValue.text;
            setState(() => _lastQuery = query); // 🔹 track query

            if (widget.asyncItems != null) {
              return await widget.asyncItems!(query);
            }

            final list = widget.items ?? [];
            if (query.isEmpty) return list;

            final lowerQuery = query.toLowerCase();
            return list.where((item) {
              if (widget.searchableStrings != null) {
                return widget.searchableStrings!(item).any(
                  (f) => f.toLowerCase().contains(lowerQuery),
                );
              }
              return item.toString().toLowerCase().contains(lowerQuery);
            });
          },

          onSelected: (selection) {
            state.didChange(selection);
            widget.onChanged?.call(selection);
          },

          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            if (widget.assignController != null) {
              widget.assignController!(controller);
            }
            return CustomTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: widget.hintText,
              errorText: state.errorText,
              onFieldSubmitted: onFieldSubmitted,
              showClearButton: widget.showClearButton,
              onClear: () {
                controller.clear();
                state.didChange(null);
                widget.onChanged?.call(null);
                widget.onClear?.call();
              },
            );
          },

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
                            final displayText =
                                widget.displayString?.call(option) ??
                                option.toString();
                            final color = widget.optionIndicatorColor?.call(
                              option,
                            );
                            return ListTile(
                              horizontalTitleGap: 14,
                              minLeadingWidth: 0,
                              leading:
                                  color !=
                                      null // 🔹 colored status indicator
                                  ? Container(
                                      width: 4,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    )
                                  : null,
                              title: _HighlightText(
                                text: displayText,
                                query: _lastQuery,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              tileColor: color?.withOpacity(0.06),
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

class _HighlightText extends StatelessWidget {
  final String text;
  final String query;
  final bool softWrap;
  final TextOverflow? overflow;

  const _HighlightText({required this.text, required this.query, this.softWrap = true, this.overflow});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return Text(text);

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];

    int start = 0;
    int index;

    while ((index = lowerText.indexOf(lowerQuery, start)) != -1) {
      // Normal text before match
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      // Highlighted match
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue, // 🔹 customize color
          ),
        ),
      );
      start = index + query.length;
    }

    // Remaining text after last match
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      softWrap: softWrap,
      overflow: overflow ?? TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}
