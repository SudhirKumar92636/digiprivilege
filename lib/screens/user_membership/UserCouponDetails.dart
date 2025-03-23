import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:membership/models/membership/UserCouponDetailsModel.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/screens/user_membership/components/UserCouponComponent.dart';
import 'package:membership/screens/user_membership/components/UserMembershipComponent.dart';
import 'package:membership/screens/user_membership/services/UserCouponService.dart';
import 'package:membership/utils/Global/global.dart';
import 'package:membership/utils/colors.dart';
import 'package:membership/utils/styles/buttonStyle.dart';
import 'package:membership/utils/styles/textStyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../models/UserMembershipDetailsModel.dart';
import '../../models/brand/HotelModel.dart';
import '../../services/PushNofitication.dart';
import '../../utils/data/data_storage.dart';
import '../../utils/functions/randomValues.dart';
import '../../utils/helper/date_converter.dart';
import '../../utils/styles/ImageView.dart';
import '../brand/components/BrandComponent.dart';
import '../membership/services/MembershipPaymentService.dart';

class UserCouponDetails extends StatefulWidget {
  final String brandId;
  final String couponId;

  final UserMembershipDetailsModel membershipData;

  const UserCouponDetails(
      {Key? key,
      required this.brandId,
      required this.couponId,
      required this.membershipData})
      : super(key: key);

  @override
  State<UserCouponDetails> createState() => _UserCouponDetailsState();
}

class _UserCouponDetailsState extends State<UserCouponDetails> {
  var fcmTokens = [""];
  String userName = "";
  String userId = "";
  String selectedBrandId = "";
  String selectedHotel = "Select Hotel";
  bool isHotelShowing = false;

  List<HotelModal> allHotels = [];
  List<String> hotelSpinnerItems = ["Select Hotel"];

  @override
  void initState() {
    super.initState();
    getUserDetails();
    MembershipService()
        .getAllHotel(userId, widget.membershipData.membershipId ?? "")
        .then((value) => {
              allHotels = value,
              for (var element in value)
                {hotelSpinnerItems.add(element.name ?? "")},
              setState(() {})
            });
  }

