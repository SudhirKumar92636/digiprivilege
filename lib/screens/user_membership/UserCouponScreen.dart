import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:membership/screens/user_membership/RoomVouchersFragment.dart';
import 'package:membership/screens/user_membership/UserCouponDetails.dart';
import 'package:membership/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../models/UserMembershipDetailsModel.dart';
import '../../models/membership/UserCouponDetailsModel.dart';
import '../../utils/data/data_storage.dart';
import '../../utils/helper/date_converter.dart';
import '../../utils/styles/textStyle.dart';
import 'FoodVoucherFragment.dart';

class UserCouponScreen extends StatefulWidget {
  final UserMembershipDetailsModel membershipData;

  const UserCouponScreen({
    Key? key,
    required this.membershipData,
  }) : super(key: key);

  @override
  State<UserCouponScreen> createState() => _UserCouponScreenState();
}

class _UserCouponScreenState extends State<UserCouponScreen> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    await AppData.getString(userIdKey).then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Available Vouchers"),
        ),
        body: _voucherTabSection());
  }

  Widget _voucherTabSection() {
    return DefaultTabController(
      length: 2,
      child: ListView(
        //mainAxisSize: MainAxisSize.min,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 40,
            // color: fillColor,
            child: TabBar(
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.amber),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Food Vouchers",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Room Vouchers",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          SizedBox(
            //Add this to give height
            height: 80.h,
            child: TabBarView(children: [
              FoodVouchersFragment(membershipData: widget.membershipData),
              RoomVouchersFragment(membershipData: widget.membershipData),
            ]),
          ),
        ],
      ),
    );
  }

  couponDetailsItem(UserCouponDetailsModel data) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: boxDecorationRoundedWithShadow(8, backgroundColor: black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.title ?? "",
                style: titleTextStyle(),
              ),
              Text(
                data.couponId ?? '',
                style: smallTextStyle(),
              )
            ],
          ),
          Text(
            data.description ?? "",
            style: smallTextStyle(),
          ),
          Text(
            "Membership Id: ${data.membershipId ?? ""}",
            style: smallTextStyle(),
          ),
          Text(
            "Ex on: ${data.expireOn!.toDate()}",
            style: smallTextStyle(),
          ),
        ],
      ),
    );
  }

  couponItemView(UserCouponDetailsModel couponData) {
    if (couponData.currentStatus == "active") {
      var bgColor = Color(0xff363837);
      return showCouponDetails(couponData, bgColor);
    } else if (couponData.currentStatus == "confirm") {
      var bgColor = const Color(0xffDFB35E);
      return showCouponDetails(couponData, bgColor);
    } else if (couponData.currentStatus == "used") {
      var bgColor = const Color(0xff807C7C);
      return showCouponDetails(couponData, bgColor);
    } else {
      var bgColor = Color(0xff852A09);
      return showCouponDetails(couponData, bgColor);
    }
  }

  Widget showCouponStatus(String status, UserCouponDetailsModel couponData) {
    if (status == "active") {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              "Active",
              style: secondaryTextStyle(color: Colors.orange),
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
              style: secondaryTextStyle(color: orange),
            ),
            Text(
              "${couponData.booking_date}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
            )
          ],
        ),
      );
    } else if (status == "confirm") {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "Confirmed",
                style: secondaryTextStyle(color: Colors.orange),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "${couponData.booking_date}",
                style: secondaryTextStyle(color: Colors.orange, size: 12),
              ),
            )
          ],
        ),
      );
    } else if (status == "expired") {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              "Expired",
              style: secondaryTextStyle(color: Colors.orange),
            ),
            Text(
              "  ${DateConverter.getExpiryDateFormTimestamp(widget.membershipData.createdAt ?? Timestamp.now(), widget.membershipData.duration ?? "0")}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
            )
          ],
        ),
      ); /*   Text( "Expired", style: secondaryTextStyle(color: redColor), );*/
    } else if (status == "rejected") {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              "Rejected",
              style: secondaryTextStyle(color: Colors.orange),
            ),
            Text(
              "  ${DateConverter.getExpiryDateFormTimestamp(widget.membershipData.createdAt ?? Timestamp.now(), widget.membershipData.duration ?? "0")}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
            )
          ],
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              "Used",
              style: secondaryTextStyle(color: Colors.orange),
            ),
            Text(
              "  ${DateConverter.getExpiryDateFormTimestamp(widget.membershipData.createdAt ?? Timestamp.now(), widget.membershipData.duration ?? "0")}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
            )
          ],
        ),
      ); /*   Text( "Used", style: secondaryTextStyle(color: redColor), );*/
    }
  }

  Widget showCouponDetails(UserCouponDetailsModel couponData, Color bgColor) {
    return InkWell(
      onTap: () => UserCouponDetails(
        couponId: couponData.id ?? "",
        brandId: widget.membershipData.brandId ?? "",
        membershipData: widget.membershipData,
      ).launch(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: boxDecorationRoundedWithShadow(
          8,
          shadowColor: appThemeColor,
          backgroundColor: bgColor,
          blurRadius: 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  showCouponStatus(
                      couponData.currentStatus ?? "used", couponData),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                couponData.couponType ?? "",
                style: boldTextStyle(color: white, size: 14),
              ),
            ),
            5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 84.w,
                  child: Text(
                    couponData.description ?? "NA",
                    style: boldTextStyle(color: white, size: 18),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )
              ],
            ),
            20.height,
            Text(
              couponData.brand_name ?? "",
              style: secondaryTextStyle(color: orange, size: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Voucher - ${couponData.couponId}",
                  style: secondaryTextStyle(color: white, size: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}