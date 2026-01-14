import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class ConnectionStatusCard extends StatelessWidget {
  final bool isOnline;
  final String lastSyncTime;

  const ConnectionStatusCard({
    super.key,
    required this.isOnline,
    required this.lastSyncTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isOnline
                ? AppColors.onlineStatusColor
                : AppColors.offlineStatusColor,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONNECTION STATUS', style: AppTextstyles.neutra500grey12),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: isOnline
                            ? AppColors.onlineStatusColor
                            : AppColors.offlineStatusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: isOnline
                            ? AppColors.onlineStatusColor
                            : AppColors.offlineStatusColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Last Synced', style: AppTextstyles.neutra500grey12),
              const SizedBox(height: 8),
              Text(
                lastSyncTime,
                style: AppTextstyles.neutra700black224.copyWith(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}