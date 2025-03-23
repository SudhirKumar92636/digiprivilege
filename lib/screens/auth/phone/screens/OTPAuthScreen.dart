import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:membership/screens/user_membership/services/UserMembershipService.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import '../../../../services/FirebaseServices.dart';
import '../../../../services/PushNofitication.dart';
import '../../../../utils/data/data_storage.dart';
import '../../../../utils/data/image_url.dart';
import '../../../landing_page.dart';
import '../../../profile/UserDetailsScreen.dart';
import '../components/PhoneAuthComponents.dart';
import '../services/AuthService.dart';

class OTPAuthScreen extends StatefulWidget {
  final String mobile;
  bool isAgent;
  final String verificationId;
   OTPAuthScreen({Key? key, required this.mobile, required this.isAgent, required this.verificationId}) : super(key: key);

  @override
  State<OTPAuthScreen> createState() => _OTPAuthScreenState();
}

class _OTPAuthScreenState extends State<OTPAuthScreen> {
  late String _verificationCode;
  OtpTimerButtonController controller = OtpTimerButtonController();
  var logger = Logger();
  var service = FirebaseServices();
  var auth = FirebaseAuth.instance.currentUser;
  var status = false;
  bool isLoading = false;
  String pin = '';
  bool isAgent = false;


  // _requestOtp() {
  //   controller.loading();
  //   Future.delayed(const Duration(seconds: 120), () {
  //     controller.startTimer();
  //     _verifyPhone();
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _verifyPhone();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            40.height,
            authPhoneNumberView(" +91 ${widget.mobile}"),
            50.height,
            // OTPTextField(
            //   length: 6,
            //   width: 90.w,
            //   fieldWidth: 45,
            //   style: const TextStyle(fontSize: 17, color: Colors.white),
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   fieldStyle: FieldStyle.box,
            //   keyboardType: TextInputType.phone,
            //   otpFieldStyle: OtpFieldStyle(
            //       backgroundColor: grey.withOpacity(.3),
            //       enabledBorderColor: Colors.orange,
            //       focusBorderColor: Colors.orange),
            //   onChanged: (code) {
            //     setState(() {
            //       pin = code;
            //     });
            //   },
            // ).paddingSymmetric(horizontal: 15, vertical: 0),
            Pinput(
              length: 6,
              keyboardType: TextInputType.number,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              defaultPinTheme: PinTheme(
                width: 45,
                height: 50,
                textStyle: const TextStyle(fontSize: 17, color: Colors.white),
                decoration: BoxDecoration(
                  color: grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 45,
                height: 50,
                textStyle: const TextStyle(fontSize: 17, color: Colors.white),
                decoration: BoxDecoration(
                  color: grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange, width: 2),
                ),
              ),
              onChanged: (code) {
                setState(() {
                  pin = code;
                });
              },
            ).paddingSymmetric(horizontal: 15, vertical: 0),
            40.height,
            isLoading
                ? Center(
                    child: Visibility(
                        visible: isLoading,
                        child: const CircularProgressIndicator()),
                  ) : InkWell(
                    onTap: () {
                      if (pin.length <= 5) {
                        Fluttertoast.showToast(msg: "Please enter a valid OTP");
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        validateOTP();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      height: 7.h,
                      decoration: boxDecorationRoundedWithShadow(30,
                          backgroundColor: Colors.orange,
                          shadowColor: Colors.black),
                      child: Center(
                        child: Text(
                          "Verify OTP",
                          style: boldTextStyle(color: white),
                        ),
                      ).paddingSymmetric(horizontal: 15),
                    ),
                  ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: OtpTimerButton(
                backgroundColor: Colors.grey.withOpacity(.6),
                controller: controller,
                onPressed: (){},
                loadingIndicator: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
                text: const Text(
                  'Resend OTP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                duration: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '+91${widget.mobile}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {},
  //       verificationFailed: (FirebaseAuthException e) {
  //         logger.i("verification failed details $e");
  //         Fluttertoast.showToast(msg: e.message!);
  //       },
  //       codeSent: (String? verificationID, int? resendToken) {
  //         logger.i("verification id $verificationID $resendToken");
  //         logger.i("response token $resendToken");
  //         setState(() {
  //           _verificationCode = verificationID!;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           logger.i("This is user details $verificationID");
  //           _verificationCode = verificationID;
  //         });
  //       },
  //       timeout: const Duration(seconds: 120));
  // }

  validateOTP() async {
    try {
      // PhoneAuthCredential credential = await PhoneAuthProvider.credential(
      //     verificationId: widget.verificationId,
      //     smsCode: pin);
      //    FirebaseAuth.instance.signInWithCredential(credential).then((auth) {
      //
      //    },);
      await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
              verificationId: widget.verificationId, smsCode: pin))
          .then((auth)async{
        var firstChunk = utf8.encode("rzp_test_ROMPOMqAyx4oCV");
        var secondChunk = utf8.encode("ehNnvCh86xaWw9UIjkbpJLIn");
        var output =AccumulatorSink<Digest>();
        var input = sha1.startChunkedConversion(output);
        input.add(firstChunk);
        input.add(secondChunk);
        input.close();
        var digest = output.events.single;
        print("Digest as bytes: ${digest.bytes}");
        print("Digest as hex string: $digest");
        var requestBody = {
          'phone': widget.mobile
        };
        var authToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        final request = await PushNotification().httpClient.postUrl(
            Uri.parse(PushNotification().baseUrl + "isuser"));
        request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
        request.headers.set(HttpHeaders.authorizationHeader, "$authToken");
        request.add(utf8.encode(json.encode(requestBody)));

        ///bug here
        final response = await request.close();
        response.transform(utf8.decoder).listen((contents) async {
          print(contents);
          var jsonRes = json.decode(contents);
          var doc = jsonRes['data'];
          int status = jsonRes['status'];
          var docId =  jsonRes['id'];
          if(docId !="" ){
            bool isUser =  doc['user'];
            bool agent =  doc['agent'];
            if (agent == true && auth.user != null) {
              AuthService().getUserDetails(auth.user!.uid).then((value) {
                setState(() {
                  isLoading = false;
                });
                goLandingPage();
              });
            } else if(isUser == true && auth.user != null) {
              if (docId != auth.user?.uid) {
                AuthService().updateUserDocOfAgent(
                    context, auth.user?.uid ?? "", docId ?? "");

                UserMembershipService().getAllUserMembershipByNumber(widget.mobile).then((value) =>{
                  if(value != null){
                    // ignore: avoid_function_literals_in_foreach_calls
                    value.forEach((element) {
                      if (element.userId != auth.user?.uid) {
                        UserMembershipService().updateUidOfMembership(auth.user?.uid??"", element.id ?? "");
                      }
                    })
                  }
                });
              }
              AuthService().getUserDetails(auth.user!.uid).then((value) {
                setState(() {
                  isLoading = false;
                });

                goLandingPage();
              });
              isLoading = false;
            }

          } else if(status == 200){
            setState(() {
              isLoading = false;
            });
            Logger().i("false");
            newUserPage();
          }
        });
      });
    } catch (e) {
      {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Please enter a valid OTP");
        logger.i("pin verification $e");
        FocusScope.of(context).unfocus();
      }
    }
  }

  goLandingPage() async {
    await AppData.setBoolean(loginStatus, true);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
        (route) => false);
  }

  newUserPage() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>   UserDetailsScreen(
          mobile: widget.mobile,
        )), (route) => false);
    // UserDetailsScreen(
    //   mobile: widget.mobile,
    // ).launch(context);
  }
}
