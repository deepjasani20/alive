import 'package:flutter/widgets.dart';

/// Lightweight responsive helper.
///
/// The reference design is drawn for a ~390pt wide iPhone. We scale spacing and
/// font sizes relative to that baseline so the layout keeps its proportions on
/// phones of different sizes without pulling in a heavy dependency.
extension ResponsiveContext on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);

  double get screenWidth => _size.width;
  double get screenHeight => _size.height;

  /// Scale a width value designed against a 390pt reference width.
  double w(double value) => value / 390.0 * screenWidth;

  /// Scale a height value designed against an 844pt reference height.
  double h(double value) => value / 844.0 * screenHeight;

  /// Scale a font / radius, clamped so text never becomes unreadable on
  /// very small or very large devices.
  double sp(double value) {
    final double scaled = value / 390.0 * screenWidth;
    return scaled.clamp(value * 0.85, value * 1.15);
  }
}
