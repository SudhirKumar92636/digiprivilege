import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

profileItemViewEdit(String title, String subtitle, IconData leadingDataIcon) {
  return Container(
    decoration: boxDecorationRoundedWithShadow(16,
        backgroundColor: Colors.black.withOpacity(.5)),
    child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        title: Text(
          title,
          style: secondaryTextStyle(color: Colors.grey, size: 12),
        ),
        subtitle: Text(subtitle,
            style: boldTextStyle(
              color: white,
            )),
        trailing: Icon(
          leadingDataIcon,
          color: Colors.purple,
        )),
  );
}