  getUserDetails() async {
    await AppData.getString(userIdKey).then((value) {
      setState(() {
        userId = value;
      });
    });
    await AppData.getString(firstNameKey).then((value) {
      setState(() {
        userName = value;
      });
    });
    await AppData.getString(lastNameKey).then((value) {
      setState(() {
        userName = userName + " " + value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coupon Details"),
      ),
      body: StreamBuilder(
        stream: UserCouponService().getCouponsDetails(widget.couponId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            UserCouponDetailsModel couponData = snapshot.data;
            if (couponData.brand_id != "") {
              selectedBrandId = couponData.brand_id ?? "";
            }
            return Stack(
              children: [
                ListView(
                  children: [
                    10.height,
                    couponDetailsView(couponData),
                    20.height,
                    Visibility(
                      visible: isHotelShowing,
                      child: DropdownButtonFormField<String>(
                        value: selectedHotel,
                        isExpanded: true,
                        dropdownColor: Colors.grey,
                        decoration: const InputDecoration(
                            labelText: "Select Hotel",
                            prefixIcon: Icon(
                              CupertinoIcons.person_2,
                              size: 20,
                            )),
                        items: hotelSpinnerItems.map((spinnerItems) {
                          return DropdownMenuItem(
                              value: spinnerItems,
                              child: Text(
                                spinnerItems,
                                style: smallTextStyle(),
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedHotel = newValue!;
                          });
                        },
                      ).paddingSymmetric(horizontal: 16),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 20, left: 10, right: 10, child: isStay(couponData))
              ],
            );
          } else {
            return emptyList("Coupons Available Yet!");
          }
        },
      ),
    );
  }

  Widget isStay(UserCouponDetailsModel couponData) {
    if (couponData.is_stay == true) {
      return ElevatedButton(
          style: elevatedButtonStyle(6.h, 90.w, color: redColor),
          onPressed: () {
            finish(context);
          },
          child: const Text(
            "Close",
            style: TextStyle(color: black),
          ));
    } else {
      return showRequestButtons(couponData.currentStatus ?? "used",
          couponData.id ?? "", couponData.isBooking ?? false, couponData);
    }
  }

  couponDetailsView(UserCouponDetailsModel data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: boxDecorationRoundedWithShadow(
        8,
        shadowColor: appThemeColor,
        backgroundColor: fillColor,
        blurRadius: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Coupon Details",
                style: boldTextStyle(color: white, size: 14),
              ),
              Text(
                "Expires - ${DateConverter.getExpiryDateFormTimestamp(data.createdAt ?? Timestamp.now(), widget.membershipData.duration ?? "0")}",
                style: secondaryTextStyle(color: Colors.orange, size: 12),
              )
            ],
          ),
          const Divider(
            color: white,
          ),
          Text(
            data.title ?? "NA",
            style: GoogleFonts.inter(color: white, fontSize: 18),
          ),
          2.height,
          showAndHideText(data.description ?? ""),
          Visibility(
              visible: isRejected(data.currentStatus ?? ""),
              child: Text(
                data.rejection_reason ?? "NA",
                style: secondaryTextStyle(color: Colors.orange, size: 12),
              )).paddingTop(10),
          data.membershipNumber != null && data.membershipNumber != ""
              ? Text(
                  "Membership Number ${data.membershipNumber ?? ""}",
                  style: secondaryTextStyle(color: orange),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          Align(
            alignment: Alignment.bottomRight,
            child: showCouponStatus(
                data.currentStatus ?? "used", data.couponType ?? ""),
          )
        ],
      ),
    );
  }

  bool isRejected(
    String currentStatus,
  ) {
    if (currentStatus == "rejected") {
      return true;
    } else {
      return false;
    }
  }

  showRequestButtons(String status, String couponId, bool isBooking,
      UserCouponDetailsModel couponData) {
    if (status == "active" || status == "rejected") {
      isHotelShowing = true;
      return ElevatedButton(
          style: elevatedButtonStyle(6.h, 90.w, color: greenColor),
          onPressed: () {
            if (selectedHotel == "Select Hotel") {
              Fluttertoast.showToast(msg: "Kindly select a Hotel");
            } else {
              var brandId = "";
              var partnerId = "";
              HotelModal hotelDetail = HotelModal();
              for (var hotel in allHotels) {
                if (hotel.name == selectedHotel) {
                  brandId = hotel.brandId ?? "";
                  partnerId = hotel.partnerId ?? "";
                  hotelDetail = hotel;
                }
              }

              var formatter = DateFormat('yyyy-MM-dd');
              String formatTodayDate = formatter.format(currentDate);
              if (couponData.couponType == "food") {
                if (widget.membershipData.isFoodWithoutStay == true) {
                  showFoodRequestAlert(
                      couponId, couponData, brandId, hotelDetail);
                } else {
                  MembershipPaymentService()
                      .checkBookedStay(formatTodayDate, userId)
                      .then((value) {
                    if (value.docs.isNotEmpty) {
                      showFoodRequestAlert(
                          couponId, couponData, brandId, hotelDetail);
                    } else {
                      Fluttertoast.showToast(msg: "Kindly book a stay");
                    }
                  });
                }
              } else {
                showBookingDateAlert(
                    couponId, couponData, brandId, hotelDetail);
              }
            }
          },
          child: const Text("Send Request"));
    } else if (status == 'requested' || status == "confirm") {
      // if (couponData.couponType !="food") {
      isHotelShowing = false;
      // }
      return ElevatedButton(
          style: elevatedButtonStyle(6.h, 90.w, color: yellow),
          onPressed: () {
            if (couponData.couponType == "food") {
              showWithdrewAlert(couponId, couponData);
            } else {
              final fifteenAgo = new DateTime.now();
              var bDate = couponData.booking_dateTime?.toDate();
              var a = bDate!.difference(fifteenAgo).inHours;
              if (a > 48) {
                showWithdrewAlert(couponId, couponData);
              } else {
                Fluttertoast.showToast(msg: "Can't withdrew before 2 days");
              }
            }
          },
          child: const Text(
            "Withdrew",
            style: TextStyle(color: black),
          ));
    } else if (status == 'used' || status == "expired") {
      return ElevatedButton(
          style: elevatedButtonStyle(6.h, 90.w, color: redColor),
          onPressed: () {},
          child: const Text("Used"));
    } else {
      return Container();
    }
  }

