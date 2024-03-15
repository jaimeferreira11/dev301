import 'package:flutter/material.dart';
import 'package:test_mobile_itae/app/core/utils/responsive.dart';

class MySpaces {
  static marginVertical(BuildContext context) => Responsive.of(context).hp(1);
  static marginVertical2(BuildContext context) => Responsive.of(context).hp(2);
  static marginVertical3(BuildContext context) => Responsive.of(context).hp(3);

  static marginHorizontal(BuildContext context) => Responsive.of(context).hp(1);
  static marginHorizontal2(BuildContext context) =>
      Responsive.of(context).hp(2);
  static marginHorizontal3(BuildContext context) =>
      Responsive.of(context).hp(3);
}
