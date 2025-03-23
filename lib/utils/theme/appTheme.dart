import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../colors.dart';
import '../decorations/appDecoration.dart';
import '../styles/textStyle.dart';

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: appButtonColor));
}

ThemeData appTheme() => ThemeData(
      scaffoldBackgroundColor: backgroundColor.withOpacity(.92),
      appBarTheme: appBarTheme(),
      checkboxTheme: checkboxTheme(),
      iconTheme: appIconTheme(),
      primaryIconTheme: appIconTheme(),
      dialogTheme: appAlertTheme(),
      elevatedButtonTheme: elevatedButtonTheme(),
      inputDecorationTheme: appInputDecorationTheme(),
    );

CheckboxThemeData checkboxTheme() => CheckboxThemeData();

AppBarTheme appBarTheme() => AppBarTheme(
    backgroundColor: appBarBgColor,
    actionsIconTheme: const IconThemeData(
      color: white,
      size: 24,
    ),
    iconTheme: const IconThemeData(
      color: white,
    ),
    titleTextStyle: titleTextStyle(),
    elevation: 5,
    centerTitle: false,
    toolbarTextStyle: titleTextStyle());

IconThemeData appIconTheme() => const IconThemeData(
      color: Colors.white,
      size: 20,
    );

DialogTheme appAlertTheme() => DialogTheme(
    backgroundColor: white,
    titleTextStyle: titleTextStyle(),
    contentTextStyle: smallTextStyle(),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))));

InputDecorationTheme appInputDecorationTheme() => InputDecorationTheme(
    border: appInputBorder(),
    prefixIconColor: normalIconColor,
    filled: true,
    fillColor: fillColor,
    labelStyle: inputHintTextStyle(),
    focusedBorder: appInputFocusBorder(),
    errorBorder: appInputErrorBorder(),
    enabledBorder: appInputEnableBorder(),
    disabledBorder: appInputBorder(),
    suffixIconColor: normalIconColor,
    prefixStyle: smallTextStyle(),
    suffixStyle: smallTextStyle(),
    //focusColor: indigo,
    hintStyle: inputHintTextStyle(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0));
