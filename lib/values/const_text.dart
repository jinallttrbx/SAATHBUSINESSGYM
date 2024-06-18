// import 'package:flutter/material.dart';
//
//
// Widget boldtext(
//   Color tcolor,
//   double tsize,
//   String text, {
//   bool? center,
//   int? maxLines,
//   String? fontFamily,
//   TextOverflow? overFlow,
// }) {
//   return Text(
//     text,
//     textAlign: (center == true) ? TextAlign.center : TextAlign.left,
//     maxLines: maxLines,
//     style: TextStyle(
//       color: tcolor,
//       fontSize: tsize,
//       fontWeight: FontWeight.w600,
//       fontFamily: fontFamily ?? 'OpenSans',
//       overflow: overFlow,
//     ),
//   );
// }
//
// Widget regulartext(
//   Color tcolor,
//   double tsize,
//   String text, {
//   bool? center,
//   String? fontFamily,
//   int? maxLines,
//   TextOverflow? overFlow,
// }) {
//   return Text(
//     text,
//     textAlign: (center == true) ? TextAlign.center : TextAlign.left,
//     maxLines: maxLines,
//     style: TextStyle(
//       color: tcolor,
//       fontSize: tsize,
//       fontFamily: fontFamily ?? 'caviarlight',
//       fontWeight: FontWeight.normal,
//       overflow: overFlow,
//     ),
//   );
// }
//
// Widget mediumtext(Color tcolor, double tsize, String text, {bool? center}) {
//   return Text(
//     text,
//     textAlign: (center == true) ? TextAlign.center : TextAlign.left,
//     style: TextStyle(
//         color: tcolor,
//         fontSize: tsize,
//         fontFamily: 'OpenSans',
//         fontWeight: FontWeight.w500),
//   );
// }
//
// Widget lighttext(Color tcolor, double tsize, String text, {bool? center}) {
//   return Text(
//     text,
//     textAlign: (center == true) ? TextAlign.center : TextAlign.left,
//     style: TextStyle(color: tcolor, fontSize: tsize, fontFamily: 'caviarlight'),
//   );
// }
// Widget mediumtext1(Color tcolor, double tsize, String text, {bool? center}) {
//   return Text(
//     text,
//     textAlign: (center == true) ? TextAlign.center : TextAlign.left,
//     style: TextStyle(
//         color: tcolor,
//         fontSize: tsize,
//         fontFamily: 'OpenSans',
//         fontWeight: FontWeight.w400),
//   );
// }
//

import 'package:businessgym/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';


Widget regulartext(
  Color tcolor,
  double tsize,
  String text, {
  String? fontFamily,
}) {
  return Text(
    text,
    style: TextStyle(
      color: tcolor,
      fontSize: tsize,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.w500,
    ),
  );//.translate();
}
Widget regulartext1(
    Color tcolor,
    double tsize,
    String text, {
      String? fontFamily,
    }) {
  return Text(
    text,
    style: TextStyle(
      color: tcolor,
      fontSize: tsize,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.w600,
    ),
  );//.translate();
}
Widget boldtext(
  Color tcolor,
  double tsize,
  String text, {
  String? fontFamily,
}) {
  return Text(
    text,
    style: TextStyle(
      color: tcolor,
      fontSize: tsize,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.w600,
    ),
  );//.translate();
}

Widget bottomtexttitle(
  Color tcolor,
  double tsize,
  String text, {
  String? fontFamily,
}) {
  return Text(text,
      style: TextStyle(
        color: tcolor,
        fontSize: tsize,
        fontWeight: FontWeight.w500,
        fontFamily: "OpenSans",
      ));
}
Widget bottomtextdesc(
    Color tcolor,
    double tsize,
    String text, {
      String? fontFamily,
    }) {
  return Text(text,
      style: TextStyle(
        color: tcolor,
        fontSize: tsize,
        fontWeight: FontWeight.w600,
        fontFamily: "OpenSans",
      ));
     // .translate();
}

class CustomStyle {
  static TextStyle hinttext = const TextStyle(
    color: AppColors.hint,
    fontSize: 14,
    fontFamily: "OpenSans",
    fontWeight: FontWeight.w400,
  );
}
const hintstyle = TextStyle(color: Color(0xff808080), fontFamily: 'caviarbold');
const textstyle = TextStyle(color: Color(0xff000000), fontFamily: 'caviarbold');