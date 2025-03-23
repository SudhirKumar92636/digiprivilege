import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:membership/models/membership/MembershipDetailsModel.dart';
import 'package:membership/models/membership/UserCouponDetailsModel.dart';

import '../../../models/UserMembershipDetailsModel.dart';

class UserMembershipService {
  var db = FirebaseFirestore.instance;

  Stream<List<UserMembershipDetailsModel>> getAllUserMembership(
      String userId, String status) {
    var db = FirebaseFirestore.instance.collection('user_memberships');
    var condition = db
        .where('user_id', isEqualTo: userId)
        .where('membership_status', isEqualTo: status)
        .snapshots();
    var data = condition.map((snapshot) => snapshot.docs
        .map((e) => UserMembershipDetailsModel.fromJson(e.data()))
        .toList());
    return data;
  }

  Future<List<UserMembershipDetailsModel>?> getAllUserMembershipByNumber (
      String phone) async {
    var db = FirebaseFirestore.instance.collection('user_memberships');
    var condition = await db
        .where('number', isEqualTo: phone)
        .get();
    return condition.docs.map((e) => UserMembershipDetailsModel.fromJson(e.data())).toList();
  }

  Future<void> updateUidOfMembership (
      String userId, String doc) async {
    var db = FirebaseFirestore.instance.collection('user_memberships');
    await db.doc(doc).update({'user_id' : userId});
  }

  // get all coupons which is created by agent first time because user doc id is different from auth id so we need to change it
  Future<List<UserCouponDetailsModel>?> getAllUserMembershipCoupons (
      String memId, String phone) async {
    var db = FirebaseFirestore.instance.collection('user_coupons');
    var condition = await db
        .where('number', isEqualTo: phone)
        .where('membership_id', isEqualTo: memId)
        .get();
    return condition.docs.map((e) => UserCouponDetailsModel.fromJson(e.data())).toList();
  }
  Future<void> updateUidOfMembershipCoupon (
      String userId, String doc) async {
    var db = FirebaseFirestore.instance.collection('user_coupons');
    await db.doc(doc).update({'user_id' : userId});
  }

  Stream<List<MembershipDetailsModel>> getAllMembership(
      String userId, String status) {
    var db = FirebaseFirestore.instance.collection('membership');
    var condition = db.snapshots();
    var data = condition.map((snapshot) => snapshot.docs
        .map((e) => MembershipDetailsModel.fromJson(e.data()))
        .toList());
    return data;
  }
}