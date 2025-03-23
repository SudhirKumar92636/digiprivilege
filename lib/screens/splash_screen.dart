import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:membership/screens/auth/phone/screens/TestRuls.dart';
import 'package:membership/utils/data/data_storage.dart';

import '../utils/data/image_url.dart';
import 'auth/phone/components/PhoneAuthComponents.dart';
import 'auth/phone/screens/PhoneAuthScreen.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      _isUserLogIn();
    });
  }

  _isUserLogIn() async {
    bool _isLogin = await AppData.getBoolean(loginStatus);
    if (_isLogin == true) {
      goToHome();
    } else {
      goToLogin();
    }
  }

  goToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LandingPage()));
  }

  goToLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PhoneAuthScreen()));
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const TestRuls()));
  }

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
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "You life and",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "your experience",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
        //loginBackground(),
        );
  }

  Widget animatedSplashView() {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: logo(),
        nextScreen: const PhoneAuthScreen(),
        splashIconSize: 200,
        centered: true,
        curve: Curves.decelerate,
        animationDuration: const Duration(seconds: 2),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white);
  }

  Widget logo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "images/assets/splashScreeen.jpg",
          fit: BoxFit.fitWidth,
          width: 300,
        )
      ],
    );
  }
}