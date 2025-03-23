import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:membership/global/globalConst.dart';
import 'package:membership/models/PartnerFcmToken.dart';

class PushNotification {
  // final baseUrl = "https://us-central1-urlifemebership.cloudfunctions.net/app/";
  final baseUrl = "https://asia-south1-urlife-6b1cc.cloudfunctions.net/app/";
  final httpClient = HttpClient();
  sendNotification(String title, String body, String id, List<String> to,
      String type) async {
    var notificationData = {
      "registration_ids": [to[0]],
      "notification": {
        "body": body,
        "title": title,
        "android_channel_id": "partnerpro",
        "sound": true
      },
      "data": {"_id": id, "_type": type}
    };

    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.headers.set("Content-Type", "application/json; charset=UTF-8");
    request.headers.set("Authorization", fcmServerKey);
    request.add(utf8.encode(json.encode(notificationData)));
    final response = await request.close();
    print(response.statusCode);
  }

  Future<List<PartnerFcmToken>> getFcmToken(
      String brandId, String partnerId) async {
    var data = await FirebaseFirestore.instance
        .collection('brand')
        .doc(brandId)
        .collection("notification")
        .where("partner_id", isEqualTo: partnerId)
        .get();
    if (data.docs.isNotEmpty) {
      return data.docs.map((e) => PartnerFcmToken.fromJson(e.data())).toList();
    } else {
      return List<PartnerFcmToken>.empty();
    }
  }
}
