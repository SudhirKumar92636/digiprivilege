import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership/utils/data/strings.dart';
import 'package:nb_utils/nb_utils.dart';

authTextFieldDecoration(String textHint) {
  return InputDecoration(
      counterText: "",
      fillColor: grey.withOpacity(.3),
      filled: true,
      prefixIcon: const Icon(
        CupertinoIcons.device_phone_portrait,
        size: 18,
        color: Colors.white,
      ),
      hintText: textHint,
      hintStyle: const TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.orange)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: white)),
      focusColor: black,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: white)));
}

authTermAndConditionText() {
  return Center(
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: termsText,
              style: TextStyle(color: Colors.white, fontSize: 12)),
          TextSpan(
            text: terms,
            style: boldTextStyle(
                color: Colors.blue,
                size: 12,
                decoration: TextDecoration.underline),
          ),
          TextSpan(
              text: ' & ', style: TextStyle(color: Colors.white, fontSize: 12)),
          TextSpan(
              text: conditions,
              style: boldTextStyle(
                  color: Colors.blue,
                  size: 12,
                  decoration: TextDecoration.underline)),
        ],
      ),
    ),
  );
}

authPhoneNumberView(String mobile) {
  return Center(
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: otpSentText,
              style: TextStyle(color: Colors.white, fontSize: 14)),
          TextSpan(
            text: mobile,
            style: boldTextStyle(
              color: Colors.blue,
              size: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
