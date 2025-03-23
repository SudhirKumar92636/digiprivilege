import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership/utils/decorations/appTextFiled.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/data/image_url.dart';
import '../../../../utils/styles/buttonStyle.dart';
import '../components/PhoneAuthComponents.dart';
import 'OTPAuthScreen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final phoneKey = GlobalKey<FormState>();
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
              const SizedBox(
                height: 80,
              ),
              appTextFormField("Phone Number",
                  prefixIcon: CupertinoIcons.device_phone_portrait,
                  controller: phoneController,
                  keyBoardType: TextInputType.phone,
                  maxLength: 10, onChange: (text) {
                if (text!.length == 10) {
                  setState(() {
                    enableButton = true;
                  });
                } else {
                  setState(() {
                    enableButton = false;
                  });
                }
                return null;
              }).paddingSymmetric(horizontal: 16),
              40.height,
              isLoading
                  ? Center(
                    child: Visibility(
                        visible: isLoading, child: const CircularProgressIndicator()),
                  )
                  : InkWell(
                      child: Visibility(
                        visible: enableButton,
                        child: ElevatedButton(
                          style: elevatedButtonStyle(6.5.h, 90.w),
                          child: Text(
                            "Get OTP",
                            style: boldTextStyle(color: white),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                verificationCompleted: (PhoneAuthCredential credential){},
                                verificationFailed: (FirebaseAuthException ex) {
                                  Fluttertoast.showToast(msg: "Verification failed: ${ex.message}");
                                  print("Verification Error: ${ex.code} - ${ex.message}");
                                },
                                codeSent: (String verificationId,int? resendToken){
                                  OTPAuthScreen(
                                    mobile: phoneController.text.toString(),
                                    isAgent: true,
                                    verificationId: verificationId,
                                  ).launch(context);
                                },
                                codeAutoRetrievalTimeout: (String verificationId){},
                                phoneNumber: "+91${phoneController.text.toString()}"
                            );
                            // OTPAuthScreen(
                            //   mobile: phoneController.text.toString(),
                            //   isAgent: true,
                            // ).launch(context);
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ).paddingSymmetric(horizontal: 16),
                      ),
                    ),
            ],
          ),
        ));
  }
}
