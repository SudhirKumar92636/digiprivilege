import 'package:cloud_firestore/cloud_firestore.dart';

class UserSelectedCouponDetailsModel {
  UserSelectedCouponDetailsModel(
      this.id,
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
      this.price,
      this.brand_id);

  String? id;
  String? couponId;
  String? title;
  String? booking_date;
  String? booking_time;
  String? brand_name;
  String? description;
  String? membershipId;
  String? partnerId;
  Timestamp? expireOn;
  Timestamp? booking_dateTime;
  String? couponStatus;
  Timestamp? createdAt;
  String? currentStatus;
  String? couponImage;
  String? couponType;
  String? brand_id;
  bool? isBooking;
  int price;
  bool? isSelected = false;
}