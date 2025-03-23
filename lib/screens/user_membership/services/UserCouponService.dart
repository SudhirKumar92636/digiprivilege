import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:membership/utils/Global/global.dart';

import '../../../models/membership/UserCouponDetailsModel.dart';

class UserCouponService {
  var db = FirebaseFirestore.instance;

  Stream<List<UserCouponDetailsModel>> getAllCoupons(
      String docId, String userId) {
    var data = db
        .collection("user_coupons")
        .where('membership_id', isEqualTo: docId)
        .where('user_id', isEqualTo: userId)
        .snapshots();
    return data.map((event) => event.docs
        .map((e) => UserCouponDetailsModel.fromJson(e.data()))
        .toList());
  }

  Stream<List<UserCouponDetailsModel>> getFoodVoucher(
      String docId, String userId) {
    var data = db
        .collection("user_coupons")
        .where('membership_id', isEqualTo: docId)
        .where('user_id', isEqualTo: userId)
        .where('coupon_type', isEqualTo: "food")
        .snapshots();
    return data.map((event) => event.docs
        .map((e) => UserCouponDetailsModel.fromJson(e.data()))
        .toList());
  }

  Stream<List<UserCouponDetailsModel>> getRoomVoucher(
      String docId, String userId) {
    var data = db
        .collection("user_coupons")
        .where('membership_id', isEqualTo: docId)
        .where('user_id', isEqualTo: userId)
        .where('coupon_type', isEqualTo: "stay")
        .snapshots();
    return data.map((event) => event.docs
        .map((e) => UserCouponDetailsModel.fromJson(e.data()))
        .toList());
  }

  Stream<List<UserCouponDetailsModel>> getSelectCouponsData(
      String brandId, String userId, String status, String membershipId) {
    var data = db
        .collection("user_coupons")
        // .where('brand_id', isEqualTo: brandId)
        .where('membership_id', isEqualTo: membershipId)
        .where('user_id', isEqualTo: userId)
        .where('current_status', isEqualTo: status)
        .where('coupon_type', isEqualTo: "stay")
        .snapshots();
    return data.map((event) => event.docs
        .map((e) => UserCouponDetailsModel.fromJson(e.data()))
        .toList());
  }

  Stream<List<UserCouponDetailsModel>> getPrivilegeCouponsData(
      String brandId, String userId, String status, String membershipId) {
    var data = db
        .collection("user_coupons")
        .where('brand_id', isEqualTo: brandId)
        .where('membership_id', isEqualTo: membershipId)
        .where('user_id', isEqualTo: userId)
        .where('coupon_type', isEqualTo: "card")
        .snapshots();
    return data.map((event) => event.docs
        .map((e) => UserCouponDetailsModel.fromJson(e.data()))
        .toList());
  }

  Future<List<UserCouponDetailsModel>> getPrivilegeCard(
      String brandId, String userId, String status, String membershipId) async {
    var data = await db
        .collection("user_coupons")
        // .where('brand_id', isEqualTo: brandId)
        .where('membership_id', isEqualTo: membershipId)
        .where('user_id', isEqualTo: userId)
        .where('coupon_type', isEqualTo: "card")
        .get();

    if (data.docs.isNotEmpty) {
      return data.docs
          .map((e) => UserCouponDetailsModel.fromJson(e.data()))
          .toList();
    } else {
      return List<UserCouponDetailsModel>.empty();
    }
  }

  Stream<UserCouponDetailsModel> getCouponsDetails(String couponId) {
    var data = db.collection("user_coupons").doc(couponId).snapshots();
    return data.map((event) => UserCouponDetailsModel.fromJson(event.data()!));
  }

  Future<void> updateWithdrewCouponStatus(
      String couponId, String status, String currentStatus) async {
    var db = FirebaseFirestore.instance.collection("user_coupons");
    await db.doc(couponId).update({
      "current_status": status,
      "coupon_status": currentStatus,
      "partner_id" : "",
      "is_stay": false
    });
  }

  Future<void> updateCouponStatus(String couponId, String status, String partnerId, String brandName, String brandId) async {
    var db = FirebaseFirestore.instance.collection("user_coupons");
    if (status == "is_stay") {
      await db
          .doc(couponId)
          .update({"current_status": "requested","partner_id" : partnerId , "brand_name": brandName, "brand_id" : brandId, "is_stay": true});
    } else {
      await db
          .doc(couponId)
          .update({"current_status": status,"partner_id" : partnerId, "brand_name": brandName,"brand_id" : brandId,"is_stay": false});
    }
  }

  Future<void> updateFoodCouponStatus(String couponId, String status, String partnerId , String brandName) async {
    var db = FirebaseFirestore.instance.collection("user_coupons");
    await db.doc(couponId).update({
      "current_status": status,
      "is_stay": false,
      "partner_id" : partnerId ,
      "brand_name": brandName,
      "booking_date": todayDate,
      "booking_dateTime": currentDate
    });
  }
}