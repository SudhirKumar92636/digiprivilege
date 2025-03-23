import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/screens/home_fragment.dart';

class OtpScreen extends StatefulWidget {
  final String verificationid;
  final String mobile;
  final bool isAgent;
  const OtpScreen({super.key, required this.verificationid, required this.mobile, required this.isAgent});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("OTP")),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("OTP sent to ${widget.mobile}"),
                SizedBox(height: 20),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    helperText: "Enter OTP",
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationid,
                        smsCode: otpController.text.trim(),
                      );

                      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeFragment()),
                        );
                      });
                    } catch (ex) {
                      log("OTP Error: $ex");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid OTP")),
                      );
                    }
                  },
                  child: Text("Verify OTP"),
                ),
              ],
            ),
        ),
    );
  }
}
