import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:membership/screens/WebView.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../models/HomeDataModel.dart';
import '../../../utils/styles/ImageView.dart';
import '../../user_membership/components/BuyNowMembership.dart';

seeAllView(String title, Function() onClick) {
  return InkWell(
    onTap: () => onClick(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 5)]),
          child: const Text(
            "SEE ALL",
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
          ).paddingSymmetric(horizontal: 10, vertical: 5),
        ),
      ],
    ),
  ).paddingSymmetric(horizontal: 10, vertical: 10);
}

homeItemView(Widget target, BuildContext context) {
  return Container(
    height: 32.h,
    width: 50.w,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: boxDecorationRoundedWithShadow(20),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network("https://picsum.photos/500/300?random=1",
              fit: BoxFit.fitHeight, height: 32.h, width: 50.w),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Container(
              height: 6.h,
              width: 12.w,
              decoration: boxDecorationRoundedWithShadow(8, shadowColor: grey),
              child: const Center(
                  child: FaIcon(
                FontAwesomeIcons.hotel,
                color: grey,
                size: 30,
              )),
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 10.h,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      tileMode: TileMode.decal,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        black.withOpacity(.3),
                        black.withOpacity(.5),
                        black.withOpacity(.7),
                      ])),
              child: Column(
                children: [
                  2.height,
                  Text(
                    "Jurassic World Dominion",
                    style: boldTextStyle(color: white),
                  ),
                  Text(
                    "ticket @ up to 40% off",
                    style: secondaryTextStyle(color: white),
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.fire,
                        color: orange,
                        size: 12,
                      ),
                      Text(
                        "Limited Period offer",
                        style: secondaryTextStyle(color: white, size: 10),
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    ),
  ).onTap(() {
    target.launch(context);
  });
}

Widget groceryCategoriesList(
    List<Item>? categoryData, BuildContext context, HomeDataModel data) {
  return MasonryGridView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: categoryData!.length,
      //categoryData!.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      crossAxisSpacing: 7,
      mainAxisSpacing: 7,
      itemBuilder: (c, index) =>
          categoryItemView(categoryData[index], context, data));
}

categoryItemView(Item categoryData, BuildContext context, HomeDataModel data) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewExample(
                    web_url: categoryData.web_url ?? "https://www.google.com/",
                  )));
    },
    child: Container(
        decoration:
            boxDecorationRoundedWithShadow(10, shadowColor: Colors.black12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: showNetworkImageWithCached(
                      categoryData.hero_image_url!, 14.h, 46.0.w, 10),
                )
              ],
            ),
            Text(
              categoryData.title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.black),
            ).paddingSymmetric(vertical: 10),
          ],
        )),
  );
}

Widget trendsListView(List<Item> data, BuildContext context) {
  return MasonryGridView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemBuilder: (c, index) => trendsListItem(data[index], context));
}

Widget trendsListItem(Item data, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BuyNowMembersship()));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MembershipDetailsScreen(
      //               documentId: data.id ?? "",
      //             )));
    },
    child: Stack(
      children: [
        SizedBox(
          height: 35.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                showNetworkImageWithCached(data.hero_image_url!, 45.h, 90.w, 8),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 10.h,
              color: Colors.black.withOpacity(.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? "hello",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: boldTextStyle(size: 20, color: Colors.white),
                  ),
                  Text(
                    data.desc ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: secondaryTextStyle(color: Colors.white),
                  )
                ],
              ).paddingSymmetric(horizontal: 10, vertical: 10),
            ))
      ],
    ),
  );
}