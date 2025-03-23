import 'package:flutter/material.dart';
import 'package:membership/utils/colors.dart';

ThemeData nightTheme() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 5),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: backgroundColor, selectedItemColor: Colors.white),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))));
}
