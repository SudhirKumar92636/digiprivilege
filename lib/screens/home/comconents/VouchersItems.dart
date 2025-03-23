import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

String url =
    "https://media.istockphoto.com/photos/annual-ring-wood-texture-picture-id826345238?b=1&k=20&m=826345238&s=170667a&w=0&h=qt0Z4KQ7kY_dwM_J4fnsCMtIR89xCgaMO5VBeiK0p8w=";

RoundeContainer(double height, double width, String url) {
  return Container(
    height: height,
    width: width,
    child: Image(
      image: NetworkImage(url),
      fit: BoxFit.cover,
    ),
  );
}

VochersText(String title, Color textColor, double fontSize) {
  return Text(
    title,
    style: TextStyle(color: textColor, fontSize: fontSize),
  ).paddingTop(5);
}

DescriptionText() {
  return Column(
    children: [
      Text("THIS BENEFIT IS VALID FOR "),
      Text("2 ADULTS & 2 KIDS UP TO 6 YEARS WITHOUT EXTRA BEDDING"),
    ],
  );
}
