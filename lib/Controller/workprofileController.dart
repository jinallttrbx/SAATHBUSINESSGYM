import 'dart:convert';


import 'package:businessgym/Utils/common_route.dart';
import 'package:businessgym/conts/global_values.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/ApiUrl.dart';
import '../../../Utils/SharedPreferences.dart';
import '../../../model/viewWork_profileModel.dart';
import '../../../values/Colors.dart';
import '../../../values/const_text.dart';

class WorkProfileController extends GetxController {
  RxList<ViewWorkProfileModelClass> viewWorkprofilelist =
  RxList<ViewWorkProfileModelClass>([]);
  List<ViewWorkProfileModelClass> viewWorkprofilelist2 = [];
  var viewWorkprofilehint = "Select Work Profile".obs;
  final SharedPreference _sharedPreference = SharedPreference();

  bool isLoading = false;

  viewworkProfile({bool? loader, String? id}) async {
    print(ApiUrl.workProfileListsURL);
    viewWorkprofilelist.value = [];
    isLoading = true;
    USERTOKKEN = await _sharedPreference.isToken();
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.workProfileListsURL),
        headers: {"Authorization": USERTOKKEN!, "Accept": "application/json"},
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      viewWorkprofilelist.value = [];
      viewWorkprofilelist2 = [];
      if (data['status'] == true) {
        final data = ViewWorkProfileModel.fromJson(jsonDecode(response.body));
        viewWorkprofilelist2 = data.data;
        viewWorkprofilelist.value = data.data;
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

      viewworkProfile(loader: true);
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
                        child: const Center(child: Text("No")),
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
                        child: const Center(child: Text("Yes")),
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
    // return await showDialog(
    //       //show confirm dialogue
    //       //the return value will be from "Yes" or "No" options
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(10))),
    //         title: boldtext(AppColors.DarkBlue, 18, 'Exit App', center: true),
    //         content: mediumtext(
    //             AppColors.DarkBlue, 14, 'Do you want to exit App?',
    //             center: true),
    //         actionsAlignment: MainAxisAlignment.center,

    //       ),
    //     ) ??
    //     false; //if showDialouge had returned null, then return false
  }

// @override
// void onInit() {
//   // TODO: implement onInit
//   super.onInit();
//   viewworkProfile();
// }
}
