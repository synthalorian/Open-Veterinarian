import 'package:flutter/material.dart';

class NeonGridBackground extends CustomPainter {
  final Color gridColor;
  final double gridSpacing;

  NeonGridBackground({
    this.gridColor = Colors.cyan,
    this.gridSpacing = 40.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor.withValues(alpha: 0.1)
      ..strokeWidth = 1.0;

    // Draw Vertical Lines
    for (double i = 0; i <= size.width; i += gridSpacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Draw Horizontal Lines
    for (double i = 0; i <= size.height; i += gridSpacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Draw Glow on top
    final glowPaint = Paint()
      ..color = gridColor.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    
    // Horizontal glow lines
    for (double i = 0; i <= size.height; i += gridSpacing * 2) {
      canvas.drawRect(Rect.fromLTWH(0, i, size.width, 2), glowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
