import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:membership/screens/user_membership/services/UserCouponService.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../models/UserMembershipDetailsModel.dart';
import '../../models/membership/UserCouponDetailsModel.dart';
import '../../utils/colors.dart';
import '../../utils/helper/date_converter.dart';
import '../../utils/styles/textStyle.dart';
import '../brand/MembershipList.dart';
import 'UserCouponDetails.dart';

class RoomVouchersFragment extends StatefulWidget {
  final UserMembershipDetailsModel membershipData;

  const RoomVouchersFragment({Key? key, required this.membershipData})
      : super(key: key);

  @override
  State<RoomVouchersFragment> createState() => _RoomVouchersFragmentState();
}

class _RoomVouchersFragmentState extends State<RoomVouchersFragment> {
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
      body: Container(
        decoration: BoxDecoration(color: black),
        child: StreamBuilder(
          stream: UserCouponService()
              .getRoomVoucher(widget.membershipData.id ?? "", userId),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<UserCouponDetailsModel> couponData = snapshot.data;
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  itemBuilder: (context, index) {
                    return couponItemView(couponData[index]);
                  },
                  separatorBuilder: (context, index) {
                    return 10.height;
                  },
                  itemCount: couponData.length);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MembershipList()));
          },
          child: Container(
            height: 45.0,
            child: const Center(
                child: Text(
              "Book a stay",
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 16),
            )),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.5), color: orange),
          )).paddingLeft(30),
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
          ), /*showRequestButtons(data.currentStatus ?? "", data.id ?? "")*/
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
    var brandName = "";
    if (couponData.brand_name !="" && couponData.membershipNumber !="" && couponData.brand_name!= null) {
      brandName = "${couponData.brand_name}, ${couponData.membershipNumber}";
    }  else if (couponData.brand_name != null && couponData.brand_name !="") {
      brandName = "${couponData.brand_name}";
    } else {
      brandName = "${couponData.membershipNumber}";
    }
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
              padding: const EdgeInsets.only(top: 8.0),
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
              brandName,
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