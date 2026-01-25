import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_controller.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/common/models/yes_no_enum_with_extension.dart';

class YesNoDropDownField extends StatelessWidget {
  final YesNo? Function(FilterSelectionState) selectYesNoField;
  final String title;
  final String fieldName;
  final void Function(YesNo value) onChangeValue;
  const YesNoDropDownField({
    super.key,
    required this.selectYesNoField,
    required this.title,
    required this.onChangeValue,
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedValue = ref.watch(
          filterSelectionProvider.select((s) => selectYesNoField(s)),
        );
        return Expanded(
          child: CustomDropDownWithTitle(
            title: title,
            items: YesNo.values,
            displayString: (item) => item.label,
            hintText: "Yes/No",
            showClearButton: selectedValue != null,
            onClear: () {
              ref.read(filterSelectionProvider.notifier).clearFields([
                fieldName,
              ]);
            },
            onChanged: (v) {
              if (v == null) return;
              onChangeValue(v);
            },
            selectedItem: selectedValue,
          ),
        );
      },
    );
  }
}
