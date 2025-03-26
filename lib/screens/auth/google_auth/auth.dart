import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membership/screens/auth/google_auth/google_auth.dart';

import '../../../utils/data/data_storage.dart';
import '../../landing_page.dart';
import '../../profile/UserDetailsScreen.dart';

class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  SigningController signingController = Get.put(SigningController());
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Screens"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed: ()async{
          await signingController.signInWithGoogle();
        }, child: Text("Google")),
      ),
    );
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
