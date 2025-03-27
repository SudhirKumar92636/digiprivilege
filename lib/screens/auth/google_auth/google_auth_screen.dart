import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/data/data_storage.dart';
import '../../../utils/data/image_url.dart';
import '../../landing_page.dart';
import '../../profile/UserDetailsScreen.dart';
import '../phone/components/PhoneAuthComponents.dart';
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
  SigningController signingController = Get.put(SigningController());

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
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() => isLoading = true);
                      await SigningController().signInWithGoogle();
                      setState(() => isLoading = false);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2, // Shadow effect
                    ),
                    icon: Image.asset(
                      authImage,
                      height:30,
                      width: 30,
                    ),
                    label: const Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )


            ],
          ),
        ));
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