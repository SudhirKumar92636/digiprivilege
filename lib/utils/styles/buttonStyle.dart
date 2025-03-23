import 'package:flutter/material.dart';

import '../colors.dart';

authButtonStyle(
    {Color bgColor = Colors.black, double height = 45, double width = 200}) {
  return ElevatedButton.styleFrom(
      fixedSize: Size(width, height), backgroundColor: bgColor, elevation: 5);
}

ButtonStyle elevatedButtonStyle(double height, double width,
    {double? radius, Color? color}) {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(width, height)),
      backgroundColor:
          MaterialStateProperty.all<Color>(color ?? appButtonColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 30),
      )));
}
