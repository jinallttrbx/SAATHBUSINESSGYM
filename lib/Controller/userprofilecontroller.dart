import 'dart:convert';

import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/model/ProductListModel.dart';
import 'package:businessgym/model/ProfileModel.dart';
import 'package:businessgym/model/ServiceListModel.dart';
import 'package:businessgym/model/ViewoccuaptionsModel.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Utils/ApiUrl.dart';
import '../Utils/SharedPreferences.dart';
import '../model/viewWork_profileModel.dart';
import '../values/Colors.dart';
import '../values/const_text.dart';

class UserProfileController extends GetxController {
 ProfileModelData? productprofilelist;
  ProfileModelData? productprofilelist2 ;
  var viewWorkprofilehint = "Select Work Profile".obs;
  final SharedPreference _sharedPreference = SharedPreference();
  bool isLoading = false;
 List<ViewoccuaptionsModelData>? viewoccuaptionsModelData = [];
 RxList<ViewoccuaptionsModelData> listData1 = RxList<ViewoccuaptionsModelData>([]);
 var currentOccupation = ''.obs;
 var usertype;
  viewprofile({bool? loader, String? id}) async {
    productprofilelist;
    isLoading = true;
    USERTOKKEN = await _sharedPreference.isToken();
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.view_profile),
        headers: {"Authorization": USERTOKKEN!, "Accept": "application/json"},
      );
      Map<String, dynamic> data = jsonDecode(response.body);

      productprofilelist;
      productprofilelist2 ;
      if (data['status'] == true) {
        final data = ProfileModel.fromJson(jsonDecode(response.body));
        productprofilelist2 = data!.data;
        productprofilelist = data.data;
        isLoading = false;
      }
      if (loader == true) {
        hideLoader();
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  removeWorkprofile(String id) async {
    showGetLoader();
    try {
      await http.post(
        Uri.parse(ApiUrl.deleteWorkProfile),
        headers: {"Authorization": USERTOKKEN!, "Accept": "application/json"},
        body: {"id": id},
      );

      viewprofile(loader: true);
    } catch (e) {
      print(e.toString());
    }
  }

  showExitPopup(String title, String value) async {
    Get.defaultDialog(
        title: "",
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              boldtext(
                AppColors.red,
                14,
                'Do Wants To Delete Occupation $title',
              ),
              vertical(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Card(
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.topLeft,
                        child:  Center(child: regulartext(AppColors.black,16,"No")),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      removeWorkprofile(value);
                    },
                    child: Card(
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.topLeft,
                        child:  Center(child: regulartext(AppColors.black,16,"Yes")),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        radius: 30);

  }


}
