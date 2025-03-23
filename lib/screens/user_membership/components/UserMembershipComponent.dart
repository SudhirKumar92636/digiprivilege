import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:membership/utils/helper/date_converter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../models/UserMembershipDetailsModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles/ImageView.dart';
import '../../../utils/styles/textStyle.dart';
import '../UserCouponScreen.dart';
import 'BuyNowMembership.dart';

membershipSingleItemView(
    UserMembershipDetailsModel data, Color expireColor, BuildContext context) {
  return InkWell(
    onTap: () {
      if (data.isVerified == true) {
        UserCouponScreen(membershipData: data).launch(context);
      } else {
        Fluttertoast.showToast(msg: "Please wait for admin approval");
      }
      // UserCouponScreen(membershipData: data).launch(context);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration:
          boxDecorationRoundedWithShadow(12, backgroundColor: fillColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: .5, color: appThemeColor)),
                child: showNetworkImageWithCached(
                    data.brandLogoUrl ?? "", 7.h, 14.w, 8,
                    fit: BoxFit.contain),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.title},",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: boldTextStyle(color: white, size: 18),
                  ),
                  2.height,
                  Text("${data.membershipNumber}",
                    style: secondaryTextStyle(
                        color: white, size: 14, weight: FontWeight.bold),
                  ),
                  2.height,
                  Text(
                    DateConverter.getDateFormTimestamp(
                        data.createdAt ?? Timestamp.now()),
                    style: secondaryTextStyle(
                        color: white, size: 14, weight: FontWeight.bold),
                  ),

                  2.height,
                  Text(
                    "Expires - ${DateConverter.getExpiryDateFormTimestamp(data.createdAt ?? Timestamp.now(), data.duration ?? "0")}",
                    style: secondaryTextStyle(color: Colors.orange, size: 12),
                  )
                ],
              ).paddingSymmetric(horizontal: 10)
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 0),
          const Divider(
            thickness: .8,
            color: white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$rupee ${data.price ?? "0"}",
                style: secondaryTextStyle(color: Colors.white),
              ),
              Text(
                "Id - ${data.id}",
                style: secondaryTextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    ),
  );
}

emptyList(String message) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/empty_box-icon.png",
          height: 20.h,
          width: 40.w,
        ),
        Text(
          message,
          style: boldTextStyle(color: grey),
        )
      ],
    ),
  );
}

emptyMembershipList(BuildContext context) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/empty_box-icon.png",
          height: 20.h,
          width: 40.w,
        ),
        Text(
          "Don't have membership yet!",
          style: boldTextStyle(color: grey),
        ),
        20.height,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuyNowMembersship()));
              },
              child: Container(
                height: 45.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.5), color: orange),
                child: const Center(
                    child: Text(
                  "Buy now",
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 16),
                )),
              )),
        )
      ],
    ),
  );
}
