// lib/common/widgets/shimmer_textfield.dart
import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/shimmer_widget.dart';

class ShimmerTextField extends StatelessWidget {
  final bool showTitle;

  const ShimmerTextField({
    super.key,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          const ShimmerBox(
            width: 120,
            height: 16,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),
        ],
        const ShimmerBox(
          width: double.infinity,
          height: 56,
          borderRadius: 8,
        ),
      ],
    );
  }
}