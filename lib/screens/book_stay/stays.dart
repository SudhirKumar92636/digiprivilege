import 'package:flutter/material.dart';
import 'package:membership/models/user/StayModel.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/screens/user_membership/services/UserCouponService.dart';
import 'package:membership/utils/Global/global.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../services/PushNofitication.dart';
import '../../utils/colors.dart';
import '../../utils/styles/textStyle.dart';
import '../user_membership/components/UserMembershipComponent.dart';

class Stays extends StatefulWidget {
  const Stays({Key? key}) : super(key: key);

  @override
  State<Stays> createState() => _StaysState();
}

class _StaysState extends State<Stays> {
  String userId = "";
  String userName = "";
  String selectedStartDate = "";

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
        title: const Text("Your Bookings"),
      ),
      body: StreamBuilder<List<StayModel>>(
        stream: MembershipService().getAllStays(userId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<StayModel> data = snapshot.data;
            return data.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.only(bottom: 30, top: 20),
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.height;
                    },
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return membershipItemView(data[index]);
                    },
                  )
                : emptyList("No Stay Available Yet!");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget membershipItemView(StayModel data) {
    bool isWithdrew = false;
    bool isRejected = false;

    if (data.rejectionReason != null) {
      if (data.rejectionReason.toString() != "") {
        isRejected = true;
      } else {
        isRejected = false;
      }
    }
    DateTime co = DateTime.parse(data.checkOutDate ?? "");
    var difre1 = currentDate.difference(co).inDays;
    if (difre1 > 0 && data.status == "pending") {
      data.status == "expired" || data.status == "conformed";
      MembershipService()
          .updateExpireStayStatus(data.id ?? "")
          .then((value) => {
                data.coupons?.forEach((element) {
                  UserCouponService()
                      .updateWithdrewCouponStatus(element, 'active', 'active');
                })
              });
    }
    if (difre1 > 0 && data.status == "conformed") {
      data.status == "expired" || data.status == "pending";
      MembershipService()
          .updateConformmStayStatus(data.id ?? "")
          .then((value) => {
                data.coupons?.forEach((element) {
                  UserCouponService().updateWithdrewCouponStatus(
                      element, 'Expired', 'Expired');
                })
              });
    }
    if (data.status == "pending" || data.status == "conformed") {
      isWithdrew = true;
      data.status == "expiry";
    }
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13),
        decoration:
            boxDecorationRoundedWithShadow(12, backgroundColor: fillColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  data.hotelImage ??
                      "http://yesofcorsa.com/wp-content/uploads/2017/04/Hotels-High-Quality-Wallpaper.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              child: Text(
                data.brandName ?? "NA",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: boldTextStyle(color: white, size: 18),
              ).paddingTop(4),
            ),
            10.height,
            Align(
                alignment: Alignment.center,
                child: Text("${data.description}", style: TextStyle(color: Colors.white,fontSize: 13),)),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    2.height,
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.22,
                        child: Text(
                          data.rejectionReason ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: secondaryTextStyle(
                              color: white, size: 10, weight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 5, horizontal: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$rupee ${data.amount ?? "0"}",
                  style: secondaryTextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [stayStatus(data.status ?? "")],
                ),
              ],
            ),
            20.height,
            Visibility(
                visible: isWithdrew,
                child: InkWell(
                  onTap: () {
                    var bookingDate = data.checkInDateTime?.toDate();
                    var a = bookingDate!.difference(currentDate).inHours;
                    if (a > 48) {
                      _showDialog(context, data);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Can't withdrew before 2 days");
                    }
                  },
                  child: Container(
                    height: 45.0,
                    child: const Center(
                        child: Text(
                      "Withdrew",
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.5),
                        color: orange),
                  ),
                ).paddingBottom(10)),
            // 10.height
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 10),
      ),
    );
  }

  void _showDialog(BuildContext context, StayModel data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var fcmTokens = [""];
        return AlertDialog(
          title: const Text(
            "Withdrew Stay Alert",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            "Are you sure? You Want to withdrew your Stay",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            MaterialButton(
              child: const Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                finish(context);
              },
            ),
            MaterialButton(
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                MembershipService()
                    .updateStayStatus(data.id ?? "")
                    .then((value) => {
                          data.coupons?.forEach((element) {
                            UserCouponService().updateWithdrewCouponStatus(
                                element, 'active', 'active');
                            var lastIndex = data.coupons?.length ?? 0;
                            if (lastIndex >= 1) {
                              lastIndex = lastIndex - 1;
                            }
                            if (element == data.coupons![lastIndex]) {
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: "Stay is withdrawn successfully");
                              finish(context);
                            }
                          })
                        });
                fcmTokens.clear();
                var notificationData =
                    PushNotification().getFcmToken(data.brandId ?? "", data.partnerId??"");
                notificationData.then((value) => {
                  fcmTokens.add(value[0].fcmToken.toString()),
                PushNotification().sendNotification(
                "Booking Withdrew",
                "$userName has withdrew a stay of ${data.brandName}",
                data.id ?? "",
                fcmTokens,
                "stay")
                });

              },
            ),
          ],
        );
      },
    );
  }

  Widget stayStatus(String status) {
    if (status == "Expired") {
      return Text(
        status,
        style: secondaryTextStyle(color: Colors.red),
      );
    } else {
      return Text(
        status,
        style: secondaryTextStyle(color: Colors.orangeAccent),
      );
    }
  }
}