import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:tgpl_network/utils/get_time_duration_till_now.dart';

class SyncStatusCard extends StatelessWidget {
  final SyncStatus status;
  final String lastSyncTime;
  final VoidCallback? onPressActionButton;

  const SyncStatusCard({
    super.key,
    required this.status,
    required this.lastSyncTime,
    this.onPressActionButton,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SyncStatus.offline:
        return _buildOfflineCard();
      case SyncStatus.syncing:
        return _buildSyncingCard();
      case SyncStatus.synchronized:
        return _buildSynchronizedCard();
      case SyncStatus.loading:
        return SyncStatusCardShimmer();
    }
  }

  Widget _buildOfflineCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C42), Color(0xFFFF9D5C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.wifi_off, color: Colors.white, size: 28.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offline Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'No internet connection',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Last sync: ${getFormattedTimeDuration(lastSyncTime)}',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          if (onPressActionButton != null)
            IconButton(
              onPressed: onPressActionButton,
              icon: Icon(Icons.refresh, size: 24.w),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(12.w),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSyncingCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            child: SizedBox(
              width: 28.w,
              height: 28.h,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Syncing data...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Last sync: ${getFormattedTimeDuration(lastSyncTime)}',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSynchronizedCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF34D399)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 28.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Synchronized',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Last sync: ${getFormattedTimeDuration(lastSyncTime)}',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          if (onPressActionButton != null)
            IconButton(
              onPressed: onPressActionButton,
              icon: Icon(Icons.refresh, size: 24.w),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(12.w),
              ),
            ),
        ],
      ),
    );
  }
}
