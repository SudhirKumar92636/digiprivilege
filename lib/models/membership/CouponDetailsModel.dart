import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CouponDetailsModel couponDetailsModelFromJson(String str) =>
    CouponDetailsModel.fromJson(json.decode(str));

Map<String, dynamic> couponDetailsModelToJson(CouponDetailsModel data) =>
    data.toJson();

class CouponDetailsModel {
  CouponDetailsModel(
      {this.id,
      this.couponId,
      this.title,
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
      this.brandName,
      this.brandLogo,
      this.termOfUse,
      this.colorCode,
      this.number_of_coupons,
      this.number_of_people,
      this.type,
      this.price,
      this.brand_id,
      this.rejection_reason,
      this.bookingDate});

  String? id;
  String? couponId;
  String? title;
  String? description;
  String? membershipId;
  String? partnerId;
  Timestamp? expireOn;
  String? couponStatus;
  Timestamp? createdAt;
  String? currentStatus;
  String? couponType;
  bool? isBooking;
  String? couponImage;
  String? brandName;
  String? brandLogo;
  String? termOfUse;
  String? colorCode;
  String? type;
  int? number_of_coupons;
  int? number_of_people;
  int? price;
  String? brand_id;
  String? rejection_reason;
  String? bookingDate;

  factory CouponDetailsModel.fromJson(Map<String, dynamic> json) =>
      CouponDetailsModel(
          id: json["id"],
          couponId: json["coupon_id"],
          title: json["title"],
          description: json["description"],
          membershipId: json["membership_id"],
          partnerId: json["partner_id"],
          expireOn: json["expire_on"],
          couponStatus: json["coupon_status"],
          createdAt: json["created_at"],
          currentStatus: json['current_status'],
          couponType: json["coupon_type"],
          isBooking: json["is_booking"],
          couponImage: json['coupon_image'],
          brandName: json['brand_name'],
          brandLogo: json['brand_logo'],
          termOfUse: json['tearms_of_use'],
          colorCode: json['color'],
          number_of_coupons: json['number_of_coupons'],
          number_of_people: json['number_of_people'],
          price: json['price'],
          type: json['type'],
          brand_id: json['brand_id'],
          rejection_reason: json['rejection_reason'],
          bookingDate: json['booking_date']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "coupon_id": couponId,
        "title": title,
        "description": description,
        "membership_id": membershipId,
        "partner_id": partnerId,
        "expire_on": expireOn,
        "coupon_status": couponStatus,
        "created_at": createdAt,
        "current_status": currentStatus,
        "coupon_type": couponType,
        "is_booking": isBooking,
        "coupon_image": couponImage,
        "brand_name": brandName,
        "brand_logo": brandLogo,
        "tearms_of_use": termOfUse,
        "color": colorCode,
        "number_of_people": number_of_people,
        "number_of_coupons": number_of_coupons,
        "price": price,
        "type": type,
        "brand_id": brand_id,
        "rejection_reason": rejection_reason,
        "booking_date": bookingDate,
      };
}