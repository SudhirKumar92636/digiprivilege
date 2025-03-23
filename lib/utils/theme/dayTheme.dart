import 'package:flutter/material.dart';
import 'package:membership/utils/colors.dart';

ThemeData dayTheme() {
  return ThemeData(
      appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(color: Colors.black),
          backgroundColor: backgroundColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 5),
      scaffoldBackgroundColor: Colors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))));
}
