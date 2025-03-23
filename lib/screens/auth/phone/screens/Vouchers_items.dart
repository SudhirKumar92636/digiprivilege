import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';

Widget VouchersItems(BuildContext context,
    {double? height,
    double? width,
    String? title,
    String? StartDate,
    String? ExpireDate,
    String? payment,
    String? OrderId}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white38, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  color: Colors.white,
                  height: height,
                  width: width,
                  child: const Image(
                    image: NetworkImage(
                      "https://media.istockphoto.com/photos/annual-ring-wood-texture-picture-id826345238?b=1&k=20&m=826345238&s=170667a&w=0&h=qt0Z4KQ7kY_dwM_J4fnsCMtIR89xCgaMO5VBeiK0p8w=",
                    ),
                    fit: BoxFit.cover,
                  )),
            ).paddingAll(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title!,
                    style: TextStyle(color: nightColor, fontSize: 15),
                  ),
                ).paddingTop(5),
                Text(
                  StartDate!,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ).paddingTop(5),
                Text(
                  ExpireDate!,
                  style: TextStyle(color: Colors.orange, fontSize: 15),
                ).paddingTop(5),
              ],
            )
          ],
        ),
        const Divider(
          height: 5,
          thickness: 1.5,
          color: Colors.white38,
        ).paddingTop(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              payment!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ).paddingRight(20),
            Text(
              OrderId!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ).paddingTop(20).paddingBottom(15).paddingLeft(10).paddingRight(10)
      ],
    ),
  ).paddingAll(15);
}