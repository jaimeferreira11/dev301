import 'package:flutter/material.dart';
import 'package:test_mobile_itae/app/core/utils/responsive.dart';

class MyTextStyles {
  static TextStyle bigText(BuildContext context) => TextStyle(
        fontSize: Responsive.of(context).dp(5),
        fontWeight: FontWeight.bold,
      );
  static TextStyle title(BuildContext context) => TextStyle(
        fontSize: Responsive.of(context).dp(2.2),
        fontWeight: FontWeight.bold,
      );

  static TextStyle subtitle(BuildContext context) => TextStyle(
        fontSize: Responsive.of(context).dp(1.8),
        fontWeight: FontWeight.w600,
      );

  static TextStyle small(BuildContext context) => TextStyle(
        fontSize: Responsive.of(context).dp(1.4),
        fontWeight: FontWeight.w600,
      );
}