  Future<void> updateCouponData(
      String couponId, Map<String, dynamic> data) async {
    var db = FirebaseFirestore.instance.collection("user_coupons");
    await db.doc(couponId).update(data);
  }

  showWithdrewAlert(
    String couponId,
    UserCouponDetailsModel couponData,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Withdrew Coupon Alert",
              style: boldTextStyle(),
            ).paddingBottom(10),
            content: Text(
              "Are you sure? Do you want to withdrew your coupon now?.",
              style: secondaryTextStyle(),
            ).paddingLeft(15),
            actions: [
              ElevatedButton(
                  style: elevatedButtonStyle(4.h, 24.w, color: grey),
                  onPressed: () {
                    finish(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style: elevatedButtonStyle(4.h, 24.w, color: redColor),
                  onPressed: () {
                    UserCouponService()
                        .updateCouponStatus(couponId, "active", "", "", "")
                        .then((value) {
                      fcmTokens.clear();
                      var notificationData = PushNotification().getFcmToken(
                          couponData.brand_id ?? "",
                          couponData.partnerId ?? "");
                      notificationData.then((value) => {
                            fcmTokens.add(value[0].fcmToken.toString()),
                            PushNotification().sendNotification(
                                "Coupon Withdrawal",
                                "$userName has withdrew a coupon of ${couponData.brand_name}",
                                couponData.id ?? couponId,
                                fcmTokens,
                                "stay"),
                          });
                      finish(context);
                    });
                  },
                  child: const Text('Yes')),
            ],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          );
        });
  }

  showFoodRequestAlert(String couponId, UserCouponDetailsModel couponData,
      String brandId, HotelModal hotelDetails) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Food Coupon Request",
              style: boldTextStyle(),
            ).paddingBottom(10),
            content: Text(
              "Are you sure? you want to send a food coupon request.",
              style: secondaryTextStyle(),
            ).paddingLeft(15),
            actions: [
              ElevatedButton(
                  style: elevatedButtonStyle(4.h, 24.w, color: grey),
                  onPressed: () {
                    finish(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style: elevatedButtonStyle(4.h, 24.w, color: greenColor),
                  onPressed: () {
                    UserCouponService().updateFoodCouponStatus(
                        couponId,
                        "requested",
                        hotelDetails.partnerId ?? "",
                        hotelDetails.name ?? "");
                    fcmTokens.clear();
                    var notificationData = PushNotification()
                        .getFcmToken(brandId, hotelDetails.partnerId ?? "");
                    notificationData.then((value) => {
                              fcmTokens.add(value[0].fcmToken.toString()),
                              PushNotification().sendNotification(
                                  "Coupon Request",
                                  "$userName has booked a coupon in ${hotelDetails.name}",
                                  couponData.id ?? couponId,
                                  fcmTokens,
                                  "stay")
                            }
                        // value.forEach((element) {
                        //   fcmTokens.add(element.fcmToken.toString());
                        // })
                        );

                    finish(context);
                  },
                  child: const Text('Yes')),
            ],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          );
        });
  }

  int getDaysFromDate() {
    var date1 = DateTime(2022, 08, 16);
    var date2 = DateTime(2022, 08, 14);
    return date1.difference(date2).inDays;
  }

  showBookingDateAlert(String couponId, UserCouponDetailsModel couponData,
      String brandId, HotelModal hotelDetails) {
    String dateTime = '';
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                content: SizedBox(
                  height: 20.h,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              "Please select the booking date.",
                              style: secondaryTextStyle(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 15),
                            child: InkWell(
                              child: const Icon(
                                Icons.close,
                                color: black,
                              ),
                              onTap: () {
                                finish(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      20.height,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SizedBox()
                        // DateTimePicker(
                        //   enableInteractiveSelection: false,
                        //   type: DateTimePickerType.date,
                        //   dateMask: 'd MMM yyyy',
                        //   decoration: const InputDecoration(
                        //       labelStyle: TextStyle(color: Colors.white)),
                        //   initialValue: DateTime.now().toString(),
                        //   firstDate: DateTime.now(),
                        //   style: const TextStyle(color: Colors.white),
                        //   lastDate:
                        //       DateTime.now().add(const Duration(days: 365)),
                        //   // timePickerEntryModeInput: false,
                        //
                        //   onChanged: (val) {
                        //     setState(() {
                        //       dateTime = val;
                        //     });
                        //   },
                        // ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      style:
                          elevatedButtonStyle(4.h, 90.w, color: Colors.orange),
                      onPressed: () {
                        if (dateTime == "") {
                          Fluttertoast.showToast(
                              msg: "Please select a preferred date");
                        } else {
                          var fcmDescription =
                              "$userName has booked a stay in ${hotelDetails.name}";
                          var partnerId = hotelDetails.partnerId ?? "";
                          var hotelName = hotelDetails.name ?? "";
                          var stayId = "user_stays_${generateRandomString(10)}";
                          var checkIn = DateTime.parse(dateTime);
                          var checkOut = DateTime.parse(dateTime).add(Duration(days: 1));
                          var couponsIdList = [];
                          couponsIdList.add(couponData.id);

                          var description =
                              "1 Room for 1 Day from on $selectedStartDate of $hotelName, ${widget.membershipData.membershipNumber}";

                          var nextSevenDays = [];
                          var betweenDays = [];
                          nextSevenDays.add(dateTime);
                          betweenDays.add(dateTime);
                          MembershipPaymentService().addBookStay(stayId, {
                            "id": stayId,
                            "agent_id": agentId,
                            "partner_id": partnerId,
                            "brand_id": brandId,
                            "brand_name": hotelName,
                            "membership_id": widget.membershipData.id,
                            "user_id": userId,
                            "user_name": userName,
                            "check_in_date": dateTime,
                            "check_out_date": dateTime,
                            "check_in_date_time": checkIn,
                            "check_out_date_time": checkOut,
                            "amount": couponData.price,
                            "status": "pending",
                            "rooms": "1",
                            "duration": 1,
                            "hotel_image": hotelDetails.image,
                            "coupons": couponsIdList,
                            "description": description,
                            "next_seven_days": nextSevenDays,
                            "between_days": betweenDays,
                            "membership_number":
                                couponData.membershipNumber ?? "",
                          });

                          UserCouponService().updateCouponStatus(couponId ?? "",
                              "is_stay", partnerId ?? "", hotelName, "");

                          fcmTokens.clear();

                          var notificationData = PushNotification().getFcmToken(
                              hotelDetails.brandId ?? brandId, partnerId ?? "");
                          notificationData.then((value) => {
                                fcmTokens.add(value[0].fcmToken.toString()),
                                PushNotification().sendNotification(
                                    "One day stay request",
                                    fcmDescription,
                                    couponData.id ?? couponId,
                                    fcmTokens,
                                    "stay")
                              });

                          finish(context);
                          finish(context);
                        }
                      },
                      child: const Text('Confirm'))
                ],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              );
            },
          );
        });
  }
}
