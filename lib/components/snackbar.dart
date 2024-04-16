import 'package:businessgym/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class Methods1 {


  static Future<void> orderSuccessAlert(BuildContext context,String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(
            const Duration(seconds: 1),
                () => Navigator.of(context).pop(),
          );
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               Image.asset(AppImages.success),
                const SizedBox(
                    height: 10
                ),
                 Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ],
            ),
          );
        });
  }
  static Future<void> orderunSuccessAlert(BuildContext context,String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(
            const Duration(seconds: 1),
                () => Navigator.of(context).pop(),
          );
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.successnot),
                const SizedBox(
                    height: 10
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ],
            ),
          );
        });
  }
}
