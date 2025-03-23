import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/utils/styles/textStyle.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/membership/MembershipDetailsModel.dart';
import '../../utils/colors.dart';
import '../brand/components/BrandComponent.dart';
import '../user_membership/components/UserMembershipComponent.dart';

class BrandDetails extends StatefulWidget {
  final String documentId;

  const BrandDetails(
    MembershipDetailsModel membershipData, {
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
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
      appBar: AppBar(
        title: const Text("Partner"),
      ),
      body: StreamBuilder(
        stream: MembershipService().getMembershipDetails(widget.documentId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            MembershipDetailsModel data = snapshot.data;
            return Stack(
              children: [
                ListView(
                  children: [
                    serviceProviderDetails(data.brandId ?? ""),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return emptyList("No Hotels Available Yet!");
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
    return Container(
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
                "$validity",
                style: secondaryTextStyle(color: orange, size: 10),
              )
            ],
          ),
          const Divider(
            color: white,
          ),
          Row(
            children: [
              Container(
                  width: 290,
                  child: Text(
                    membershipData.desc ?? "NA",
                    style: GoogleFonts.inter(color: white, fontSize: 12),
                  )),
              Icon(Icons.arrow_forward_ios).paddingLeft(10)
            ],
          ),
          5.height,
          showAndHideText(membershipData.moreInfo ?? "", fontSize: 10),
        ],
      ),
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