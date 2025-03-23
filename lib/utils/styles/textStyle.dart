import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

TextStyle titleTextStyle() =>
    GoogleFonts.inter(color: white, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle smallTextStyle() => GoogleFonts.aBeeZee(color: Colors.white);

TextStyle inputLabelTextStyle() => GoogleFonts.aBeeZee(color: Colors.white);

TextStyle inputHintTextStyle() => GoogleFonts.aBeeZee(color: grey);

String rupee = '\u20B9';

Widget showAndHideText(String text,
    {double fontSize = 12, Color color = Colors.white}) {
  return ReadMoreText(
    text,
    trimLines: 2,
    trimMode: TrimMode.Line,
    trimCollapsedText: 'Show more',
    trimExpandedText: 'Show less',
    style: GoogleFonts.inter(color: color.withOpacity(.8), fontSize: fontSize),
    // moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    // lessStyle:const TextStyle(fontSize: 14, fontWeight: FontWeight.bold) ,
  );
}
