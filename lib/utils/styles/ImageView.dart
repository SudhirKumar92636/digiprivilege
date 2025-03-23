import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:membership/models/HomeDataModel.dart';
import 'package:membership/screens/membership/MembershipDetailsSceen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

Widget imageWithIndicators(
    BuildContext context, List<Item> images, double aspectRadio) {
  var _current = 0;
  return StatefulBuilder(builder: (context, state) {
    return SizedBox(
      height: 26.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
                items: images.map((slider) {
                  return Builder(builder: (BuildContext context) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MembershipDetailsScreen(
                                          documentId: slider.id ?? "",
                                        )));
                          },
                          child: showNetworkImageWithCached(
                              slider.hero_image_url ?? "", 24.h, 90.w, 10.0),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Column(
                            children: [
                              Text(
                                slider.title ?? "NA",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: boldTextStyle(
                                    size: 24, color: Colors.white),
                              ),
                              Text(
                                slider.desc ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: boldTextStyle(
                                    size: 14, color: Colors.white),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      state(() {
                        _current = index;
                      });
                    })),
          ),
          Positioned.directional(
              textDirection: Directionality.of(context),
              bottom: -14.0,
              end: 0,
              start: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.map((slider) {
                  int index = images.indexOf(slider);
                  return Container(
                    width: 8,
                    height: 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Colors.white
                            : Colors.grey.withOpacity(0.7)),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  });
}

Widget showNetworkImageWithCached(
    String imageUrl, double height, double width, double radius,
    {BoxFit fit = BoxFit.cover}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imageUrl,
    fit: fit,
    errorWidget: (c, a, b) {
      return Container(
        height: height,
        width: width,
        child: const Center(
          child: Icon(
            Icons.broken_image_outlined,
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.4),
            borderRadius: BorderRadius.circular(radius)),
      );
    },
    placeholder: (c, s) {
      return Container(
        height: height,
        width: width,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.orange,
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
            borderRadius: BorderRadius.circular(radius)),
      );
    },
  );
}
