// lib/common/widgets/shimmer_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// class ShimmerWidget extends StatelessWidget {
//   final double width;
//   final double height;
//   final ShapeBorder shapeBorder;

//   const ShimmerWidget.rectangular({
//     super.key,
//     required this.width,
//     required this.height,
//     this.shapeBorder = const RoundedRectangleBorder(),
//   });

//   const ShimmerWidget.circular({
//     super.key,
//     required this.width,
//     required this.height,
//     this.shapeBorder = const CircleBorder(),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         width: width.w,
//         height: height.h,
//         decoration: ShapeDecoration(
//           color: Colors.grey[300],
//           shape: shapeBorder,
//         ),
//       ),
//     );
//   }
// }

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final bool isCircular;

  const ShimmerBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8,
  }): isCircular = false;

  const ShimmerBox.circular({
    super.key,
    required this.width,
    required this.height,
  }) : isCircular = true, borderRadius = 0;


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width?.w,
        height: height.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: isCircular ? null : BorderRadius.circular(borderRadius.r),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}