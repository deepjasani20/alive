import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Pixel-faithful, asset-free Google "G" mark drawn with [CustomPaint].
///
/// Recreating the four-color glyph in code avoids shipping a PNG and keeps the
/// logo crisp at every density.
class GoogleGLogo extends StatelessWidget {
  const GoogleGLogo({super.key, this.size = 22});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleGPainter()),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  static const Color _blue = Color(0xFF4285F4);
  static const Color _red = Color(0xFFEA4335);
  static const Color _yellow = Color(0xFFFBBC05);
  static const Color _green = Color(0xFF34A853);

  @override
  void paint(Canvas canvas, Size size) {
    final double stroke = size.width * 0.22;
    final Rect rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    // Four colored arcs forming the ring, drawn clockwise from the right.
    paint.color = _red;
    canvas.drawArc(rect, _deg(-50), _deg(95), false, paint);
    paint.color = _yellow;
    canvas.drawArc(rect, _deg(45), _deg(90), false, paint);
    paint.color = _green;
    canvas.drawArc(rect, _deg(135), _deg(80), false, paint);
    paint.color = _blue;
    canvas.drawArc(rect, _deg(-135), _deg(85), false, paint);

    // The horizontal blue bar of the "G".
    final double midY = size.height / 2;
    final Rect bar = Rect.fromLTRB(
      size.width * 0.52,
      midY - stroke / 2,
      size.width * 0.98,
      midY + stroke / 2,
    );
    canvas.drawRect(bar, Paint()..color = _blue);
  }

  double _deg(double degrees) => degrees * math.pi / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
