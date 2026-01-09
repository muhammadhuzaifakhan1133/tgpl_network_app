import 'package:flutter/material.dart';

class SiteMapMarker extends StatelessWidget {
  final Color color;
  final String label;

  const SiteMapMarker({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pin marker
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            // Curved bottom tail
            Positioned(
              top: 28,
              child: CustomPaint(
                size: const Size(16, 12),
                painter: MarkerTailPainter(color: color),
              ),
            ),
            // Circle top part
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Label below
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            label,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class MarkerTailPainter extends CustomPainter {
  final Color color;

  MarkerTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Create the curved tail shape
    path.moveTo(size.width / 2, 0);
    
    // Left curve
    path.quadraticBezierTo(
      0, 0,
      0, size.height * 0.5,
    );
    
    // Bottom point
    path.quadraticBezierTo(
      size.width * 0.3, size.height * 0.8,
      size.width / 2, size.height,
    );
    
    // Right curve
    path.quadraticBezierTo(
      size.width * 0.7, size.height * 0.8,
      size.width, size.height * 0.5,
    );
    
    path.quadraticBezierTo(
      size.width, 0,
      size.width / 2, 0,
    );
    
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MarkerTailPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}