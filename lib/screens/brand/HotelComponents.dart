
import 'package:flutter/material.dart';
import 'package:membership/models/brand/HotelModel.dart';
import 'package:membership/models/membership/MembershipDetailsModel.dart';
import 'package:membership/screens/membership/services/MembershipPaymentService.dart';
import 'package:membership/utils/Global/global.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/UserMembershipDetailsModel.dart';
import '../../utils/colors.dart';
import '../../utils/styles/textStyle.dart';
import '../membership/MembershipDetailsSceen.dart';
import 'SelectCouponScreen.dart';
import 'SelectHotel.dart';

membershipListItem(
    UserMembershipDetailsModel data, Color expireColor, BuildContext context) {
  return InkWell(
    onTap: () {
      if (data.isVerified == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectHotel(
                      membershipData: data,
                    )));
      } else {
        Fluttertoast.showToast(msg: "Please wait for admin approval");
      }
    },
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
                  data.images![0],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                )),
          ),
          Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "${data.title}, ${data.membershipNumber}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyle(color: white, size: 18),
                    ).paddingTop(4),
                  ),
                  2.height,
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.22,
                    child: Text(
                      data.description ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: secondaryTextStyle(
                          color: white, size: 10, weight: FontWeight.bold),
                    ).paddingTop(8),
                  ),
                  2.height,
                ],
              )
            ],
          ).paddingSymmetric(vertical: 5, horizontal: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$rupee ${data.price ?? "0"}",
                style: secondaryTextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    ),
  );
}

mainMembershipItem(
    MembershipDetailsModel data, Color expireColor, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MembershipDetailsScreen(
                    documentId: data.id ?? "",
                  )));
    },
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
                  data.images![0],
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                )),
          ),
          Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      data.brandName ?? "NA",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyle(color: white, size: 18),
                    ).paddingTop(4),
                  ),
                  2.height,
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.22,
                    child: Text(
                      data.desc ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: secondaryTextStyle(
                          color: white, size: 10, weight: FontWeight.bold),
                    ).paddingTop(8),
                  ),
                  2.height,
                ],
              )
            ],
          ).paddingSymmetric(vertical: 5, horizontal: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$rupee ${data.price ?? "0"}",
                style: secondaryTextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    ),
  );
}

calenderSheet(BuildContext context, HotelModal data,
    UserMembershipDetailsModel membershipData1) {
  selectedStartDate = "";
  selectedEndDate = "";
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (builder) {
        return Container(
          height: 350.0,
          color: Colors.transparent,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Icon(
                    Icons.close_rounded,
                    color: black,
                  ).paddingTop(15),
                  onTap: () {
                    finish(context);
                  },
                ),
              ),
              Text(
                "Please select the Date",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Check-in").paddingTop(25),
              // DateTimePicker(
              //   enableInteractiveSelection: false,
              //   type: DateTimePickerType.date,
              //   dateMask: 'd MMM yyyy',
              //   initialValue: DateTime.now().toString(),
              //   firstDate: DateTime.now(),
              //   style: const TextStyle(color: Colors.white),
              //   lastDate: DateTime.now().add(const Duration(days: 365)),
              //   onChanged: (val) {
              //     selectedStartDate = val;
              //   },
              // ).paddingTop(10),
              // Text("Check-out").paddingTop(25),
              // DateTimePicker(
              //   enableInteractiveSelection: false,
              //   type: DateTimePickerType.date,
              //   dateMask: 'd MMM yyyy',
              //   initialValue: DateTime.now().toString(),
              //   firstDate: DateTime.now(),
              //   style: const TextStyle(color: Colors.white),
              //   lastDate: DateTime.now().add(const Duration(days: 365)),
              //   onChanged: (val) {
              //     selectedEndDate = val;
              //   },
              // ).paddingTop(10),
              MaterialButton(
                height: 45.0,
                minWidth: 70.0,
                color: Colors.orange,
                textColor: Colors.white,
                child: const Text("Select Coupons"),
                onPressed: () => {
                  if (selectedEndDate != "" && selectedStartDate != "")
                    {
                      isComplementary = false,
                      if (selectedStartDate != selectedEndDate)
                        {
                          if (daysBetween(DateTime.parse(selectedStartDate),
                                  DateTime.parse(selectedEndDate)) >
                              0)
                            {
                              MembershipPaymentService()
                                  .checkBookedStay(selectedStartDate,
                                      membershipData1.userId ?? "")
                                  .then((value) {
                                if (value.docs.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "You can't book a stay next seven days");
                                } else {
                                  finish(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectCouponScreen(
                                                  hotelModel: data,
                                                  membershipDetailsModel:
                                                      membershipData1)));
                                }
                              })
                            }
                          else {
                              Fluttertoast.showToast(msg: "Check out Date should be greater")
                            }
                        }
                      else {
                          Fluttertoast.showToast(
                              msg: "Check in and check out time should not be same")
                        }
                    }
                  else
                    {
                      Fluttertoast.showToast(
                          msg: "Please select check in and check out date")
                    }
                },
                splashColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.5)),
              ).paddingTop(35)
            ],
          ).paddingRight(15).paddingLeft(15),
        );
      });
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}