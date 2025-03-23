import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership/screens/profile/ProfileComponents.dart';
import 'package:nb_utils/nb_utils.dart';

class VoucherPageDetails extends StatefulWidget {
  const VoucherPageDetails({Key? key}) : super(key: key);

  @override
  State<VoucherPageDetails> createState() => _VoucherPageDetailsState();
}

class _VoucherPageDetailsState extends State<VoucherPageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 30.0),
          child: Text(
            "Back",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          Center(
              child: Text(
            "Vouchers",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            width: 100,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          20.height,
          profileItemView("1 Free Night", "Expires - 19 May 2023", "Vouchers -",
              "#CVDDFGHRETDFGT1234", "Used"),
          16.height,
          profileItemView("1 Free Night", "Expires - 19 May 2023", "Vouchers -",
              "#CVDDFGHRETDFGT45343", "Expired"),
          16.height,
          profileItemView("1 Free Night", "Expires - 19 May 2023", "Vouchers -",
              "#FNB0FGHRETDFGTER01", "Active"),
          16.height,
          profileItemView("50% off on Restaurent", "Expires - 19 May 2023",
              "Vouchers -", "#FNB0FGHRETDFGTER04", "Expired"),
          16.height,
          profileItemView("50% off on Restaurent", "Expires - 19 May 2023",
              "Vouchers -", "#CVDDFGHRETDFGT1234", "Active"),
        ],
      ),
    );
  }
}