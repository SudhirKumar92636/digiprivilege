import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../models/user/UserDetailsModel.dart';
import '../../../../utils/data/data_storage.dart';

class AuthService {
  var storeInstance = FirebaseFirestore.instance;
  var logger = Logger();

  Future<QuerySnapshot<Map<String, dynamic>>> checkUser(
      BuildContext context, String mobile, String type) async {
    var collection = storeInstance.collection("users");
    return await collection
        .where('number', isEqualTo: mobile)
        .where('user_type.$type', isEqualTo: true)
        .get();
  }

  Future<void> updateUserDocOfAgent(
      BuildContext context, String userId, String docId) async {
    var collection = storeInstance.collection("users");
    return await collection.doc(docId).update({"user_id": userId});
  }

  Future<void> getUserDetails(String userId) async {
    var collection = storeInstance.collection('users');
    var docSnapshot = await collection
        .where("user_id", isEqualTo: userId)
        .get();
    if (docSnapshot.docs.isNotEmpty) {
      var userList = docSnapshot.docs
          .map((e) => UserDetailsModel.fromJson(e.data()))
          .toList();
      logger.i(userList[0]);
      AppData.setString(userIdKey, userList[0].userId ?? "");
      AppData.setString(firstNameKey, userList[0].firstName ?? "");
      AppData.setString(lastNameKey, userList[0].lastName ?? "");
      AppData.setString(genderKey, userList[0].gender ?? "Male");
      AppData.setString(emailKey, userList[0].email ?? "");
      AppData.setString(mobileKey, userList[0].number ?? "");
    }
  }

  Future<void> addUserDetails(UserDetailsModel data, String userId) async {
    var jsonData = userDetailsModelToJson(data);
    await storeInstance.collection("users").doc(userId).set(jsonData);
  }

  List<String> generateSearchArray(List<String> arrayText) {
    var fullArray = <String>[];
    for (var j = 0; j < arrayText.length; j++) {
      var singleValue = arrayText[j];
      for (var i = 1; i <= singleValue.length; i++) {
        var array = singleValue.substring(0, i);

        fullArray.add(array);
      }
    }
    return fullArray;
  }
}