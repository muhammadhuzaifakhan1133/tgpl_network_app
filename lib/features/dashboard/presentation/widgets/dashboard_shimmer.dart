import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';

class DashboardShimmerView extends StatelessWidget {
  const DashboardShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Top white container
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.r),
              bottomRight: Radius.circular(50.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              HeaderProfileShimmer(),
              SizedBox(height: 30.h),
              _GreetingTextShimmer(),
              SizedBox(height: 20.h),
              _CountCardsShimmer(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              SyncStatusCardShimmer(),
              SizedBox(height: 20.h),
              _ModulesListShimmer(),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderProfileShimmer extends StatelessWidget {
  const HeaderProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerBox(
          width: 48,
          height: 48,
          borderRadius: 16,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerBox(
                width: 140,
                height: 18,
                borderRadius: 4,
              ),
              SizedBox(height: 6),
              ShimmerBox(
                width: 100,
                height: 14,
                borderRadius: 4,
              ),
            ],
          ),
        ),
        const ShimmerBox(
          width: 44,
          height: 44,
          borderRadius: 16,
        ),
      ],
    );
  }
}

class _GreetingTextShimmer extends StatelessWidget {
  const _GreetingTextShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(
          width: 220,
          height: 28,
          borderRadius: 4,
        ),
        SizedBox(height: 8.h),
        ShimmerBox(
          width: 280,
          height: 16,
          borderRadius: 4,
        ),
      ],
    );
  }
}

class _CountCardsShimmer extends StatelessWidget {
  const _CountCardsShimmer();

  Widget _card() {
    return const ShimmerBox(
      width: double.infinity,
      height: 115,
      borderRadius: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _card()),
            SizedBox(width: 16.w),
            Expanded(child: _card()),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(child: _card()),
            SizedBox(width: 16.w),
            Expanded(child: _card()),
          ],
        ),
      ],
    );
  }
}

class SyncStatusCardShimmer extends StatelessWidget {
  const SyncStatusCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerBox(
      width: double.infinity,
      height: 90,
      borderRadius: 20,
    );
  }
}

class _ModulesListShimmer extends StatelessWidget {
  const _ModulesListShimmer();

  Widget _moduleItem() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: ShimmerBox(
        width: double.infinity,
        height: 72,
        borderRadius: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ShimmerBox(
            width: 120,
            height: 24,
            borderRadius: 4,
          ),
        ),
        SizedBox(height: 12.h),
        for (int i = 0; i < 5; i++) _moduleItem(),
      ],
    );
  }
}