import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../models/brand/BrandDetailsModel.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles/ImageView.dart';
import '../../../utils/styles/textStyle.dart';
import '../../membership/services/MembershipService.dart';

serviceProviderDetails(String brandId) {
  return StreamBuilder(
    stream: MembershipService().getBrandDetails(brandId),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        BrandDetailsModel brandData = snapshot.data;
        var address =
            "${brandData.addressLine1 ?? "NA"},${brandData.addressLine2} ${brandData.city ?? ""}, ${brandData.state ?? ""}, ${brandData.pincode}";
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 70.h,
          decoration: boxDecorationRoundedWithShadow(
            8,
            backgroundColor: fillColor,
            blurRadius: 1,
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hotel Details",
                    style: boldTextStyle(color: white, size: 14),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    size: 24,
                  )
                ],
              ),
              const Divider(
                color: white,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: .5, color: appThemeColor)),
                    child: showNetworkImageWithCached(
                        brandData.logoUrl ?? "", 7.h, 14.w, 8,
                        fit: BoxFit.contain),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 230,
                        child: Text(
                          "${brandData.name ?? "NA"}, ${brandData.state ?? ""}",
                          style: GoogleFonts.inter(color: white, fontSize: 18),
                        ),
                      ),
                      2.height,
                      Row(
                        children: [
                          RatingBarWidget(
                            onRatingChanged: (value) {},
                            itemCount: 5,
                            size: 14,
                            activeColor: orange,
                            rating: double.parse(brandData.ratings ?? "0.0"),
                            allowHalfRating: true,
                            disable: true,
                          ),
                          5.width,
                          Text(
                            "( ${brandData.noVoters ?? "0"} votes)",
                            style: secondaryTextStyle(color: Colors.green),
                          )
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 10)
                ],
              ),
              5.height,
              Text(
                address,
                style: secondaryTextStyle(color: white),
              ),
              10.height,
              Text(
                "Description",
                style: boldTextStyle(color: white, size: 16),
              ),
              2.height,
              showAndHideText(brandData.description ?? ""),
              10.height,
              Text(
                "Support",
                style: boldTextStyle(color: white, size: 14),
              ),
              const Divider(
                color: white,
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.call,
                    color: appThemeColor,
                  ),
                  backgroundColor: black,
                ),
                title: Text(
                  "${brandData.support?.contact ?? "No Found"}",
                ),
                textColor: white,
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.email,
                    color: appThemeColor,
                  ),
                  backgroundColor: black,
                ),
                title: Text(
                  brandData.support?.email ?? "No Found",
                ),
                textColor: white,
              )
            ],
          ).paddingBottom(80),
        );
      } else {
        return Container();
      }
    },
  );
}