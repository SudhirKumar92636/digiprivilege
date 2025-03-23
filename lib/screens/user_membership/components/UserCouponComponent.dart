import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/Global/global.dart';

Widget showCouponStatus(String status, String couponType) {
  if (couponType == "card") {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Text(
            "Active",
            style: secondaryTextStyle(color: orange),
          )
        ],
      ),
    );
  } else {
    if (status == "active") {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              "Active",
              style: secondaryTextStyle(color: orange),
            )
          ],
        ),
      );
    } else if (status == "requested") {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              "Pending",
              style: secondaryTextStyle(color: yellowGreen),
            ),
          ],
        ),
      );
    } else if (status == "confirm") {
      return Text(
        "Confirm",
        style: secondaryTextStyle(color: greenColor),
      );
    } else if (status == "expired") {
      return Text(
        "Expired",
        style: secondaryTextStyle(color: redColor),
      );
    } else if (status == "rejected") {
      isRejected = true;
      return Text(
        "Rejected",
        style: secondaryTextStyle(color: redColor),
      );
    } else {
      return Text(
        "Used",
        style: secondaryTextStyle(color: redColor),
      );
    }
  }
}