import 'package:flutter/material.dart';

/// Clips the login screen's bottom panel into the soft double-curve seen in the
/// reference design — a gentle hump on the left that dips toward the right.
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path();

    // Start partway down the left edge.
    path.moveTo(0, h * 0.18);

    // First rising hump toward the upper third.
    path.cubicTo(
      w * 0.18, h * 0.02, // control 1 – pull the curve up
      w * 0.34, h * 0.04, // control 2
      w * 0.5, h * 0.12, // peak settles near the centre
    );

    // Gentle valley sweeping down to the right edge.
    path.cubicTo(
      w * 0.7, h * 0.22,
      w * 0.86, h * 0.16,
      w, h * 0.06,
    );

    // Close down the right side, across the bottom, and back up the left.
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
