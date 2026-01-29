import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step2/step2_form_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class Step2FormView extends ConsumerStatefulWidget {
  const Step2FormView({super.key});

  @override
  ConsumerState<Step2FormView> createState() => _Step2FormViewState();
}

class _Step2FormViewState extends ConsumerState<Step2FormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _sourceController;
  late final TextEditingController _sourceNameController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(step2FormControllerProvider);

    _sourceController = TextEditingController(text: state.source);
    _sourceNameController = TextEditingController(text: state.sourceName);
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _sourceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step2Controller = ref.read(step2FormControllerProvider.notifier);
    final appFormController = ref.read(appFormControllerProvider.notifier);
    final state = ref.watch(step2FormControllerProvider);
    final dropDownsData = ref.read(formPrerequisiteValuesProvider).requireValue;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Site Information",
            style: AppTextstyles.googleInter700black28.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),

          SmartCustomDropDownWithTitle(
            title: "City",
            hintText: "Select city",
            enableSearch: true,
            selectedItem: state.selectedCity,
            items: dropDownsData.cities.map((city) => city.name).toList(),
            onChanged: (value) {
              if (value != null) {
                step2Controller.updateCity(value.toString());
              }
            },
            validator: (v) => v.validate(),
            showClearButton: true,
            onClear: () {
              step2Controller.clearField('selectedCity');
            },
          ),

          const SizedBox(height: 16),

          SmartCustomDropDownWithTitle(
            title: "Site Status",
            hintText: "Select site status",
            selectedItem: state.selectedSiteStatus,
            items: dropDownsData.siteStatuses
                .map((status) => status.name)
                .toList(),
            onChanged: (value) {
              if (value != null) {
                step2Controller.updateSiteStatus(value.toString());
              }
            },
            validator: (v) => v.validate(),
            showClearButton: true,
            onClear: () {
              step2Controller.clearField('selectedSiteStatus');
            },
          ),

          const SizedBox(height: 16),

          SmartCustomDropDownWithTitle(
            title: "Priority",
            hintText: "Select site priority",
            selectedItem: state.selectedPriority,
            items: dropDownsData.hmlList
                .map((priority) => priority.hml)
                .toList(),
            onChanged: (value) {
              if (value != null) {
                step2Controller.updatePriority(value.toString());
              }
            },
            validator: (v) => v.validate(),
            showClearButton: true,
            onClear: () => step2Controller.clearField('selectedPriority'),
          ),

          const SizedBox(height: 16),

          CustomTextFieldWithTitle(
            title: "Source*",
            controller: _sourceController,
            hintText: "Enter source",
            validator: (v) => v.validate(),
            onChanged: step2Controller.updateSource,
            showClearButton: true,
            onClear: () => step2Controller.clearField('source'),
          ),

          const SizedBox(height: 16),

          CustomTextFieldWithTitle(
            title: "Source Name*",
            controller: _sourceNameController,
            hintText: "Enter source name",
            validator: (v) => v.validate(),
            onChanged: step2Controller.updateSourceName,
            showClearButton: true,
            onClear: () => step2Controller.clearField('sourceName'),
          ),

          const SizedBox(height: 20),

          CustomButton(
            text: "Next",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                appFormController.nextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
