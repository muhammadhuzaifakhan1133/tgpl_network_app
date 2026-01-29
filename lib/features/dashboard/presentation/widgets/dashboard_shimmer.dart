import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';

class DashboardShimmerView extends StatelessWidget {
  const DashboardShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Top white container
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: const [
              SizedBox(height: 10),
              HeaderProfileShimmer(),
              SizedBox(height: 30),
              _GreetingTextShimmer(),
              SizedBox(height: 20),
              _CountCardsShimmer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: const [
              _SyncStatusCardShimmer(),
              SizedBox(height: 20),
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
        const ShimmerBox(
          width: 48,
          height: 48,
          borderRadius: 16,
        ),
        const SizedBox(width: 12),
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
      children: const [
        ShimmerBox(
          width: 220,
          height: 28,
          borderRadius: 4,
        ),
        SizedBox(height: 8),
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
            const SizedBox(width: 16),
            Expanded(child: _card()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _card()),
            const SizedBox(width: 16),
            Expanded(child: _card()),
          ],
        ),
      ],
    );
  }
}

class _SyncStatusCardShimmer extends StatelessWidget {
  const _SyncStatusCardShimmer();

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
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
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
        const Align(
          alignment: Alignment.centerLeft,
          child: ShimmerBox(
            width: 120,
            height: 24,
            borderRadius: 4,
          ),
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < 5; i++) _moduleItem(),
      ],
    );
  }
}