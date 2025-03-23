import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membership/models/membership/CouponDetailsModel.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/utils/colors.dart';
import 'package:membership/utils/styles/textStyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../models/membership/MembershipDetailsModel.dart';
import '../../../utils/styles/ImageView.dart';

paymentFailedDialog(BuildContext context, Function() tryAgain) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                // order();
                tryAgain();
              },
              child: const Text(
                "Try Again",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 40,
              ),
              10.width,
              const Text(
                "Payments failed",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
          content: Text(
            "Due to network error your payment have been failed.",
            style: secondaryTextStyle(),
          ),
        );
      });
}

couponsItemListView(
    String membershipId, bool isAll, BuildContext context, int limit) {
  return FutureBuilder(
    future: MembershipService().getAllCouponsByMembership(
        membershipId, FirebaseAuth.instance.currentUser!.uid),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        List<CouponDetailsModel> data = snapshot.data;

        return Column(
          children: [
            availableCouponTitle(isAll, membershipId, context),
            SizedBox(
              height: isAll == true ? 65.h : 80.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemBuilder: (context, index) {
                  var numC = data[index].number_of_coupons ?? 1;
                  if (numC > 2) {
                    return couponListItem(data[index], context, "Vouchers");
                  } else {
                    return couponListItem(data[index], context, "Voucher");
                  }
                },
                itemCount: data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return 10.height;
                },
              ),
            )
          ],
        );
      } else {
        return const Text("No data");
      }
    },
  );
}

Widget couponListItem(
    CouponDetailsModel data, BuildContext context, String voucher) {
  return Container(
    width: 60.w,
    decoration: BoxDecoration(
        color: Color(int.parse(data.colorCode ?? 0xff333333.toString())),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: 50,
            width: 100,
            child: ClipRRect(
              child: showNetworkImageWithCached(
                  data.brandLogo ??
                      "https://firebasestorage.googleapis.com/v0/b/urlifemebership.appspot.com/o/brands%2Fbanyan_retreat%2Flogo%2Flogo.png?alt=media&token=4976e5de-63cf-4bee-98ee-803c8f5bdcf4",
                  5.h,
                  90.w,
                  10),
            ),
          ).paddingAll(10),
        ),
        Center(
          child: Text(
            data.title ?? "NA",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ).paddingSymmetric(horizontal: 10).paddingBottom(5),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.couponImage ?? ""),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 8.h,
                  width: 8.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black54),
                  child: Center(
                      child: Text(
                    "${data.number_of_coupons ?? 1}",
                    style: TextStyle(
                        color: white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Text(
                  voucher,
                  style: TextStyle(color: white, fontWeight: FontWeight.bold),
                ).paddingTop(5),
              ],
            )
                .paddingLeft(39.w)
                .paddingRight(15.5)
                .paddingTop(7.h)
                .paddingBottom(2.h),
          ),
        ),
        Center(
          child: Text(
            "(Valid in Digiprivilege)",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.normal),
          ).paddingSymmetric(horizontal: 10).paddingBottom(5),
        ),
        Wrap  (
          children: [
            Center(
              child: Text(
                data.description?.toUpperCase() ??
                    "Complementary Room night stay with Breakfast "
                        .toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 5),
        const Divider(
          color: white,
        ),
        Text(
          data.termOfUse ??
              "Valid for 2 Adults and 2 kids up to 6 years. Booking to be done in advance and subject to availability. 2 complementary room night certificate can't be used together, minimum 7 days of gap",
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
          style: GoogleFonts.inter(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
        ).paddingSymmetric(horizontal: 10).paddingTop(0),
      ],
    ),
  ).onTap(() {
    showCouponDetailsDialog(context, data);
  }).paddingRight(15);
}

Widget couponDetailsItem(CouponDetailsModel data, BuildContext context) {
  return Container(
    width: 80.w,
    decoration: BoxDecoration(
        color: fillColor, borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: showNetworkImageWithCached(
              data.couponImage ?? "https://gos3.ibcdn.com/top-1568020025.jpg",
              12.h,
              90.w,
              10),
        ),
        Text(
          data.brandName ?? "NA",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ).paddingSymmetric(horizontal: 10).paddingTop(5),
        Text(
          data.title ?? "NA",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
        ).paddingSymmetric(horizontal: 10, vertical: 5),
        showAndHideText(data.description ?? "")
            .paddingOnly(bottom: 10, left: 10, right: 10),
      ],
    ),
  ).onTap(() {
    showCouponDetailsDialog(context, data);
  });
}

availableCouponTitle(bool isAll, String membershipId, BuildContext context) {
  return isAll == true
      ? Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vouchers",
                style: GoogleFonts.inter(
                    color: white,
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ).paddingSymmetric(horizontal: 10),
            ],
          ),
        )
      : Container();
}

Widget imageWithIndicatorsMembership(BuildContext context, List<String> images,
    double aspectRadio, MembershipDetailsModel data) {
  var _current = 0;
  return StatefulBuilder(builder: (context, state) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: CarouselSlider(
              items: images.map((slider) {
                return Builder(builder: (BuildContext context) {
                  return Stack(
                    children: [
                      SizedBox(
                          height: 30.h,
                          width: 100.w,
                          child: InkWell(
                            onTap: () {},
                            child: showNetworkImageWithCached(
                                slider, 30.h, 100.w, 0),
                          )),
                    ],
                  );
                });
              }).toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.0,
                  aspectRatio: aspectRadio,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    state(() {
                      _current = index;
                    });
                  })).paddingBottom(20),
        ),
        Positioned.directional(
            textDirection: Directionality.of(context),
            bottom: 10.0,
            end: 0,
            start: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map((slider) {
                int index = images.indexOf(slider);
                return Container(
                  width: 8,
                  height: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.orange
                          : Colors.white.withOpacity(0.9)),
                );
              }).toList(),
            )),
      ],
    );
  });
}

showCouponDetailsDialog(BuildContext context, CouponDetailsModel data) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          width: 90.w,
          height: 80.h,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          child: showNetworkImageWithCached(
                              data.couponImage.toString(), 24.h, 99.w, 4))),
                  Text(
                    data.brandName ?? "NA",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(horizontal: 10).paddingTop(10),
                  Text(
                    data.title ?? "NA",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(horizontal: 10, vertical: 7),
                  showAndHideText(data.description ?? "", color: Colors.black)
                      .paddingOnly(bottom: 10, left: 10, right: 10),
                  showAndHideText(
                          data.termOfUse ??
                              "Valid for 2 adults and 2 kids up to 6 years, Booking to be done in advance and subject to availability. 2 complementary room night certificate and can't be..",
                          color: Colors.black)
                      .paddingOnly(bottom: 10, left: 10, right: 10),
                ],
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: ElevatedButton(
                      onPressed: () {
                        finish(context);
                      },
                      child: const Text("Close")))
            ],
          ),
        );
      });
}