import 'package:flutter/material.dart';

class AppPadding {
  const AppPadding._();

  static EdgeInsets all(double value) => EdgeInsets.all(value);

  static EdgeInsets horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value);

  static EdgeInsets vertical(double value) =>
      EdgeInsets.symmetric(vertical: value);

  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  static EdgeInsets only({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);

  static EdgeInsets get zero => EdgeInsets.zero;
}
