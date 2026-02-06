import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_controller.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class SelectedLocationCard extends StatelessWidget {
  final LocationData locationData;
  final VoidCallback onClose;
  final VoidCallback onConfirm;

  const SelectedLocationCard({
    super.key,
    required this.locationData,
    required this.onClose,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              // Container(
              //   margin: EdgeInsets.only(top: 12.h),
              //   width: 40.w,
              //   height: 4.h,
              //   decoration: BoxDecoration(
              //     color: AppColors.extraInformationColor,
              //     borderRadius: BorderRadius.circular(2.r),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 24.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            'Selected Location',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: onClose,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Address
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            Icons.place,
                            'Address',
                            locationData.address ?? 'Fetching address...',
                          ),
                        ),
                        // copy button
                        if (locationData.address != null)
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              // Copy to clipboard
                              Clipboard.setData(
                                ClipboardData(text: locationData.address!),
                              );
                              showSnackBar(
                                context,
                                "Address copied to clipboard",
                              );
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Coordinates
                    _buildInfoRow(
                      Icons.gps_fixed,
                      'Coordinates',
                      '${locationData.position.latitude.toStringAsFixed(6)}, ${locationData.position.longitude.toStringAsFixed(6)}',
                    ),
                    SizedBox(height: 20.h),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onPressed: locationData.address == null
                            ? null
                            : onConfirm,
                        text: "Confirm Location",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.w, color: AppColors.extraInformationColor),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextstyles.googleInter400LightGrey12),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  color: AppColors.black2Color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
