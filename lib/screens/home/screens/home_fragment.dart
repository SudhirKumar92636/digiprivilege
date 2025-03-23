import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:membership/models/UserMembershipDetailsModel.dart';
import 'package:membership/models/user/UserDetailsModel.dart';
import 'package:membership/screens/book_stay/stays.dart';
import 'package:membership/screens/brand/MembershipList.dart';
import 'package:membership/screens/membership/services/MembershipPaymentService.dart';
import 'package:membership/utils/Global/global.dart';
import 'package:membership/utils/styles/ImageView.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/HomeDataModel.dart';
import '../../../notificationservice/local_notification_service.dart';
import '../../../utils/data/data_storage.dart';
import '../comconents/home_components.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _Page1State();
}

class _Page1State extends State<HomeFragment> {
  var store = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String first_name = "There";
  String userID = "";

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    getUserData();
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Stays()),
            );
          }
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          //LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    getAgentId();
    getDeviceTokenToSendNotification();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var userDoc = await AppData.getString(docIdKey);
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    var fcmToken = token.toString();
    MembershipPaymentService().updateFcmTokenStatus(userDoc, fcmToken);
    print("Token Value $fcmToken");
  }

  getUserData() async {
    await AppData.getString(firstNameKey).then((value) {
      setState(() {
        first_name = value;
      });
    });
    await AppData.getString(userIdKey).then((value) {
      setState(() {
        userID = value;
      });
    });

    getAgentId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<HomeDataModel>>(
          stream: getAllHomeData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<HomeDataModel> data = snapshot.data;

              return ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  10.height,
                  Text(
                    "Hello, $first_name",
                    style: boldTextStyle(color: Colors.white, size: 24),
                  ).paddingLeft(10),
                  SizedBox(
                    height: 60,
                    child: membershipNumbersListView(context),
                  ),
                  imageWithIndicators(context, data[2].items!, 16 / 9)
                      .paddingSymmetric(horizontal: 10),
                  10.height,
                  Text(data[1].group_name ?? "Not Found",
                          style: boldTextStyle(color: Colors.white, size: 16))
                      .paddingSymmetric(horizontal: 7),
                  10.height,
                  groceryCategoriesList(data[1].items!, context, data[1]),
                  20.height,
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MembershipList()));
                      },
                      child: Container(
                        height: 45.0,
                        child: const Center(
                            child: Text(
                          "Book a stay",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.5),
                            color: orange),
                      )).paddingRight(15),
                  20.height,
                  Text(data[0].group_name ?? "Not Found",
                          style: boldTextStyle(color: Colors.white, size: 16))
                      .paddingSymmetric(horizontal: 7),
                  10.height,
                  trendsListView(data[0].items!, context),
                  // 20.height,
                  // Text(data[3].group_name ?? "Not Found",
                  //         style: boldTextStyle(color: Colors.white, size: 16))
                  //     .paddingSymmetric(horizontal: 7),
                  // 10.height,
                  // imageWithIndicators(context, data[3].items!, 16 / 9)
                  //     .paddingSymmetric(horizontal: 10),
                  20.height,
                  Center(
                    child: Text(
                      "That's all flocks",
                      style: boldTextStyle(color: Colors.white, size: 16),
                    ),
                  ),
                  10.height
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Stream<List<HomeDataModel>> getAllHomeData() => FirebaseFirestore.instance
      .collection('homes')
      .orderBy('group_id', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((e) => HomeDataModel.fromJson(e.data())).toList());

  Future getAgentId() async {
    if (agentId == "" && userID != "") {
      var details = await FirebaseFirestore.instance
          .collection('users')
          .where("user_id", isEqualTo: userID)
          .get();
      if (details.docs.isNotEmpty) {
        for (var element in details.docs) {
          setState(() {
            var userModel = UserDetailsModel.fromJson(element.data());
            agentId = userModel.agentId ?? "";
            var doc = element.reference.id;
            AppData.setString(docIdKey, doc);
          });
        }
      }
    }
  }

  membershipNumbersListView(BuildContext context) {
    return FutureBuilder(
      future: getMembershipNumbers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<UserMembershipDetailsModel> memNumbersList =
              <UserMembershipDetailsModel>[];
          List<UserMembershipDetailsModel> memNumbers = snapshot.data;
          for (var element in memNumbers) {
            if (element.membershipNumber != "") {
              memNumbersList.add(element);
            }
          }
          print(memNumbers);
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemBuilder: (context, index) {
              return memNumbersList[index].membershipNumber != null
                  ? memNumbersList.length > 1
                      ? Text(
                          "${memNumbersList[index].membershipNumber},",
                          style: const TextStyle(color: Colors.white, fontSize: 26),
                        )
                      : Text(
                          "${memNumbersList[index].membershipNumber}",
                          style: const TextStyle(color: Colors.white, fontSize: 26),
                        )
                  : const Text("");
            },
            itemCount: memNumbersList.length,
            separatorBuilder: (BuildContext context, int index) {
              return 10.height;
            },
          );
        } else {
          return const Text("No data");
        }
      },
    );
  }

  Future<List<UserMembershipDetailsModel>> getMembershipNumbers() async {
    var userMem = await FirebaseFirestore.instance
        .collection('user_memberships')
        .where("user_id", isEqualTo: userID)
        .get();
    return userMem.docs
        .map((e) => UserMembershipDetailsModel.fromJson(e.data()))
        .toList();
  }
}
