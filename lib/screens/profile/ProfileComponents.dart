import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

profileItemView(
  String expires,
  String title,
  String subtitle,
  String id,
  String active,
) {
  return Container(
          decoration: boxDecorationRoundedWithShadow(16,
              backgroundColor: Colors.grey.withOpacity(.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    expires,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        id,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    active,
                    style: TextStyle(
                        color: active.isApk ? Colors.white : Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ).paddingSymmetric(horizontal: 14, vertical: 10))
      .paddingSymmetric(horizontal: 10);
}