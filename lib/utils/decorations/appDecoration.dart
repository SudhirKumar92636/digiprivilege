import 'package:flutter/material.dart';

import '../colors.dart';

OutlineInputBorder appInputBorder() => const OutlineInputBorder(
    borderSide: BorderSide(
        color: inputBorderColor, width: .5, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ));

OutlineInputBorder appInputFocusBorder() => const OutlineInputBorder(
    borderSide: BorderSide(
        color: inputFocusBorderColor, width: 1, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ));

OutlineInputBorder appInputErrorBorder() => const OutlineInputBorder(
    borderSide: BorderSide(
        color: inputErrorBorderColor, width: 1, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ));

OutlineInputBorder appInputEnableBorder() => const OutlineInputBorder(
    borderSide: BorderSide(
        color: inputFocusBorderColor, width: 1, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ));