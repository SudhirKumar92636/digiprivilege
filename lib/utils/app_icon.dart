import 'package:flutter/material.dart';

Widget appIconView(
    {double height = 120, double width = 120, double fontSize = 30}) {
  return Container(
    width: height,
    height: width,
    child: Center(
      child: Text(
        "M",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: fontSize),
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 5, offset: Offset(-5, -5), color: Colors.grey),
          BoxShadow(blurRadius: 5, offset: Offset(5, 5), color: Colors.black)
        ],
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(1), Colors.grey.withOpacity(.5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(100)),
  );
}
