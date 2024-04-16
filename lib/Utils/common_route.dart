import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loader_page.dart';

showGetLoader() {
  Get.defaultDialog(
      backgroundColor: Colors.transparent,
      radius: 0,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        width: 70,
        height: 70,
        child: CircularProgressIndicator(),
      ),
      title: '');
}

BuildContext? c;
showLoader(context) {
  // Get.defaultDialog(
  //   content: LoaderPage()
  // );
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      c = context;
      print("context" + c.toString());
      return LoaderPage();
    },
  );
}

hideLoader() {
  print("context1" + c.toString());
  Get.back();
}
