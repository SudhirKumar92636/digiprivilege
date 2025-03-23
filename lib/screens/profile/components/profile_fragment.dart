import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/FirebaseServices.dart';
import '../../../utils/data/data_storage.dart';
import '../../auth/phone/screens/PhoneAuthScreen.dart';
import '../../auth/phone/services/AuthService.dart';
import '../edit_profile_details.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _EditProfileState();
}

class _EditProfileState extends State<ProfileFragment> {
  var service = FirebaseServices();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String firstname = "name";
  String lastName = "title";
  String email = "email";
  String gender = "gender";
  bool isLoading = false;

  Future getUserDetails() async {
    AuthService().getUserDetails(FirebaseAuth.instance.currentUser?.uid ?? "");

    var fName = await AppData.getString(firstNameKey);
    var lName = await AppData.getString(lastNameKey);
    var gen = await AppData.getString(genderKey);
    var emailID = await AppData.getString(emailKey);

    setState(() {
      firstname = fName;
      lastName = lName;
      email = emailID;
      gender = gen;
    });
  }

  Future getDocId() async {
    var docId = await AppData.getString(docIdKey);
    print("docID $docId");
    var details =
        await FirebaseFirestore.instance.collection('users').doc(docId).get();
    setState(
      () {
        firstname = details.data()!['first_name'];
        lastName = details.data()!['last_name'];
        email = details.data()!['email'];
        gender = details.data()!['gender'];
        AppData.setString(firstNameKey, firstname);
        AppData.setString(lastNameKey, lastName);
        AppData.setString(genderKey, gender);
        AppData.setString(emailKey, email);

      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Log Out",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            "Are you sure Log out?",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            MaterialButton(
              child: const Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                finish(context);
              },
            ),
            isLoading
                ? Center(
                    child: Visibility(
                      visible: isLoading,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : InkWell(
                    child: MaterialButton(
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        await AppData.setBoolean(loginStatus, false);
                        setState(() {
                          isLoading = true;
                        });
                        AppData.setString(userIdKey, "");
                        AppData.setString(firstNameKey, "");
                        AppData.setString(lastNameKey, "");
                        AppData.setString(genderKey, "");
                        AppData.setString(emailKey, "");
                        AppData.setString(mobileKey, "");
                        AppData.setBoolean(loginStatus, false);
                        goToLogin();
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }

  goToLogin() {
    Navigator.pop(context);
    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PhoneAuthScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar with title text
      appBar: AppBar(
        backgroundColor: Colors.black,
        // in action widget we have PopupMenuButton
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                  value: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.message,
                              color: Colors.black,
                              size: 20,
                            ),
                            10.width,
                            TextButton(
                              onPressed: () {
                                whatsAppLink();
                              },
                              child: const Text(
                                "Chats",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.black,
                              size: 20,
                            ),
                            10.width,
                            TextButton(
                                onPressed: () {
                                  _showDialog(context);
                                },
                                child: const Text(
                                  "Log Out",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
            offset: Offset(0, 50),
            color: Colors.white,
            elevation: 1,
            onSelected: (value) {},
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.topRight,
          ).paddingRight(10),
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 60,
            child: CircleAvatar(
              radius: 110,
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg',
              ),
            ),
          ).paddingSymmetric(vertical: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        firstname,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        lastName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      String onRefresh = await Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (a, b, c) => EditProfile()));
                      if (onRefresh == "refreshed") {
                        getDocId();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      height: 5.h,
                      width: 200,
                      decoration: boxDecorationRoundedWithShadow(30,
                          backgroundColor: Colors.orange,
                          shadowColor: Colors.black),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: boldTextStyle(color: white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ).paddingSymmetric(horizontal: 30),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Notifications",
            style: boldTextStyle(color: white),
          ).paddingSymmetric(horizontal: 15),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Turn on Notifications",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: false,
                  onChanged: (bool value) {},
                ),
              ],
            ).paddingSymmetric(horizontal: 12),
          ).paddingSymmetric(horizontal: 15),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  whatsAppLink() async {
    var whatsapp = "+919873021061";
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=Hi I am " + firstname + " " + lastName + " and I have some query ";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("")}";
    if (Platform.isAndroid) {
      if (await canLaunch(whatsappURLIos)) {
        await launch(whatsappURlAndroid, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please install whatsapp")));
      }
    } else {
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please install whatsapp")));
      }
    }
  }
}
