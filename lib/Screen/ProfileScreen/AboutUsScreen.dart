
import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/values/Colors.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(ApiUrl.aboutus));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation:  0,
          automaticallyImplyLeading: false,

          leading:
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed:
                () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppColors.white,
          title: boldtext(AppColors.black, 16, "About Us"),
          centerTitle: true,

        ),
        body:   WebViewWidget(
            controller: controller)
    );
  }
}