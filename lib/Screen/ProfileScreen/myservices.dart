import 'package:businessgym/Controller/profileController.dart';

import 'package:businessgym/conts/appbar_global.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Screen/ProfileScreen/ProviderServiceScreen.dart';
import 'package:businessgym/Screen/ProfileScreen/productServices.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../values/Colors.dart';
import '../../values/const_text.dart';


import '../../Controller/workprofileController.dart';


class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  final _controller = PageController();

  final workcontroller = Get.find<WorkProfileController>();

  bool isView = true;
  String title="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (USER_TYPE == 'provider') {
      isView = false;
    }
    title="service";
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 2,
      child: Scaffold(

        appBar:
        APPBar(title: '',),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width,
                child: TabBar(
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: boldtext(AppColors.black,14,
                            "Services",
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.396,
                          child:  boldtext(AppColors.black,14,
                            "Products ",

                          ),
                        ),
                      )
                    ]),
              ),
            ),
            Flexible(
              child: TabBarView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  ProviderServiceScreen(),
                  ProductServices(),
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
}
