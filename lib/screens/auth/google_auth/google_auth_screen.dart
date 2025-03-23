// import 'dart:convert';
// import 'dart:io';
// import 'package:convert/convert.dart';
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:logger/logger.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:path/path.dart';
// import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
// import '../../../services/PushNofitication.dart';
// import '../../../utils/data/data_storage.dart';
// import '../../../utils/data/image_url.dart';
// import '../../../utils/decorations/appTextFiled.dart';
// import '../../../utils/styles/buttonStyle.dart';
// import '../../landing_page.dart';
// import '../../profile/UserDetailsScreen.dart';
// import '../../user_membership/services/UserMembershipService.dart';
// import '../phone/components/PhoneAuthComponents.dart';
// import '../phone/screens/OTPAuthScreen.dart';
// import '../phone/services/AuthService.dart';
// import 'google_auth.dart';
//
// class GoogleAuthScreens extends StatefulWidget {
//   const GoogleAuthScreens({Key? key}) : super(key: key);
//
//   @override
//   State<GoogleAuthScreens> createState() => _GoogleAuthScreensState();
// }
//
// class _GoogleAuthScreensState extends State<GoogleAuthScreens> {
//
//   final phoneKey = GlobalKey<FormState>();
//   final phoneController = TextEditingController();
//   bool enableButton = false;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: SizedBox(
//           height: 40,
//           child: authTermAndConditionText(),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.asset(
//                 authHeaderImage,
//                 fit: BoxFit.fitWidth,
//               ),
//               const SizedBox(
//                 height: 80,
//               ),
//               appTextFormField("Phone Number",
//                   prefixIcon: CupertinoIcons.device_phone_portrait,
//                   controller: phoneController,
//                   keyBoardType: TextInputType.phone,
//                   maxLength: 10,
//                   onChange: (text) {
//                     if (text!.length == 10) {
//                       setState(() {
//                         enableButton = true;
//                       });
//                     } else {
//                       setState(() {
//                         enableButton = false;
//                       });
//                     }
//                     return null;
//                   }).paddingSymmetric(horizontal: 16),
//               40.height,
//               isLoading
//                   ? Center(
//                 child: Visibility(
//                     visible: isLoading,
//                     child: const CircularProgressIndicator()),
//               )
//                   : InkWell(
//                 child: Visibility(
//                   visible: enableButton,
//                   child: ElevatedButton(
//                     child: Text(
//                       "Get OTP",
//                       style: boldTextStyle(color: white),
//                     ),
//                     onPressed: () async {
//                       setState(() {
//                         isLoading = true;
//                       });
//
//                       await SigningController().signInWithGoogle();
//                       var uid = FirebaseAuth.instance.currentUser?.uid;
//                       if (uid != null) {
//                         validateOTP(phoneController.text.toString());
//                       }
//                       setState(() {
//                         isLoading = false;
//                       });
//                     },
//                   ).paddingSymmetric(horizontal: 16),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   validateOTP(String phone) async {
//     try {
//       // PhoneAuthCredential credential = await PhoneAuthProvider.credential(
//       //     verificationId: widget.verificationId,
//       //     smsCode: pin);
//       //    FirebaseAuth.instance.signInWithCredential(credential).then((auth) {
//       //
//       //    },);
//
//         var auth = FirebaseAuth.instance;
//         var firstChunk = utf8.encode("rzp_test_ROMPOMqAyx4oCV");
//         var secondChunk = utf8.encode("ehNnvCh86xaWw9UIjkbpJLIn");
//         var output =AccumulatorSink<Digest>();
//         var input = sha1.startChunkedConversion(output);
//         input.add(firstChunk);
//         input.add(secondChunk);
//         input.close();
//         var digest = output.events.single;
//         print("Digest as bytes: ${digest.bytes}");
//         print("Digest as hex string: $digest");
//         var requestBody = {
//           'phone': phone
//         };
//         var authToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
//         final request = await PushNotification().httpClient.postUrl(
//             Uri.parse(PushNotification().baseUrl + "isuser"));
//         request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
//         request.headers.set(HttpHeaders.authorizationHeader, "$authToken");
//         request.add(utf8.encode(json.encode(requestBody)));
//
//         ///bug here
//         final response = await request.close();
//         response.transform(utf8.decoder).listen((contents) async {
//           print(contents);
//           var jsonRes = json.decode(contents);
//           var doc = jsonRes['data'];
//           int status = jsonRes['status'];
//           var docId =  jsonRes['id'];
//           if(docId !="" ){
//             bool isUser =  doc['user'];
//             bool agent =  doc['agent'];
//             if (agent == true && auth.currentUser != null) {
//               AuthService().getUserDetails(auth.currentUser!.uid).then((value) {
//                setState(() {
//                  goLandingPage();
//
//                });
//             } else if(isUser == true && auth.currentUser != null) {
//               if (docId != auth.currentUser?.uid) {
//                 AuthService().updateUserDocOfAgent(
//                     context as BuildContext, auth.currentUser?.uid ?? "", docId ?? "");
//
//                 UserMembershipService().getAllUserMembershipByNumber(phoneController.text.toString()).then((value) =>{
//                   if(value != null){
//                     // ignore: avoid_function_literals_in_foreach_calls
//                     value.forEach((element) {
//                       if (element.userId != auth.currentUser?.uid) {
//                         UserMembershipService().updateUidOfMembership(auth.currentUser?.uid??"", element.id ?? "");
//                       }
//                     })
//                   }
//                 });
//               }
//               AuthService().getUserDetails(auth.currentUser!.uid).then((value) {
//                 setState(() {
//                   isLoading = false;
//                 });
//
//                 goLandingPage();
//               });
//               isLoading = false;
//             }
//
//           } else if(status == 200){
//             setState(() {
//               isLoading = false;
//             });
//             Logger().i("false");
//             newUserPage();
//           }
//         });
//
//     } catch (e) {
//       {
//         setState(() {
//           isLoading = false;
//         });
//         Fluttertoast.showToast(msg: "Please enter a valid OTP");
//         logger.i("pin verification $e");
//         FocusScope.of(context as BuildContext).unfocus();
//       }
//     }
//   }
//
//   goLandingPage() async {
//     await AppData.setBoolean(loginStatus, true);
//     Navigator.pushAndRemoveUntil(
//         context as BuildContext,
//         MaterialPageRoute(builder: (context) => const LandingPage()),
//             (route) => false);
//   }
//
//   newUserPage() async {
//     Navigator.pushAndRemoveUntil(
//         context as BuildContext,
//         MaterialPageRoute(builder: (context) =>   UserDetailsScreen(
//           mobile:phoneController.text.toString(),
//         )), (route) => false);
//     // UserDetailsScreen(
//     //   mobile: widget.mobile,
//     // ).launch(context);
//   }
//   }




