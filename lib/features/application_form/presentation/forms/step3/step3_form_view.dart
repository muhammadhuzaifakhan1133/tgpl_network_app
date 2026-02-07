import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step3/step3_form_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class Step3FormView extends ConsumerStatefulWidget {
  const Step3FormView({super.key});

  @override
  ConsumerState<Step3FormView> createState() => _Step3FormViewState();
}

class _Step3FormViewState extends ConsumerState<Step3FormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _frontController;
  late final TextEditingController _depthController;
  late final TextEditingController _locationController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(step3FormControllerProvider);

    _frontController = TextEditingController(text: state.frontSize);
    _depthController = TextEditingController(text: state.depthSize);
    _locationController = TextEditingController(text: state.googleLocation);
    _addressController = TextEditingController(text: state.address);
  }

  @override
  void dispose() {
    _frontController.dispose();
    _depthController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  (double?, double?) _getLatLngFromLocation(String location) {
    try {
      final parts = location.split(',');
      if (parts.length != 2) return (null, null);
      final lat = double.parse(parts[0].trim());
      final lng = double.parse(parts[1].trim());
      return (lat, lng);
    } catch (e) {
      return (null, null);
    }
  }

  Future<void> _pickLocation() async {
    final controller = ref.read(step3FormControllerProvider.notifier);

    double? latitude, longitude;
    (latitude, longitude) = _getLatLngFromLocation(_locationController.text);
    LocationData? selectedLocation = await ref
        .read(goRouterProvider)
        .push(
          AppRoutes.siteLocationSelection,
          extra: latitude != null && longitude != null
              ? LatLng(latitude, longitude)
              : null,
        );

    if (selectedLocation != null) {
      final value =
          "${selectedLocation.position.latitude.toStringAsFixed(6)}, "
          "${selectedLocation.position.longitude.toStringAsFixed(6)}";

      _locationController.text = value;
      _addressController.text = selectedLocation.address ?? '';

      controller.updateLocation(value);
      controller.updateAddress(selectedLocation.address ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final step3Controller = ref.read(step3FormControllerProvider.notifier);
    final autoValidate = ref.watch(
      step3FormControllerProvider.select((s) => s.autoValidateFrom),
    );
    return Form(
      key: _formKey,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Plot Details",
              style: AppTextstyles.googleInter700black28.copyWith(
                fontSize: 24.sp,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Front*",
                  controller: _frontController,
                  hintText: "Enter front size",
                  validator: (v) => v.validateNumber(),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  onChanged: step3Controller.updateFrontSize,
                  showClearButton: true,
                  onClear: () => step3Controller.clearField('frontSize'),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Depth*",
                  controller: _depthController,
                  hintText: "Enter depth size",
                  validator: (v) => v.validateNumber(),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  onChanged: step3Controller.updateDepthSize,
                  showClearButton: true,
                  onClear: () => step3Controller.clearField('depthSize'),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "Google Location*",
            readOnly: true,
            controller: _locationController,
            hintText: "Select location",
            onTap: _pickLocation,
            suffixIcon: actionContainer(
              icon: AppImages.locationIconSvg,
              rightMargin: 5,
              // TODO: correct icon size
              iconColor: AppColors.black,
              onTap: _pickLocation,
            ),
            validator: (v) => v.validate(),
            isRequired: true,
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "Complete Site Address*",
            extraInformation:
                "You can select the location on the map to autofill this field.",
            controller: _addressController,
            hintText: "Enter complete site address",
            validator: (v) => v.validate(),
            isRequired: true,
            multiline: true,
            onChanged: step3Controller.updateAddress,
            showClearButton: true,
            onClear: () => step3Controller.clearField('address'),
          ),

          SizedBox(height: 20.h),
          // change this button to use appFormSubmissionProvider for showing loading state
          CustomButton(
            text: "",
            child: ref
                .watch(appFormSubmissionProvider)
                .when(
                  data: (_) => Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.neutra500white22,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.neutra500white22,
                  ),
                ),
            onPressed: () async {
              if (!autoValidate) {
                ref
                    .read(step3FormControllerProvider.notifier)
                    .updateAutoValidate(true);
              }
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                // await ref.read(appFormSubmissionProvider.notifier).submitAppForm();
                ref
                    .read(goRouterProvider)
                    .pushReplacement(
                      AppRoutes.stationFormConfirmation("App-ID-12345"),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
