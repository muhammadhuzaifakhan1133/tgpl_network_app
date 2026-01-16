import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/providers/site_statuses_provider.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step2/step2_form_controller.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

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
    final stationController = ref.read(stationFormControllerProvider.notifier);

    final state = ref.watch(step2FormControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Site Information",
            style: AppTextstyles.googleInter700black28.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),

          CustomDropDownWithTitle(
            title: "City",
            hintText: "Select city",
            enableSearch: true,
            selectedItem: state.selectedCity.isEmpty
                ? null
                : state.selectedCity,
            items: ref.read(cityNamesProvider),
            onChanged: (value) {
              if (value != null) {
                step2Controller.updateCity(value.toString());
              }
            },
            validator: (v) => v.validate(),
          ),

          const SizedBox(height: 16),

          CustomDropDownWithTitle(
            title: "Site Status",
            hintText: "Select site status",
            selectedItem: state.selectedSiteStatus.isEmpty
                ? null
                : state.selectedSiteStatus,
            items: ref.read(siteStatusesProvider),
            onChanged: (value) {
              if (value != null) {
                step2Controller.updateSiteStatus(value.toString());
              }
            },
            validator: (v) => v.validate(),
          ),

          const SizedBox(height: 16),

          CustomDropDownWithTitle(
            title: "Priority",
            hintText: "Select site priority",
            selectedItem: state.selectedPriority.isEmpty
                ? null
                : state.selectedPriority,
            items: ref.read(prioritiesProvider),
            onChanged: (value) {
              if (value != null) {
                step2Controller.updatePriority(value.toString());
              }
            },
            validator: (v) => v.validate(),
          ),

          const SizedBox(height: 16),

          CustomTextFieldWithTitle(
            title: "Source*",
            controller: _sourceController,
            validator: (v) => v.validate(),
            onChanged: step2Controller.updateSource,
          ),

          const SizedBox(height: 16),

          CustomTextFieldWithTitle(
            title: "Source Name*",
            controller: _sourceNameController,
            validator: (v) => v.validate(),
            onChanged: step2Controller.updateSourceName,
          ),

          const SizedBox(height: 20),

          CustomButton(
            text: "Next",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                stationController.nextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
