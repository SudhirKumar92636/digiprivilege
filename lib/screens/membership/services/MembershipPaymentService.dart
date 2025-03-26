import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:membership/models/UserMembershipDetailsModel.dart';
import 'package:membership/models/brand/HotelModel.dart';
import 'package:membership/models/membership/MembershipPaymentModel.dart';

class MembershipPaymentService {
  var storeInstance = FirebaseFirestore.instance;
  var logger = Logger();

  Future<void> addPaymentDetails(
      String docId, MembershipPaymentModel data) async {
    var jsonData = membershipPaymentModelToJson(data);
    return await storeInstance
        .collection('user_payments')
        .doc(docId)
        .set(jsonData);
  }

  Future<void> addUserMembershipData(
      UserMembershipDetailsModel data, String docId) async {
    var jsonData = userMembershipDetailsModelToJson(data);

    print("chek jsjsjs ::: ${jsonData}");
    try{
      return await storeInstance
          .collection('razorpay_memberships')
          .doc(docId)
          .set(jsonData);
    }catch(e){
      print("some thing went wrong ::: $e");
    }
  }

  Future<void> addUserMembershipBrandData(
      HotelModal data, String docId, String brandDoc) async {
    var jsonData = hotelModelToJson(data);

     try{
       return await storeInstance
           .collection('razorpay_memberships')
           .doc(docId.toString())
           .collection("brands")
           .doc(brandDoc.toString())
           .set(jsonData);
     }catch(e){
       print("some things went wrong :: $e");
     }
  }

  Future<void> updateFcmTokenStatus(String userId, String token) async {
    await storeInstance
        .collection('users')
        .doc(userId)
        .update({"fcm_token": token});
  }

  Future<void> addCouponsDetails(
      String docId, Map<String, dynamic> data) async {
    return await storeInstance.collection('user_coupons').doc(docId).set(data);
  }

  Future<void> addBookStay(String docId, Map<String, dynamic> data) async {
    try{
      return await storeInstance.collection('user_stays').doc(docId).set(data);

    }catch(e){
      print(e);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> checkBookedStay(
      String checkInDate, String userId) async {
    return await storeInstance
        .collection('user_stays')
        .where("user_id", isEqualTo: userId)
        .where("next_seven_days", arrayContains: checkInDate)
        // .where("status", isEqualTo: "conformed")
        .get();
  }
}