import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../models/brand/HotelModel.dart';
import '../../models/membership/UserCouponDetailsModel.dart';
import '../../utils/Global/global.dart';
import '../../utils/colors.dart';
import '../user_membership/components/UserCouponComponent.dart';

class SelectedCouponsItem extends StatefulWidget {
  final Key key;
  final UserCouponDetailsModel item;
  final ValueChanged<bool> isSelected;
  final HotelModal hotelModel;

  SelectedCouponsItem(
      {required this.item, required this.isSelected, required this.hotelModel, required this.key});

  @override
  _SelectedCouponsItemState createState() => _SelectedCouponsItemState();
}

class _SelectedCouponsItemState extends State<SelectedCouponsItem> {
  bool isSelected = false;
  bool isCard = false;

  @override
  Widget build(BuildContext context) {
    var brandName = "";
    if (widget.hotelModel.name !="" && widget.item.membershipNumber !="" && widget.hotelModel.name != null) {
      brandName = "${widget.hotelModel.name}, ${widget.item.membershipNumber}";
    }  else if (widget.hotelModel.name != null && widget.hotelModel.name !="") {
      brandName = "${widget.hotelModel.name}";
    } else {
      brandName = "${widget.item.membershipNumber}";
    }
    if (widget.item.couponType == "card") {
      isCard = true;
    } else {
      isCard = false;
    }

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected == true) {
            if (widget.item.type == "complimentary room") {
              if (isComplementary == true) {
                isSelected = false;
                isComplementary = false;
              }
            } else {
              isSelected = false;
            }
          } else {
            if (widget.item.type == "complimentary room") {
              if (isComplementary == false) {
                isSelected = true;
                isComplementary = true;
              }
            } else {
              isSelected = true;
            }
          }
        });
        widget.isSelected(isSelected);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: boxDecorationRoundedWithShadow(
          8,
          shadowColor: isSelected ? appThemeColor : grey,
          backgroundColor: const Color(0xff363837),
          blurRadius: 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  showCouponStatus(widget.item.currentStatus ?? "used",
                      widget.item.couponType ?? "")
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                widget.item.couponType ?? "",
                style: boldTextStyle(color: white, size: 14),
              ),
            ),
            5.height,
            ListTile(
              leading: SizedBox(
                width: 75.w,
                child: Text(
                  widget.item.description ?? "NA",
                  style: boldTextStyle(color: white, size: 18),
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green[700],
                    )
                  : const Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey,
                    ),
              onTap: () {
                setState(() {
                  if (isSelected == true) {
                    if (widget.item.type == "complimentary room") {
                      if (isComplementary == true) {
                        isSelected = false;
                        isComplementary = false;
                      }
                    } else {
                      isSelected = false;
                    }
                  } else {
                    if (widget.item.type == "complimentary room") {
                      if (isComplementary == false) {
                        isSelected = true;
                        isComplementary = true;
                      }
                    } else {
                      isSelected = true;
                    }
                  }
                });
                widget.isSelected(isSelected);
              },
            ),
            20.height,
            Text(
              brandName,
              style: secondaryTextStyle(color: orange, size: 12),
            ),
            Text(
              "Voucher - ${widget.item.couponId}",
              style: secondaryTextStyle(color: white, size: 12),
            ),
            20.height,
            Visibility(
                visible: isCard,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: numberOfRoomsController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    hintText: "Enter number of rooms / day",
                  ),
                ))
          ],
        ),
      ),
    ).paddingRight(8.0).paddingLeft(8.0);
  }
}