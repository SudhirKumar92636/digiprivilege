import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FirebaseServices {
  var auth = FirebaseAuth.instance.currentUser;
  var storeInstance = FirebaseFirestore.instance;
  var logger = Logger();

  Future<void> addNewUser(Map<String, dynamic> data, String id) {
    var collection = storeInstance.collection('users');
    return collection
        .doc(id)
        .set(data)
        .then((value) => Logger().i("New Data Added"))
        .onError((error, stackTrace) => Logger().i(error, error: id ));
  }

  Future<void> updateDetails(Map<String, dynamic> data, String userId) {
    var collection = storeInstance.collection('users');
    return collection
        .doc(userId)
        .update(data)
        .then((value) => Logger().i("New Data Added"))
        .onError((error, stackTrace) => Logger().i(error));
  }

  Future<void> addOrder(Map<String, dynamic> data) {
    var collection = storeInstance.collection('orders');
    return collection.add(data).then((value) => (value.id));
  }

  Future<DocumentReference<Map<String, dynamic>>> addPaymentDetails(
      Map<String, dynamic> data) {
    var collection = storeInstance.collection('user_payments');
    return collection.add(data);
  }
}
