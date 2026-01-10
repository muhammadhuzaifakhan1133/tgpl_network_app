import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step3/site_location_selection/site_location_selection_controller.dart';

class SelectedLocationCard extends StatelessWidget {
  final LocationData locationData;
  final VoidCallback onClose;
  final VoidCallback onConfirm;

  const SelectedLocationCard({super.key, 
    required this.locationData,
    required this.onClose,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
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
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.extraInformationColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Selected Location',
                        style: TextStyle(
                          fontSize: 20,
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
                const SizedBox(height: 16),

                // Address
                _buildInfoRow(
                  Icons.place,
                  'Address',
                  locationData.address ?? 'Loading address...',
                ),
                const SizedBox(height: 12),

                // Coordinates
                _buildInfoRow(
                  Icons.gps_fixed,
                  'Coordinates',
                  '${locationData.position.latitude.toStringAsFixed(6)}, ${locationData.position.longitude.toStringAsFixed(6)}',
                ),
                const SizedBox(height: 20),

                // Action button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(onPressed: onConfirm, text: "Confirm Location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.extraInformationColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextstyles.googleInter400LightGrey12,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  color: AppColors.black2Color
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
