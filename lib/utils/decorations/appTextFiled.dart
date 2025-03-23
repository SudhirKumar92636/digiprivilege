import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

Widget appTextFormField(
  String labelText, {
  double? sHeight,
  double? sWidth,
  TextInputType? keyBoardType,
  bool? isEnabled,
  String? Function(String?)? validator,
  String? Function(String?)? onChange,
  TextEditingController? controller,
  int? maxLength,
  String? counterText,
  String? hintText,
  IconData? suffixIcon,
  AutovalidateMode? validationMode,
  IconData? prefixIcon,
}) {
  return SizedBox(
    height: sHeight ?? 6.h,
    width: sWidth ?? 90.w,
    child: TextFormField(
      style: GoogleFonts.aBeeZee(fontSize: 14, color: Colors.white),
      cursorColor: appThemeColor,
      keyboardType: keyBoardType ?? TextInputType.text,
      enabled: isEnabled ?? true,
      validator: validator,
      controller: controller,
      maxLength: maxLength ?? 200,
      autovalidateMode: validationMode,
      onChanged: onChange,
      decoration: InputDecoration(
        counterText: counterText ?? "",
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        suffixIcon: Icon(suffixIcon),
        labelText: labelText,
        hintText: hintText,
      ),
    ),
  );
}
