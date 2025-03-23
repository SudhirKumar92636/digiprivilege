import 'package:flutter/material.dart';

Widget ShapeIcon() {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.white.withOpacity(.0), Colors.grey.withOpacity(.2)],
          begin: Alignment.bottomCenter,
          end: Alignment.bottomCenter),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
