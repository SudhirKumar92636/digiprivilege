import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:membership/models/brand/BrandDetailsModel.dart';
import 'package:membership/models/membership/CouponDetailsModel.dart';
import 'package:membership/models/user/StayModel.dart';

import '../../../models/brand/HotelModel.dart';
import '../../../models/membership/MembershipDetailsModel.dart';

class MembershipService {
  var db = FirebaseFirestore.instance;
  var logger = Logger();

  Stream<MembershipDetailsModel> getMembershipDetails(String membershipId) =>
      db.collection('membership').doc(membershipId).snapshots().map((event) {
        return MembershipDetailsModel.fromJson(event.data() ?? {});
      });

  Future<MembershipDetailsModel> getDetailsOfMembership(
      String membership) async {
    var collection = db.collection('membership');
    var snap = await collection.doc(membership).get();
    if (snap.exists) {
      var mData = snap.data();
      return MembershipDetailsModel.fromJson(mData!);
    }
    return MembershipDetailsModel();
  }

  Future<List<CouponDetailsModel>> getAllCouponsByMembership(
      String membershipId, String usedId) async {
    var collection = db.collection('coupons');
    var docSnapshot =
        await collection.where('membership_id', isEqualTo: membershipId).get();
    if (docSnapshot.docs.isNotEmpty) {
      return docSnapshot.docs
          .map((e) => CouponDetailsModel.fromJson(e.data()))
          .toList();
    } else {
      return List<CouponDetailsModel>.empty();
    }
  }

  Future<List<CouponDetailsModel>> getAllCouponsByMembershipAndId(
      String membershipId, String usedId) async {
    logger.d("" + membershipId);
    var collection = db.collection('user_coupons');
    var docSnapshot = await collection
        .where('membership_id', isEqualTo: membershipId)
        .where('user_id', isEqualTo: usedId)
        .get();
    if (docSnapshot.docs.isNotEmpty) {
      return docSnapshot.docs
          .map((e) => CouponDetailsModel.fromJson(e.data()))
          .toList();
    } else {
      return List<CouponDetailsModel>.empty();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> checkOfferStatus(
      String membershipId) async {
    var request = db
        .collection('user_memberships')
        .where('membership_id', isEqualTo: membershipId)
        .where('payment_status', isEqualTo: "success")
        .get();
    return await request;
  }

  Stream<BrandDetailsModel> getBrandDetails(String brandId) => db
      .collection('brand')
      .doc(brandId)
      .snapshots()
      .map((event) => BrandDetailsModel.fromJson(event.data()!));

  Stream<List<HotelModal>> getAllHotels(String userId, String membershipId) {
    var db = FirebaseFirestore.instance.collection('user_memberships');
    var condition = db.doc(membershipId).collection("brands").snapshots();

    var data = condition.map((snapshot) =>
        snapshot.docs.map((e) => HotelModal.fromJson(e.data())).toList());
    return data;
  }

  Stream<List<StayModel>> getAllStays(
    String userId,
  ) {
    var db = FirebaseFirestore.instance
        .collection('user_stays')
        .where('user_id', isEqualTo: userId);
    var condition = db.snapshots();

    var data = condition.map((snapshot) =>
        snapshot.docs.map((e) => StayModel.fromJson(e.data())).toList());
    return data;
  }

  Future<void> updateStayStatus(String stayId) async {
    var db = FirebaseFirestore.instance.collection("user_stays");
    await db.doc(stayId).update(
        {"status": "withdrew", "between_days": [], "next_seven_days": []});
  }

  Future<void> updateExpireStayStatus(String stayId) async {
    var db = FirebaseFirestore.instance.collection("user_stays");
    await db.doc(stayId).update({"status": "Expired"});
  }

  Future<void> updateConformmStayStatus(String stayId) async {
    var db = FirebaseFirestore.instance.collection("user_stays");
    await db.doc(stayId).update(
        {"status": "Expired", "between_days": [], "next_seven_days": []});
  }

  Future<List<HotelModal>> getAllHotel(
      String userId, String membershipId) async {
    var mainCollection = db.collection('membership');
    var condition =
        await mainCollection.doc(membershipId).collection("brands").get();

    if (condition.docs.isNotEmpty) {
      return condition.docs.map((e) => HotelModal.fromJson(e.data())).toList();
    } else {
      return List<HotelModal>.empty();
    }
  }
}