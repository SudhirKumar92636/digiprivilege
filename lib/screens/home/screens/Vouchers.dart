import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:membership/screens/landing_page.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/OfferDetailsModel.dart';
import '../../../services/FirebaseServices.dart';
import '../../../utils/colors.dart';
import '../../voucher_details.dart';
import '../comconents/VouchersItems.dart';

class Vouchers extends StatefulWidget {
  final String documentId;

  Vouchers({Key? key, required this.documentId}) : super(key: key);

  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  var service = FirebaseServices();
  var store = FirebaseFirestore.instance;
  final updates = <String, dynamic>{
    "timestamp": FieldValue.serverTimestamp(),
  };
  var userId = FirebaseAuth.instance.currentUser!.uid;
  String member_ship_id = "";
  String title = "";
  String price = "";
  String descriptions = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: WillPopScope(
              child: FutureBuilder<OfferDetailsModel>(
                future: getOfferDetails(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    OfferDetailsModel data = snapshot.data as OfferDetailsModel;
                    member_ship_id = data.id.toString();
                    descriptions = data.desc.toString();
                    title = data.title.toString();
                    price = data.price.toString();
                    return ListView(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LandingPage()),
                                    (route) => false);
                              },
                              icon: const Icon(Icons.arrow_back_ios,
                                  size: 20, color: Colors.white),
                            ),
                            const Text(
                              "Membership",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            const VoucherPageDetails().launch(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 270,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Image.network(
                                        "https://jenjon.in/wp-content/uploads/2015/08/12.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                            alignment: Alignment.topCenter,
                                            child: VochersText(
                                                "Radisson Membership",
                                                nightColor,
                                                22.0))
                                        .paddingTop(25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        VochersText(
                                            "Rs. 300", nightColor, 16.0),
                                      ],
                                    ).paddingAll(15),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: VochersText(
                                          " Starting Date - 20 May 2022",
                                          nightColor,
                                          13),
                                    ).paddingTop(20),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: VochersText(
                                          "ExpireDate - 19 May 2023",
                                          appThemeColor,
                                          13.0),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Text(
                                      "This Benefit is Valid for 2 Adults ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      " Can't Be used together , Minimum 7 days of ",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ).paddingAll(30),
                              ],
                            ),
                          ).paddingAll(15),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              onWillPop: () async {
                return await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                    (route) => false);
              })),
    );
  }
  Future<OfferDetailsModel> getOfferDetails() async {
    var collection = store.collection('membership');
    var docSnapshot = await collection.doc(widget.documentId).get();
    if (docSnapshot.exists) {
      var resData = docSnapshot.data();
      Logger().i(resData);
      var data = OfferDetailsModel.fromJson(resData!);
      return data;
    } else {
      return OfferDetailsModel();
    }
  }
}