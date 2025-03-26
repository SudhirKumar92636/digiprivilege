import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership/models/user/UserDetailsModel.dart';
import 'package:membership/screens/auth/phone/services/AuthService.dart';
import 'package:membership/utils/decorations/appTextFiled.dart';
import 'package:membership/utils/styles/buttonStyle.dart';
import 'package:membership/utils/styles/textStyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../services/FirebaseServices.dart';
import '../../services/PushNofitication.dart';
import '../../utils/data/data_storage.dart';
import '../../utils/functions/randomValues.dart';
import '../landing_page.dart';

class UserDetailsScreen extends StatefulWidget {
  final String mobile;

  const UserDetailsScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var auth = FirebaseAuth.instance.currentUser;
  final formkey = GlobalKey<FormState>();
  var service = FirebaseServices();
  bool isLoading = false;
  String dropdownValue = "Male";
  List<String> spinnerItems = [
    'Male',
    'Female',
    'Other',
  ];
  final _firstnameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _otherReferralCode = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var auth = FirebaseAuth.instance.currentUser;
    _emailController.text = auth?.email??"";
    if(auth !=null){
      var name = auth.displayName?.split(" ");
      if(name !=null && name.length > 1){
        _firstnameController.text = name[0];
        _lastNameController.text = name[1];
      }else{
        _firstnameController.text = auth.displayName ?? "";
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "images/assets/splashScreeen.jpg",
              fit: BoxFit.fitWidth,
              height: 42.h,
              width: 100.w,
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  appTextFormField(
                    "First Name",
                    prefixIcon: Icons.person_outline,
                    sHeight: 8.h,
                    controller: _firstnameController,
                    validator: (text) => text!.isEmpty == true
                        ? "Please enter first name!"
                        : null,
                  ),
                  appTextFormField(
                    "Last Name",
                    prefixIcon: Icons.person_outline,
                    sHeight: 8.h,
                    controller: _lastNameController,
                    validator: (text) => text!.isEmpty == true
                        ? "Please enter last name!"
                        : null,
                  ),
                  appTextFormField(
                    "Email Address",
                    prefixIcon: Icons.email_outlined,
                    sHeight: 8.h,
                    controller: _emailController,
                    validator: (text) => text!.isEmpty == true
                        ? "Please enter email address!"
                        : null,
                  ),
                  appTextFormField(
                    "Enter your address",
                    prefixIcon: Icons.home_outlined,
                    sHeight: 8.h,
                    controller: _addressController,
                    validator: (text) => text!.isEmpty == true
                        ? "Please enter address!"
                        : null,
                  ),
                  appTextFormField(
                    "Enter refer Code",
                    prefixIcon: Icons.family_restroom_rounded,
                    sHeight: 10.h,
                    controller: _otherReferralCode,
                    maxLength: 8,
                    validator: (text) => text!.isEmpty == true
                        ? "Please enter referral code!"
                        :  text.length <8? "Referral code should be of 8 characters":null  ,
                  ),
                ],
              ),
            ),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              isExpanded: true,
              dropdownColor: Colors.grey,
              decoration: const InputDecoration(
                  labelText: "Select Gender",
                  prefixIcon: Icon(
                    CupertinoIcons.person_2,
                    size: 20,
                  )),
              items: spinnerItems.map((spinnerItems) {
                return DropdownMenuItem(
                    value: spinnerItems,
                    child: Text(
                      spinnerItems,
                      style: smallTextStyle(),
                    ));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ).paddingSymmetric(horizontal: 16),
            20.height,
            isLoading?
            Center(
              child: Visibility(
                  visible: isLoading,
                  child: const CircularProgressIndicator()),
            )
                :ElevatedButton(
                style: elevatedButtonStyle(6.5.h, 90.w),
                onPressed: () async {

                  if(formkey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });

                    addUserData("");
                  }
                   //  var requestBody = {
                   //  'referral_code': _otherReferralCode.text.toString(),
                   // };
                  //   var authToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
                  //
                  //   final request = await PushNotification().httpClient.postUrl(
                  //       Uri.parse(PushNotification().baseUrl + "isvalidcode"));
                  //   request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
                  //   request.headers.set(HttpHeaders.authorizationHeader, "$authToken");
                  //   request.add(utf8.encode(json.encode(requestBody)));
                  //
                  //   final response = await request.close();
                  //
                  //   response.transform(utf8.decoder).listen((contents) async {
                  //     var jsonRes = json.decode(contents);
                  //     var message = jsonRes['message'];
                  //     if (message == "valid") {
                  //       addUserData(jsonRes['id']);
                  //     } else {
                  //
                  //       setState((){
                  //         isLoading = false;
                  //       });
                  //       Fluttertoast.showToast(msg: "Invalid referral code");
                  //     }
                  //   });
                  // }
                },
                child: Text(
                  "Save Profile",
                  style: boldTextStyle(color: white),
                )),
            15.height,
          ],
        ),
      ),
    );
  }

  Future<void> addUserData(String agent) async {
    AuthService()
        .addUserDetails(
            UserDetailsModel(
                userId: auth!.uid,
                userType: UserType(isUser: true, isAgent: false),
                type: 'user',
                newUser: false,
                gender: dropdownValue,
                status: true,
                updatedAt: Timestamp.now(),
                createdAt: Timestamp.now(),
                lastName: _lastNameController.text.toString(),
                firstName: _firstnameController.text.toString(),
                email: _emailController.text.toString(),
                referralCode: generateRandomString(8),
                number: widget.mobile,
                address: _addressController.text.toString(),
                otherReferralCode: _otherReferralCode.text.toString(),
                searchArray: AuthService().generateSearchArray([
                  _firstnameController.text.toString(),
                  _lastNameController.text.toString(),
                  _emailController.text.toString(),
                  widget.mobile
                ]),
                agentId: agent),
            auth!.uid)
        .then((value) async {
      await AppData.setBoolean(loginStatus, true);
      AuthService().getUserDetails(auth!.uid).then((value) {
        setState((){
          isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LandingPage()),
            (route) => false);
      });
    });
  }
}