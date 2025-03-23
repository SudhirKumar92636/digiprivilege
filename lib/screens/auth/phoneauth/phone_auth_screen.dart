import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:membership/auth_servece.dart';
import 'otp_screen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Phone Auth"),),
        body: Column(
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    helperText: "Enter Phone Number",
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: ()async{
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted: (PhoneAuthCredential credential){},
                        verificationFailed: (FirebaseAuthException ex){},
                        codeSent: (String verificationid,int? resendtoken){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(verificationid: verificationid, mobile: phoneController.text.toString(),
                            isAgent: true,),));
                        },
                        codeAutoRetrievalTimeout: (String verificationId){},
                        phoneNumber: "+91${phoneController.text.toString()}"
                    );
                  }, child: Text("verify phone number")
              ),
              ElevatedButton(onPressed: ()async {
               var auth = await AuthService().signInWithGoogle();
               print(auth?.email);
              }, child: Text("Google Auth"))
            ],
        ),
    );
  }
}