import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../services/PushNofitication.dart';
import '../../../utils/data/data_storage.dart';
import '../../../utils/data/image_url.dart';
import '../../../utils/decorations/appTextFiled.dart';
import '../../../utils/styles/buttonStyle.dart';
import '../../landing_page.dart';
import '../../profile/UserDetailsScreen.dart';
import '../../user_membership/services/UserMembershipService.dart';
import '../phone/components/PhoneAuthComponents.dart';
import '../phone/screens/OTPAuthScreen.dart';
import '../phone/services/AuthService.dart';
import 'google_auth.dart';

class GoogleAuthScreens extends StatefulWidget {
  const GoogleAuthScreens({Key? key}) : super(key: key);

  @override
  State<GoogleAuthScreens> createState() => _GoogleAuthScreensState();
}

class _GoogleAuthScreensState extends State<GoogleAuthScreens> {
  final phoneController = TextEditingController();
  bool enableButton = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 40,
          child: authTermAndConditionText(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                authHeaderImage,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 80),
              appTextFormField("Phone Number",
                  prefixIcon: CupertinoIcons.device_phone_portrait,
                  controller: phoneController,
                  keyBoardType: TextInputType.phone,
                  maxLength: 10,
                  onChange: (text) {
                    setState(() {
                      enableButton = text!.length == 10;
                    });
                    return null;
                  }).paddingSymmetric(horizontal: 16),
              40.height,
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Visibility(
                visible: enableButton,
                child: ElevatedButton(
                  child: Text("Get OTP", style: boldTextStyle(color: white)),
                  onPressed: () async {
                    setState(() => isLoading = true);
                    await SigningController().signInWithGoogle();
                    var uid = FirebaseAuth.instance.currentUser?.uid;
                    if (uid != null) {
                      await validateOTP(phoneController.text.trim());
                    }
                    setState(() => isLoading = false);
                  },
                ).paddingSymmetric(horizontal: 16),
              ),
            ],
          ),
        ));
  }

  Future<void> validateOTP(String phone) async {
    try {
      var auth = FirebaseAuth.instance;
      var requestBody = {'phone': phone};
      var authToken = await auth.currentUser?.getIdToken(true);
      final request = await PushNotification().httpClient.postUrl(
          Uri.parse(PushNotification().baseUrl + "isuser"));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      request.headers.set(HttpHeaders.authorizationHeader, "$authToken");
      request.add(utf8.encode(json.encode(requestBody)));

      final response = await request.close();
      response.transform(utf8.decoder).listen((contents) async {
        var jsonRes = json.decode(contents);
        var doc = jsonRes['data'];
        int status = jsonRes['status'];
        var docId = jsonRes['id'];

        if (docId != null && docId.isNotEmpty) {
          bool isUser = doc['user'];
          bool agent = doc['agent'];

          if (agent && auth.currentUser != null) {
            AuthService().getUserDetails(auth.currentUser!.uid).then((_) {
              goLandingPage();
            });
          } else if (isUser && auth.currentUser != null) {
            if (docId != auth.currentUser?.uid) {
              AuthService().updateUserDocOfAgent(context, auth.currentUser?.uid ?? "", docId);
              UserMembershipService()
                  .getAllUserMembershipByNumber(phoneController.text)
                  .then((value) => {
                if (value != null)
                  {
                    for (var element in value)
                      {
                        if (element.userId != auth.currentUser?.uid)
                          {
                            UserMembershipService()
                                .updateUidOfMembership(auth.currentUser?.uid ?? "", element.id ?? "")
                          }
                      }
                  }
              });
            }
            AuthService().getUserDetails(auth.currentUser!.uid).then((_) {
              setState(() => isLoading = false);
              goLandingPage();
            });
          }
        } else if (status == 200) {
          setState(() => isLoading = false);
          Logger().i("false");
          newUserPage();
        }
      });
    } catch (e) {
      setState(() => isLoading = false);
      Fluttertoast.showToast(msg: "Please enter a valid OTP");
      Logger().i("pin verification $e");
      FocusScope.of(context).unfocus();
    }
  }

  void goLandingPage() async {
    await AppData.setBoolean(loginStatus, true);
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => const LandingPage()), (route) => false);
  }

  void newUserPage() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetailsScreen(mobile: phoneController.text.trim())),
            (route) => false);
  }
}