import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:membership/models/brand/HotelModel.dart';
import 'package:membership/screens/brand/SelectCouponsItem.dart';
import 'package:membership/screens/membership/services/MembershipPaymentService.dart';
import 'package:membership/screens/user_membership/services/UserCouponService.dart';
import 'package:membership/utils/Global/global.dart';
import 'package:membership/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../models/UserMembershipDetailsModel.dart';
import '../../models/membership/UserCouponDetailsModel.dart';
import '../../services/PushNofitication.dart';
import '../../utils/data/data_storage.dart';
import '../../utils/functions/randomValues.dart';
import '../../utils/helper/date_converter.dart';
import '../../utils/styles/textStyle.dart';

class SelectCouponScreen extends StatefulWidget {
  final HotelModal hotelModel;
  final UserMembershipDetailsModel membershipDetailsModel;

  const SelectCouponScreen(
      {Key? key,
      required this.hotelModel,
      required this.membershipDetailsModel})
      : super(key: key);

  @override
  State<SelectCouponScreen> createState() => _SelectCouponScreenState();
}

class _SelectCouponScreenState extends State<SelectCouponScreen> {
  String userId = "";
  String userName = "";
  var enableButton = false;
  bool _isLoading = false;
  bool selected = false;
  bool isComplementary = false;

  var nomOfBooking = 0;
  var couponSize = 0;
  bool isBgChanged = false;
  var bgColor = Color(0xff363837);
  List<UserCouponDetailsModel> selectedCouponse = [];
  List<UserCouponDetailsModel> selectedCouponsAfterAdding = [];
  List<UserCouponDetailsModel> privilegeCoupons = [];
  var checkIn = DateTime.parse(selectedStartDate);
  var checkOut = DateTime.parse(selectedEndDate);
  var diffrence = 0;

  // var duration = checkOut.difference(checkIn).inDays;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    diffrence = checkOut.difference(checkIn).inDays;
    checkOut.difference(checkIn).inDays;

    await AppData.getString(userIdKey).then((value) {
      setState(() {
        userId = value;
      });
    });
    await UserCouponService()
        .getPrivilegeCard(widget.hotelModel.brandId ?? "", userId, "active",
            widget.membershipDetailsModel.id ?? "")
        .then((value) => privilegeCoupons.addAll(value));

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

    numberOfRoomsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Coupons"),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: black),
          child: StreamBuilder(
            stream: UserCouponService().getSelectCouponsData(
                widget.hotelModel.brandId ?? "",
                userId,
                "active",
                widget.membershipDetailsModel.id ?? ""),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                isComplementary = false;

                List<UserCouponDetailsModel> couponData = snapshot.data;

                couponSize = (couponData.length);
                return (couponData.length) != 0
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 10,
                        ),
                        itemBuilder: (context, index) {
                          return SelectedCouponsItem(
                              item: couponData[index],
                              hotelModel: widget.hotelModel,
                              isSelected: (bool value) {
                                setState(() {});
                                if (value) {
                                  setState(() {});
                                  if (couponData[index].type ==
                                      "complimentary room") {
                                    if (isComplementary == false) {
                                      selectedCouponse.add(couponData[index]);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Can't use 2 complimentary room night");
                                    }
                                  } else {
                                    selectedCouponse.add(couponData[index]);
                                  }
                                  nomOfBooking = selectedCouponse.length;
                                } else {
                                  setState(() {});
                                  for (var ind = 0;
                                      ind < selectedCouponse.length;
                                      ind++) {
                                    if (selectedCouponse[ind].id ==
                                        couponData[index].id) {
                                      selectedCouponse.removeAt(ind);
                                    }
                                  }
                                  nomOfBooking = selectedCouponse.length;
                                }

                                if (selectedCouponse.isNotEmpty) {
                                  enableButton = true;
                                } else {
                                  enableButton = false;
                                }
                              },
                              key: Key(couponData[index].id ?? ""));
                        },
                        separatorBuilder: (context, index) {
                          return 10.height;
                        },
                        itemCount: couponData.length)
                    : StreamBuilder(
                        stream: UserCouponService().getPrivilegeCouponsData(
                            widget.hotelModel.brandId ?? "",
                            userId,
                            "active",
                            widget.membershipDetailsModel.id ?? ""),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            List<UserCouponDetailsModel> cardData =
                                snapshot.data;
                            couponSize = 1;
                            return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return SelectedCouponsItem(
                                    hotelModel: widget.hotelModel,
                                      item: cardData[index],
                                      isSelected: (bool value) {
                                        setState(() {});
                                        if (value) {
                                          setState(() {});
                                          if (cardData[index].type ==
                                              "complimentary room") {
                                            if (isComplementary == false) {
                                              selectedCouponse
                                                  .add(cardData[index]);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Can't use 2 complimentary room night");
                                            }
                                          } else {
                                            selectedCouponse
                                                .add(cardData[index]);
                                          }
                                          nomOfBooking =
                                              selectedCouponse.length;
                                        } else {
                                          setState(() {});
                                          for (var ind = 0;
                                              ind < selectedCouponse.length;
                                              ind++) {
                                            if (selectedCouponse[ind].id ==
                                                cardData[index].id) {
                                              selectedCouponse.removeAt(ind);
                                            }
                                          }
                                          nomOfBooking =
                                              selectedCouponse.length;
                                        }

                                        if (selectedCouponse.isNotEmpty) {
                                          enableButton = true;
                                        } else {
                                          enableButton = false;
                                        }
                                      },
                                      key: Key(cardData[index].id ?? ""));
                                },
                                separatorBuilder: (context, index) {
                                  return 10.height;
                                },
                                itemCount: cardData.length);
                          } else {
                            return Container();
                          }
                        });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: enableButton,
        child: InkWell(
          child: MaterialButton(
            height: 45.0,
            minWidth: 335.0,
            color: Colors.orange,
            textColor: Colors.white,
            child: Text("Proceed with $nomOfBooking coupons"),
            onPressed: () => {manageCoupons()},
            splashColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.5)),
          ),
        ),
      ),
    );
  }

  manageCoupons() {
    selectedCouponsAfterAdding.addAll(selectedCouponse);
    //for adding 1 extra coupon one every buy one get one
    List<UserCouponDetailsModel> buy1get1C = [];
    for (var element in selectedCouponsAfterAdding) { 
      if (element.type=="buy one get one") {
        buy1get1C.add(element);
      }  
    }
    if (buy1get1C.isNotEmpty) {
      selectedCouponsAfterAdding.addAll(buy1get1C);
    }
    // this code will be apply when there will not be any coupons (for privilege card all time)
    if (numberOfRoomsController.text.isNotEmpty) {
      var numberOfRooms = numberOfRoomsController.text.toInt() * diffrence;

      for (var i = 1; i < numberOfRooms; i++) {
        selectedCouponsAfterAdding.add(selectedCouponsAfterAdding[0]);
      }
    }

    var couponSize = selectedCouponsAfterAdding.length;

    var addNoCoupons = 0;
    var c2 = diffrence * 2;
    var c3 = diffrence * 3;
    var c4 = diffrence * 4;
    var c5 = diffrence * 5;
    var c6 = diffrence * 6;

    if (couponSize > 0 && couponSize < diffrence) {
      addNoCoupons = diffrence - couponSize;
      for (int i = 0; i < addNoCoupons; i++) {
        selectedCouponsAfterAdding.add(privilegeCoupons[0]);
      }
      showAmount(context, addNoCoupons);
    }else if (couponSize == diffrence) {
      showAmount(context, addNoCoupons);
    } else if (couponSize > diffrence && couponSize < c2) {
      addNoCoupons = c2 - couponSize;

      for (int i = 0; i < addNoCoupons; i++) {
        selectedCouponsAfterAdding.add(privilegeCoupons[0]);
      }

      showAmount(context, addNoCoupons);
    } else if (couponSize == c2) {
      showAmount(context, addNoCoupons);
    } else if (couponSize > c2 && couponSize < c3) {
      addNoCoupons = c3 - couponSize;
      for (int i = 0; i < addNoCoupons; i++) {
        selectedCouponsAfterAdding.add(privilegeCoupons[0]);
      }

      showAmount(context, addNoCoupons);
    } else if (couponSize == c3) {
      showAmount(context, addNoCoupons);
    } else if (couponSize > c3 && couponSize < c4) {
      addNoCoupons = c4 - couponSize;
      for (int i = 0; i < addNoCoupons; i++) {
        selectedCouponsAfterAdding.add(privilegeCoupons[0]);
      }

      showAmount(context, addNoCoupons);
    } else if (couponSize == c4) {
      showAmount(context, addNoCoupons);
    } else if (couponSize > c4 && couponSize < c5) {
      addNoCoupons = c5 - couponSize;
      for (int i = 0; i < addNoCoupons; i++) {
        selectedCouponsAfterAdding.add(privilegeCoupons[0]);
      }

      showAmount(context, addNoCoupons);
    } else if (couponSize == c5) {
      showAmount(context, addNoCoupons);
    } else if (couponSize > c5 && couponSize < c6) {
      addNoCoupons = c6 - couponSize;
      for (int i = 0; i < addNoCoupons; i++) {
        selectedCouponsAfterAdding.add(privilegeCoupons[0]);
      }
      showAmount(context, addNoCoupons);
    } else if (couponSize == c6) {
      showAmount(context, addNoCoupons);
    } else {
      selectedCouponsAfterAdding.clear();
      selectedCouponsAfterAdding.clear();
      numberOfRoomsController.clear();
      Fluttertoast.showToast(msg: "Can't book more than 6 rooms/day");
    }
  }

  showAmount(BuildContext context, int extraCoupon) {

    num totalAmount = 0;
    num buy1get1 = 0;
    int duration = 0;
    var rooms = 1.0;
    var fcmTokens = [""];
    var memNum = widget.membershipDetailsModel.membershipNumber;
    var memNumber ="from membership number $memNum";
    for (var element in selectedCouponsAfterAdding) {
      num amount = element.price ?? 0.0;
      if (element.couponType == "card") {
        amount = amount * 60;
        amount = amount / 100;
        totalAmount = totalAmount + amount;
      } else if(element.type == "buy one get one"){
        // 1 coupon will be free on buy1get1 coupon(room) that's why we are skipping 1,3
          if (buy1get1==0 || buy1get1 == 2  ||buy1get1 == 4 ) {
            totalAmount = totalAmount + amount;
          }
          buy1get1 ++;
      } else {
        totalAmount = totalAmount + amount;
      }

      // if there is buy one get one offer then add one coupon extra which will be free
      // if (element.type=="buy one get one") {
      //   selectedCouponsAfterAdding.add(element);
      // }
    }
    var checkIn = DateTime.parse(selectedStartDate);
    var checkOut = DateTime.parse(selectedEndDate);

    duration = checkOut.difference(checkIn).inDays;
    rooms = (selectedCouponsAfterAdding.length / duration);
    if (rooms < 1.0) {
      var a = selectedCouponsAfterAdding.length;
      rooms = a / 1.0;
    }

    var splitRoom = rooms.toString().trim().split(".");

    var description =
        "${splitRoom[0]} Room for $duration Day from $selectedStartDate to $selectedEndDate of ${widget.hotelModel.name}, $memNumber";


    if (rooms > 1.0 && duration > 1) {
      setState(() {});
      description =
          "${splitRoom[0]} Rooms for $duration Days from $selectedStartDate to $selectedEndDate of ${widget.hotelModel.name}, $memNumber";
    } else if (rooms > 1.0) {
      setState(() {});
      description =
          "${splitRoom[0]} Rooms for $duration Day from $selectedStartDate to $selectedEndDate of ${widget.hotelModel.name}, $memNumber";
    } else if (duration > 1) {
      setState(() {});
      description =
          "${splitRoom[0]} Room for $duration Days from $selectedStartDate to $selectedEndDate of ${widget.hotelModel.name}, $memNumber";
    }

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: 240,
            child: ListView(
              children: [
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      description,
                    )),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Icon(
                          Icons.close_rounded,
                          color: black,
                        ),
                        onTap: () {
                          selectedCouponsAfterAdding.clear();
                          numberOfRoomsController.clear();
                          finish(context);
                        },
                      ),
                    )
                  ],
                ),
                20.height,
                const Center(
                    child: Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Center(
                    child: Text(
                  "$rupee $totalAmount",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )).paddingTop(10),
                MaterialButton(
                  height: 45.0,
                  minWidth: 70.0,
                  color: Colors.orange,
                  textColor: Colors.white,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: fillColor,
                        )
                      : const Text("Conform"),
                  onPressed: () {
                    try {
                      var stayId = "user_stays_${generateRandomString(10)}";
                      var couponsIdList = [];
                      var nextSevenDays = [];
                      var betweenDays = [];
                      var days = getDaysInBetween(
                          DateTime.parse(selectedStartDate),
                          DateTime.parse(selectedEndDate));
                      for (var i = 0; i < days.length; i++) {
                        betweenDays.add(days[i].toString().split(" ")[0]);
                      }

                      for (var i = 0; i < 7 + diffrence; i++) {
                        var date = DateTime.parse(selectedStartDate)
                            .add(Duration(days: i));
                        nextSevenDays.add(date.toString().split(" ")[0]);
                      }
                      for (var element in selectedCouponsAfterAdding) {
                        couponsIdList.add(element.id);
                      }
                      MembershipPaymentService().addBookStay(stayId, {
                        "id": stayId,
                        "agent_id": agentId,
                        "partner_id": widget.hotelModel.partnerId,
                        "brand_id": widget.hotelModel.brandId,
                        "brand_name": widget.hotelModel.name,
                        "membership_id": widget.membershipDetailsModel.id,
                        "user_id": userId,
                        "user_name": userName,
                        "check_in_date": selectedStartDate,
                        "check_out_date": selectedEndDate,
                        "check_in_date_time": checkIn,
                        "check_out_date_time": checkOut,
                        "amount": totalAmount,
                        "status": "pending",
                        "rooms": splitRoom[0],
                        "duration": duration,
                        "hotel_image": widget.hotelModel.image,
                        "coupons": couponsIdList,
                        "description": description,
                        "next_seven_days": nextSevenDays,
                        "between_days": betweenDays,
                        "membership_number": memNum?? "",
                      }).then((value) {
                        Fluttertoast.showToast(
                            msg: "Your stay booking request is sent.");
                        _isLoading = false;

                        for (var element = 0;
                        element < selectedCouponsAfterAdding.length;
                        ++element) {
                          UserCouponService().updateCouponStatus(selectedCouponsAfterAdding[element].id ?? "", "is_stay", widget.hotelModel.partnerId??"", widget.hotelModel.name??"","");
                          if (selectedCouponsAfterAdding.length ==
                              element + 1) {
                            setState(() {});
                            isComplementary = false;
                            nomOfBooking = 0;
                            enableButton = false;
                            selectedCouponse.clear();
                            _isLoading = false;
                          }
                        }
                        fcmTokens.clear();
                        var notificationData = PushNotification()
                            .getFcmToken(widget.hotelModel.brandId ?? "", widget.hotelModel.partnerId??"");
                        notificationData.then((value) => {
                        fcmTokens.add(value[0].fcmToken.toString()),
                            PushNotification().sendNotification(
                            "Booking Request",
                            "$userName has booked a stay in ${widget.hotelModel.name}", stayId, fcmTokens, "stay")
                        });

                        finish(context);
                        finish(context);
                      });
                    }catch(e){
                      Fluttertoast.showToast(msg: " $e");
                    }
                  },
                  splashColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5)),
                ).paddingTop(35)
              ],
            ),
          ).paddingRight(15).paddingLeft(15);
        });
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
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

  couponItemView(UserCouponDetailsModel couponData, int index) {
    return showCouponDetails(
        couponData, bgColor, index, couponData.isSelected ?? false);
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
            Text(
              "Confirmed",
              style: secondaryTextStyle(color: Colors.orange),
            ),
            Text(
              "${couponData.booking_date}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
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
              "  ${DateConverter.getExpiryDateFormTimestamp(widget.membershipDetailsModel.createdAt ?? Timestamp.now(), widget.hotelModel.price.toString())}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
            )
          ],
        ),
      );
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
              "  ${DateConverter.getExpiryDateFormTimestamp(widget.membershipDetailsModel.createdAt ?? Timestamp.now(), widget.hotelModel.price.toString())}",
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
              "  ${DateConverter.getExpiryDateFormTimestamp(widget.membershipDetailsModel.createdAt ?? Timestamp.now(), widget.hotelModel.price.toString())}",
              style: secondaryTextStyle(color: Colors.orange, size: 12),
            )
          ],
        ),
      );
    }
  }

  Widget showCouponDetails(UserCouponDetailsModel couponData1, Color bgColor,
      int index, bool isSelected) {
    bool isComplementary = false;
    return Container(
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
                    couponData1.currentStatus ?? "used", couponData1),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              couponData1.couponType ?? "",
              style: boldTextStyle(color: white, size: 14),
            ),
          ),
          5.height,
          ListTile(
            leading: SizedBox(
              width: 76.w,
              child: Text(
                couponData1.description ?? "NA",
                style: boldTextStyle(color: white, size: 18),
              ),
            ),
            trailing: selected
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green[700],
                  )
                : const Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey,
                  ),
            onTap: () {
              bool isDeleted = false;
              if (selectedCouponse.isNotEmpty) {
                setState(() {});
                for (var element in selectedCouponse) {
                  if (element.id == couponData1.id) {
                    isDeleted = true;
                    selectedCouponse.removeAt(index);
                    nomOfBooking = nomOfBooking - 1;
                    selected = false;
                    if (nomOfBooking > 0) {
                      enableButton = true;
                    } else {
                      enableButton = false;
                    }
                  }
                }

                if (isDeleted == false) {
                  selectedCouponse.add(couponData1);

                  nomOfBooking = nomOfBooking + 1;
                  selected = true;

                  if (nomOfBooking > 0) {
                    enableButton = true;
                  } else {
                    enableButton = false;
                  }
                }
              } else {
                setState(() {});
                if (couponData1.type == "complimentary room") {
                  if (isComplementary == false) {
                    selectedCouponse.add(couponData1);
                    isComplementary = true;
                  }
                } else {
                  // if (couponData1.type=="buy one get one") {
                  //   selectedCouponse.add(couponData1);
                  //   nomOfBooking = nomOfBooking + 1;
                  // }

                  selectedCouponse.add(couponData1);

                }
                nomOfBooking = nomOfBooking + 1;
                selected = true;
                if (nomOfBooking > 0) {
                  enableButton = true;
                } else {
                  enableButton = false;
                }
              }
            },
          ),
          20.height,
          Text(
            couponData1.brand_name ?? "",
            style: secondaryTextStyle(color: orange, size: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Voucher - ${couponData1.couponId}",
                style: secondaryTextStyle(color: white, size: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}