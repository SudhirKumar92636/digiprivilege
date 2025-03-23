import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserCouponDetailsModel couponDetailsModelFromJson(String str) =>
    UserCouponDetailsModel.fromJson(json.decode(str));

Map<String, dynamic> couponDetailsModelToJson(UserCouponDetailsModel data) =>
    data.toJson();

class UserCouponDetailsModel {
  UserCouponDetailsModel(
      {this.id,
      this.couponId,
      this.title,
      this.brand_name,
      this.description,
      this.membershipId,
      this.partnerId,
      this.expireOn,
      this.couponStatus,
      this.createdAt,
      this.currentStatus,
      this.couponType,
      this.couponImage,
      this.isBooking,
      this.booking_date,
      this.booking_time,
      this.booking_dateTime,
      this.isSelected,
      this.type,
      this.price,
      this.brand_id,
      this.rejection_reason,
      this.is_stay,
      this.user_name,
      this.membershipNumber});

  String? id;
  String? couponId;
  String? title;
  String? booking_date;
  String? booking_time;
  String? brand_name;
  String? user_name;
  String? description;
  String? membershipId;
  String? brand_id;
  String? partnerId;
  Timestamp? expireOn;
  Timestamp? booking_dateTime;
  String? couponStatus;
  Timestamp? createdAt;
  String? currentStatus;
  String? couponImage;
  String? couponType;
  bool? isBooking;
  String? type;
  int? price;
  String? rejection_reason;
  String? membershipNumber;
  bool? isSelected = true;
  bool? is_stay = true;

  factory UserCouponDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserCouponDetailsModel(
          id: json["id"],
          couponId: json["coupon_id"],
          title: json["title"],
          brand_name: json["brand_name"],
          user_name: json["user_name"],
          description: json["description"],
          membershipId: json["membership_id"],
          partnerId: json["partner_id"],
          expireOn: json["expire_on"],
          couponStatus: json["coupon_status"],
          createdAt: json["created_at"],
          currentStatus: json['current_status'],
          couponImage: json["coupon_image"],
          couponType: json["coupon_type"],
          isBooking: json["is_booking"],
          booking_time: json["booking_time"],
          booking_date: json["booking_date"],
          booking_dateTime: json["booking_dateTime"],
          price: json["price"],
          type: json["type"],
          brand_id: json["brand_id"],
          isSelected: false,
          rejection_reason: json["rejection_reason"],
          is_stay: json["is_stay"],
          membershipNumber: json["membership_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coupon_id": couponId,
        "title": title,
        "brand_name": brand_name,
        "user_name": user_name,
        "description": description,
        "membership_id": membershipId,
        "partner_id": partnerId,
        "expire_on": expireOn,
        "coupon_status": couponStatus,
        "created_at": createdAt,
        "current_status": currentStatus,
        "coupon_image": couponImage,
        "coupon_type": couponType,
        "is_booking": isBooking,
        "booking_date": booking_date,
        "booking_time": booking_time,
        "booking_dateTime": booking_dateTime,
        "type": type,
        "price": price,
        "brand_id": brand_id,
        "rejection_reason": rejection_reason,
        "is_stay": is_stay,
        "membership_number": membershipNumber,
      };
}
