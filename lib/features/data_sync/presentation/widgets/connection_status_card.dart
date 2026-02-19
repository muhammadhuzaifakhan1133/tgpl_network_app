import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/utils/get_time_duration_till_now.dart';

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
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          left: BorderSide(
            color: isOnline
                ? AppColors.onlineStatusColor
                : AppColors.offlineStatusColor,
            width: 4.w,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONNECTION STATUS', style: AppTextstyles.neutra500grey12),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: isOnline
                            ? AppColors.onlineStatusColor
                            : AppColors.offlineStatusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: isOnline
                            ? AppColors.onlineStatusColor
                            : AppColors.offlineStatusColor,
                        fontSize: 20.sp,
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
              SizedBox(height: 8.h),
              Text(
                getFormattedTimeDuration(lastSyncTime),
                style: AppTextstyles.neutra700black224.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
