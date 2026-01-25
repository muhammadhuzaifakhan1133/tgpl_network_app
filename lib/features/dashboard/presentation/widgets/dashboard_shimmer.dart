import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/shimmer_wrapper.dart';

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
              _HeaderProfileShimmer(),
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

class _HeaderProfileShimmer extends StatelessWidget {
  const _HeaderProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWrapper(
          borderRadius: BorderRadius.circular(16),
          child: Container(height: 48, width: 48, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWrapper(
                child: Container(height: 18, width: 140, color: Colors.white),
              ),
              const SizedBox(height: 6),
              ShimmerWrapper(
                child: Container(height: 14, width: 100, color: Colors.white),
              ),
            ],
          ),
        ),
        ShimmerWrapper(
          borderRadius: BorderRadius.circular(16),
          child: Container(height: 44, width: 44, color: Colors.white),
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
        ShimmerWrapper(
          child: Container(height: 28, width: 220, color: Colors.white),
        ),
        const SizedBox(height: 8),
        ShimmerWrapper(
          child: Container(height: 16, width: 280, color: Colors.white),
        ),
      ],
    );
  }
}

class _CountCardsShimmer extends StatelessWidget {
  const _CountCardsShimmer();

  Widget _card() {
    return ShimmerWrapper(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 115,
        color: Colors.white,
      ),
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
    return ShimmerWrapper(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 90,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

class _ModulesListShimmer extends StatelessWidget {
  const _ModulesListShimmer();

  Widget _moduleItem() {
    return ShimmerWrapper(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 72,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWrapper(
            child: Container(height: 24, width: 120, color: Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < 5; i++) _moduleItem(),
      ],
    );
  }
}
