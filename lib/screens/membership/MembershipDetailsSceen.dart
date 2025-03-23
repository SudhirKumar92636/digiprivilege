import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membership/screens/brand/BrandDetails.dart';
import 'package:membership/screens/membership/MembershipPaymentScreen.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/utils/styles/textStyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../models/membership/CouponDetailsModel.dart';
import '../../models/membership/MembershipDetailsModel.dart';
import '../../utils/colors.dart';
import '../user_membership/components/UserMembershipComponent.dart';
import 'components/OfferDetailsComponent.dart';

class MembershipDetailsScreen extends StatefulWidget {
  final String documentId;

  const MembershipDetailsScreen({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<MembershipDetailsScreen> createState() =>
      _MembershipDetailsScreenState();
}

class _MembershipDetailsScreenState extends State<MembershipDetailsScreen> {
  bool hasPurchased = true;

  @override
  void initState() {
    super.initState();
  }

  checkOfferStatus() async {
    await MembershipService().checkOfferStatus(widget.documentId).then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          hasPurchased = false;
        });
      } else {
        setState(() {
          hasPurchased = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: MembershipService().getMembershipDetails(widget.documentId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            MembershipDetailsModel data = snapshot.data;
            return Stack(
              children: [
                ListView(
                  children: [
                    imageWithIndicatorsMembership(
                        context, data.images ?? <String>[], 20 / 9, data),
                    membershipDetailsView(data),
                    SizedBox(
                      height: 75.h,
                      child: couponsItemListView(
                          widget.documentId, true, context, 2),
                      width: 100.w,
                    ),
                    Visibility(
                      visible: hasPurchased,
                      child: FutureBuilder(
                        future: MembershipService().getAllCouponsByMembership(
                            data.id ?? "",
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            List<CouponDetailsModel> dataList = snapshot.data;
                            return MembershipPaymentScreen(
                              membershipDetailsData: data,
                              couponData: dataList,
                            );
                          } else {
                            return const Text("sorry! this membership is not available");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return emptyList("No Details");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ));
  }

  membershipDetailsView(MembershipDetailsModel membershipData) {
    String a = membershipData.duration ?? "";
    String validity = getYearFromDay(a);
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: boxDecorationRoundedWithShadow(
          8,
          backgroundColor: fillColor,
          blurRadius: 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${membershipData.title}",
                  style: boldTextStyle(color: white, size: 14),
                ),
                Text(
                  validity,
                  style: secondaryTextStyle(color: orange, size: 10),
                )
              ],
            ),
            const Divider(
              color: white,
            ),
            Row(
              children: [
                SizedBox(
                    width: 270,
                    child: Text(
                      membershipData.desc ?? "NA",
                      style: GoogleFonts.inter(color: white, fontSize: 12),
                    )),
                const Icon(Icons.arrow_forward_ios).paddingLeft(10)
              ],
            ),
            5.height,
            showAndHideText(membershipData.moreInfo ?? "", fontSize: 10),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BrandDetails(
                      membershipData,
                      documentId: membershipData.id ?? "",
                    )));
      },
    );
  }

  String getYearFromDay(String day) {
    int dayInt = int.parse(day);
    double year = dayInt / 365;
    if (year.toInt() < 2) {
      return "${year.toInt()} year";
    } else {
      return "${year.toInt()} years";
    }
  }
}