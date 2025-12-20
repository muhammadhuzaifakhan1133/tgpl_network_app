import 'package:flutter/material.dart';

class OnboardingContentContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    var offset = 100.0;

    var controlPoint = Offset(size.width / 2, 0);
    var endPoint = Offset(0, offset);

    // Start the path at the top-left corner with an offset
    path.moveTo(0, offset);

    // Draw the straight line down to the bottom-left corner
    path.lineTo(0, size.height);

    // Draw the straight line to the bottom-right corner
    path.lineTo(size.width, size.height);

    // Draw the straight line to the top-right corner
    path.lineTo(size.width, offset);

    // Create a larger, smoother curve from the bottom-right to bottom-left
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    ); // Curve at the top

    // Close the path to complete the shape
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
