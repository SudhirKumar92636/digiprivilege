import 'package:flutter/material.dart';
import 'package:membership/screens/landing_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

class SuccessfulMembershipBuyScreen extends StatefulWidget {
  const SuccessfulMembershipBuyScreen({Key? key}) : super(key: key);

  @override
  State<SuccessfulMembershipBuyScreen> createState() =>
      _SuccessfulMembershipBuyScreenState();
}

class _SuccessfulMembershipBuyScreenState
    extends State<SuccessfulMembershipBuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            return goToHome();
          },
          child: ListView(
            children: [
              Center(
                  child: Text(
                "Thank you ",
                style: boldTextStyle(size: 30),
              )),
              SizedBox(
                  height: 36.h,
                  width: 50,
                  child: Image.asset(
                    'images/assets/success.gif',
                  )),
              10.height,
              Center(
                  child: Text(
                "Your payment successful",
                style: boldTextStyle(size: 20),
              )),
              const Text(
                      'Your payment for membership is done. your order id is 34934786245')
                  .paddingSymmetric(horizontal: 20),
              50.height,
              ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()),
                            (route) => false);
                      },
                      child: Text("Close"))
                  .paddingSymmetric(horizontal: 30, vertical: 40)
            ],
          ),
        ),
      ),
    );
  }

  goToHome() {}
}
